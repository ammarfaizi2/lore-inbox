Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbTF3WW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTF3WW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:22:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16329 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265932AbTF3WWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:22:14 -0400
Date: Tue, 1 Jul 2003 00:36:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What did I miss?
Message-ID: <20030630223627.GL282@fs.tum.de>
References: <20030630161112.GB24137@rdlg.net> <20030630184733.GI282@fs.tum.de> <20030630185413.GE24137@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630185413.GE24137@rdlg.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 02:54:13PM -0400, Robert L. Harris wrote:
> 
> Attaching, and thanks for taking the time to poke this.

Thanks, a fix is below.

The problem is in the BCM4400 driver -ac adds. bcm4400_remove_one is 
__devexit but the pointer to it didn't use __devexit_p resulting in a
.text.exit error if CONFIG_HOTPLUG is disabled.

cu
Adrian


--- drivers/net/bcm4400/b44um.c.old	2003-07-01 00:23:01.000000000 +0200
+++ drivers/net/bcm4400/b44um.c	2003-07-01 00:26:07.000000000 +0200
@@ -1019,7 +1019,7 @@
 	name:		bcm4400_driver,
 	id_table:	bcm4400_pci_tbl,
 	probe:		bcm4400_init_one,
-	remove:		bcm4400_remove_one,
+	remove:		__devexit_p(bcm4400_remove_one),
 	suspend:	bcm4400_suspend,
 	resume:		bcm4400_resume,
 };
