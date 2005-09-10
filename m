Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVIJWxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVIJWxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIJWxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:53:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932319AbVIJWxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:53:41 -0400
Date: Sat, 10 Sep 2005 15:53:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, dwmw2@infradead.org,
       stern@rowland.harvard.edu, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <20050910153110.36a44eba.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
 <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com>
 <20050910153110.36a44eba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Andrew Morton wrote:
> 
> Who do I bug about these longstanding ppc64 warnings, btw ;)
> 
> drivers/scsi/sata_svw.c: In function `k2_sata_tf_load':
> drivers/scsi/sata_svw.c:111: warning: passing arg 2 of `eeh_writeb' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:116: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:117: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast

I used to have a patch to fix them, and sent it to Jeff ages ago. At that 
point, he didn't want to use the iomap() functionality, but maybe that has 
changed.

Jeff? It requires making almost all the SATA IO base pointers be iomapped: 
the current

	struct ata_ioports {
	        unsigned long           cmd_addr;
	        unsigned long           data_addr;
		...

would have to become

	struct ata_ioports {
		void __iomem *cmd_addr;
		void __iomem *data_addr;
		...

instead - and initialized with the proper ioport_map() or pci_iomap() as 
appropriate.

		Linus
