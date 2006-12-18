Return-Path: <linux-kernel-owner+w=401wt.eu-S1754757AbWLRX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbWLRX1k (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbWLRX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:27:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58047 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbWLRX1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:27:39 -0500
Date: Mon, 18 Dec 2006 15:27:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] Char: isicom, fix probe race
Message-Id: <20061218152730.0d86c4c7.akpm@osdl.org>
In-Reply-To: <29302220751300732488@wsc.cz>
References: <2880031291415520798@wsc.cz>
	<29302220751300732488@wsc.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 02:09:48 +0100 (CET)
Jiri Slaby <jirislaby@gmail.com> wrote:

> isicom, fix probe race
> 
> Fix two race conditions in the probe function with mutex.
> 
> ...
>
>  static int __devinit isicom_probe(struct pci_dev *pdev,
>  	const struct pci_device_id *ent)
>  {
> +	static DEFINE_MUTEX(probe_lock);

hm.  How can isicom_probe() race with itself?  Even with the dreaded
multithreaded-pci-probing?  It's only called once, by a single thread.

Confused.
