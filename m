Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280456AbRKEKV3>; Mon, 5 Nov 2001 05:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280452AbRKEKVK>; Mon, 5 Nov 2001 05:21:10 -0500
Received: from 20dyn88.com21.casema.net ([213.17.90.88]:51389 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S280450AbRKEKVJ>; Mon, 5 Nov 2001 05:21:09 -0500
Date: Mon, 5 Nov 2001 11:20:21 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ATM mailing list 
	<linux-atm-general@lists.sourceforge.net>,
        <Mitch@sfgoth.com>
Subject: [PATCH] Firestream
Message-ID: <Pine.LNX.4.33.0111051114180.14385-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux, Alan,

This patch fix a serious bug in the fs_open function that allow the driver
to use more than 32 channels where there are only 32 channels.

	Patrick

diff -u -r /usr/src/linux-2.4.13-ac7.clean/drivers/atm/firestream.c /usr/src/linux-2.4.13-ac7.firestream/drivers/atm/firestream.c
--- /usr/src/linux-2.4.13-ac7.clean/drivers/atm/firestream.c	Mon Nov  5 11:10:45 2001
+++ /usr/src/linux-2.4.13-ac7.firestream/drivers/atm/firestream.c	Mon Nov  5 11:13:18 2001
@@ -912,6 +912,9 @@
 		if (IS_FS50(dev)) {
 			/* Increment the channel numer: take a free one next time.  */
 			for (to=33;to;to--, dev->channo++) {
+				/* We only have 32 channels */
+				if (dev->channo >= 32)
+					dev->channo = 0;
 				/* If we need to do RX, AND the RX is inuse, try the next */
 				if (DO_DIRECTION(rxtp) && dev->atm_vccs[dev->channo])
 					continue;

