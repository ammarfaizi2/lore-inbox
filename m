Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVHIGfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVHIGfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 02:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHIGfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 02:35:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932370AbVHIGfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 02:35:52 -0400
Date: Mon, 8 Aug 2005 23:34:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
Message-Id: <20050808233429.36e6ebd5.akpm@osdl.org>
In-Reply-To: <200508082355.j78NtGNS029681@wscnet.wsc.cz>
References: <42F73523.80205@gmail.com>
	<200508082355.j78NtGNS029681@wscnet.wsc.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
>
> --- a/drivers/char/watchdog/i6300esb.c
>  +++ b/drivers/char/watchdog/i6300esb.c
>  @@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
>            *      Find the PCI device
>            */
>   
>  -        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
>  +        for_each_pci_dev(dev)
>                   if (pci_match_id(esb_pci_tbl, dev)) {
>                           esb_pci = dev;
>                           break;
>                   }
>  -        }
>   
>           if (esb_pci) {
>           	if (pci_enable_device(esb_pci)) {
>  @@ -430,6 +429,7 @@ err_release:
>   		pci_release_region(esb_pci, 0);
>   err_disable:
>   		pci_disable_device(esb_pci);
>  +		pci_dev_put(esb_pci);

That doesn't look right.  Each iteration of for_each_pci_dev() needs a
pci_dev_put(), not just the final one.
