Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUFCUDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUFCUDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUFCUDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:03:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:24308 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263740AbUFCUDG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:03:06 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:kernel BUG at mm/page_alloc.c:786!
Date: Thu, 3 Jun 2004 22:02:46 +0200
User-Agent: KMail/1.6.2
Cc: andreamrl@tiscali.it, ipw2100-admin@linux.intel.com
References: <200406032001.34172.andreamrl@tiscali.it> <200406032118.32794.linux-kernel@borntraeger.net>
In-Reply-To: <200406032118.32794.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406032203.00290.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:
> This function looks bogus: If ipw2100_tx_allocate fails, ipw2100_rx_free
> is called. Unfortunately the ipw2100_rx_allocate function was never
> called.

I just check the original mail:
actually ipw2100_rx_allocate fails to allocate memory. ipw2100_rx_free is 
called nevertheless, which IMHO caused the bug message.

andreamrl@tiscali.it wrote:
> modprobe: page allocation failure. order:0, mode:0x20
> Call Trace:
>  [<c013afc1>] __alloc_pages+0x2e1/0x320
>  [<c013b01f>] __get_free_pages+0x1f/0x40
>  [<c013e507>] cache_grow+0xa7/0x290
>  [<c013e7be>] cache_alloc_refill+0xce/0x210
>  [<c013ebe9>] __kmalloc+0x69/0x70
>  [<c03252f7>] alloc_skb+0x47/0xf0
>  [<d0f3c880>] ipw2100_rx_allocate+0x140/0x2f0 [ipw2100]
>  [<d0f3dfaf>] ipw2100_queues_allocate+0x1f/0x60 [ipw2100]
>  [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
>  [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
>  [<c021c202>] pci_device_probe_static+0x52/0x70
>  [<c021c25c>] __pci_device_probe+0x3c/0x50


