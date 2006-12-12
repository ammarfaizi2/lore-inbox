Return-Path: <linux-kernel-owner+w=401wt.eu-S932399AbWLLTcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWLLTcV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWLLTcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:32:21 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:59860 "EHLO
	mx4.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932399AbWLLTcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:32:21 -0500
Date: Tue, 12 Dec 2006 11:32:16 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Yan Burman <burman.yan@gmail.com>
cc: linux-kernel@vger.kernel.org, auke-jan.h.kok@intel.com
Subject: Re: [PATCH 2.6.19] e1000: Replace kmalloc+memset with kcalloc +
 remove now unused size variable
In-Reply-To: <1165950539.10231.3.camel@localhost>
Message-ID: <Pine.LNX.4.64N.0612121128250.13648@attu4.cs.washington.edu>
References: <1165950539.10231.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006, Yan Burman wrote:

> diff -rubp linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c linux-2.6.19/drivers/net/e1000/e1000_ethtool.c
> --- linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c	2006-11-30 21:28:21.000000000 +0200
> +++ linux-2.6.19/drivers/net/e1000/e1000_ethtool.c	2006-12-12 20:54:31.000000000 +0200
> @@ -1045,19 +1045,18 @@ e1000_setup_desc_rings(struct e1000_adap
>  	struct e1000_rx_ring *rxdr = &adapter->test_rx_ring;
>  	struct pci_dev *pdev = adapter->pdev;
>  	uint32_t rctl;
> -	int size, i, ret_val;
> +	int i, ret_val;
>  
>  	/* Setup Tx descriptor ring and Tx buffers */
>  
>  	if (!txdr->count)
>  		txdr->count = E1000_DEFAULT_TXD;
>  
> -	size = txdr->count * sizeof(struct e1000_buffer);
> -	if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
> +	if (!(txdr->buffer_info = kcalloc(size, sizeof(struct e1000_buffer),
> +					GFP_KERNEL))) {

This wasn't compile-tested; you already removed the 'size' auto variable.

Needs to be
	kcalloc(txdr->count, sizeof(struct e1000_buffer), GFP_KERNEL)
