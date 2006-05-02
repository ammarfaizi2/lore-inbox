Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWEBGl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWEBGl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWEBGl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:41:27 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:980 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932392AbWEBGl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:41:26 -0400
Date: Tue, 2 May 2006 09:41:24 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH 2/3] ipg: leaks in ipg_probe
In-Reply-To: <20060501231050.GC7419@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.58.0605020936420.4066@sbz-30.cs.Helsinki.FI>
References: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
 <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
 <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo>
 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost>
 <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net>
 <1146506939.23931.2.camel@localhost> <20060501231050.GC7419@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Francois Romieu wrote:
> The error paths are badly broken.
> 
> Bonus:
> - remove duplicate initialization of sp;
> - remove useless NULL initialization of dev;
> - USE_IO_OPS is not used (and the driver does not seem to care about
>   posted writes, rejoice).
> 
> Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

Applied. Thanks! One comment below.

On Tue, 2 May 2006, Francois Romieu wrote:
> -	err = pci_request_regions(pdev, DRV_NAME);
> -	if (err)
> -		goto out;
> -
> -	pio_start = pci_resource_start(pdev, 0) & 0xffffff80;
> -	pio_len = pci_resource_len(pdev, 0);
> -	mmio_start = pci_resource_start(pdev, 1) & 0xffffff80;
> +	rc = pci_request_regions(pdev, DRV_NAME);
> +	if (rc)
> +		goto err_free_dev_1;

Is this tested with hardware? Alignment of the start address looks bogus 
for sure, but any idea why they had it in the first place?

				Pekka
