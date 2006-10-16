Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWJPPBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWJPPBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJPPBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:01:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25289 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750760AbWJPPBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:01:07 -0400
Subject: [PATCH] nicstar: Fix a bogus casting warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:27:20 +0100
Message-Id: <1161012441.24237.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not enough to make Nicstar 64bit friendly but got squashed in passing so
might as well be applied

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/atm/nicstar.c linux-2.6.19-rc1-mm1/drivers/atm/nicstar.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/atm/nicstar.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/atm/nicstar.c	2006-10-13 17:17:57.000000000 +0100
@@ -2759,7 +2759,7 @@
 {
    ns_dev *card;
    pool_levels pl;
-   int btype;
+   long btype;
    unsigned long flags;
 
    card = dev->dev_data;
@@ -2859,7 +2859,7 @@
       case NS_ADJBUFLEV:
          if (!capable(CAP_NET_ADMIN))
 	    return -EPERM;
-         btype = (int) arg;	/* an int is the same size as a pointer */
+         btype = (long) arg;	/* a long is the same size as a pointer or bigger */
          switch (btype)
 	 {
 	    case NS_BUFTYPE_SMALL:

