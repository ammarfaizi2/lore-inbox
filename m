Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVA0GDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVA0GDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVA0GDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:03:45 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:6017 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262489AbVA0GDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:03:39 -0500
Message-ID: <D39C8B3D64A0D511A61E00D0B7828EEA1205627A@zil05exm01.ea.freescale.net>
From: Eyal Ofer-R55413 <Ofer.Eyal@freescale.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ppc 8260 ethernet driver fails to put port into promiscuous or mu
	lticast modes 
Date: Thu, 27 Jan 2005 08:03:29 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

1. the function in the ppc 8260 ethernet driver that's suppose to put the interface into promiscuous or multicast modes contains a 'return' statement immediately at the beginning. this prevents running an 8260-based system as a bridge for example. the 'return' statement is not indented, and there's no comment to explain it. it is unclear if it was forgotten there by the writer or whether it serves some functional role (improve performance for other modes of operations, cover up for untested code later, etc.). removing it does not seem to hurt the operation of the system though. unless there's a known use for this 'return', i would like to suggest the following patch (demonstrated here for 2.4.22):


--- fcc_enet.c.orig	Thu Jan 27 07:56:35 2005
+++ fcc_enet.c	Thu Jan 27 07:57:00 2005
@@ -1080,7 +1080,6 @@
 
 	cep = (struct fcc_enet_private *)dev->priv;
 
-return;
 	/* Get pointer to FCC area in parameter RAM.
 	*/
 	ep = (fcc_enet_t *)dev->base_addr;



problem persists ever since the driver's introduction into the 2.4.0-test9-pre2 kernel and up to it's latest version in 2.6.10

path to problem:
early 2.4.x and all 2.6.x:
	arch/ppc/8260_io/fcc_enet.c
later 2.4.2x (at least 2.4.26 and on):
	arc/ppc/cpm_io/fcc_enet.c

problem in function: set_multicast_list()


2. please CC me personally on answer as i'm not a subscriber on the lkml.


best regards,
ofer eyal


