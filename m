Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTAITrd>; Thu, 9 Jan 2003 14:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267728AbTAITrd>; Thu, 9 Jan 2003 14:47:33 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:18439 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S267720AbTAITrc>;
	Thu, 9 Jan 2003 14:47:32 -0500
Date: Thu, 9 Jan 2003 11:51:05 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tiny ens1370.c warning fix, bk 2.5.52]
Message-ID: <20030109195105.GA18833@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Resend of a patch

	__devinitdata is in the wrong location in ens1370.c, so it's
apparently ignored by gcc and the struct isn't freed.  Here's a small
patch to fix that.

	Linus, please apply.

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
