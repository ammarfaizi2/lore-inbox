Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSLTWs4>; Fri, 20 Dec 2002 17:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSLTWs4>; Fri, 20 Dec 2002 17:48:56 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:38154 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S266319AbSLTWsz>;
	Fri, 20 Dec 2002 17:48:55 -0500
Date: Fri, 20 Dec 2002 14:52:51 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tiny ens1370.c warning fix, bk 2.5.52
Message-ID: <20021220225251.GA20406@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

	__devinitdata is in the wrong location in ens1370.c, so it's
apparently ignored by gcc and the struct isn't freed.  here's a small
patch to fix that.

-- DN
Daniel

--- ens1370.c.orig	Fri Dec 20 02:03:24 2002
+++ ens1370.c	Fri Dec 20 14:54:24 2002
@@ -1431,7 +1431,7 @@
 	unsigned short vid;		/* vendor ID */
 	unsigned short did;		/* device ID */
 	unsigned char rev;		/* revision */
-} __devinitdata es1371_spdif_present[] = {
+} es1371_spdif_present[] __dev_initdata = {
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_C },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_D },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_E },
