Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVCBWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVCBWJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVCBWHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:07:21 -0500
Received: from tantale.fifi.org ([64.81.251.130]:28298 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262479AbVCBWAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:00:32 -0500
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux@syskonnect.de
Subject: 2.4.29 sk98lin patch for Asus K8W SE Deluxe 
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 02 Mar 2005 14:00:30 -0800
Message-ID: <873bvdbtdt.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EEPROM (or whatever that is) on Asus K8V SE Deluxe motherboards
contains buggy firmware.  This buggy firmware has one flipped bit, and
causes the sk98lin driver refuses to work correctly.  Please look at
this thread:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0404.0/1439.html

It contains a patch for 2.6 that fixs the problem.  Enclosed is a copy
of this patch for 2.4.29.  Please consider applying.

Phil.

Signed-Off-By: Philippe Troin <phil@fifi.rog>

diff -ruN linux-2.4.29.orig/drivers/net/sk98lin/skvpd.c linux-2.4.29/drivers/net/sk98lin/skvpd.c
--- linux-2.4.29.orig/drivers/net/sk98lin/skvpd.c	Wed Apr 14 06:05:30 2004
+++ linux-2.4.29/drivers/net/sk98lin/skvpd.c	Mon Feb 21 02:03:00 2005
@@ -466,6 +466,15 @@
 	
 	pAC->vpd.vpd_size = vpd_size;
 
+	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
+	/* MBo April 2004 */
+	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
+	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
+		printk("sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
+		(unsigned char)pAC->vpd.vpd_buf[0x40] = 0x38;
+	}
+
 	/* find the end tag of the RO area */
 	if (!(r = vpd_find_para(pAC, VPD_RV, &rp))) {
 		SK_DBG_MSG(pAC, SK_DBGMOD_VPD, SK_DBGCAT_ERR | SK_DBGCAT_FATAL,
