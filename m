Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUFFWAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUFFWAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUFFWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:00:25 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:9932 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264184AbUFFWAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:00:20 -0400
Date: Sun, 6 Jun 2004 23:00:01 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix missing padding in DMI table.
Message-ID: <20040606220001.GB7907@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This entry in the DMI blacklist table is missing it's NO_MATCH
tags, which means the struct gets padded instead of filled with
the desired NO_MATCH data which is {255, NULL}

Usually not fatal it seems, but there have been numerous cases
in Red Hat bugzilla where this did get tripped up, and caused
an immediate reset on these boards. Not fun to track down.

		Dave

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.6/arch/i386/kernel/dmi_scan.c~	2004-05-27 11:50:17.509303288 +0100
+++ linux-2.6.6/arch/i386/kernel/dmi_scan.c	2004-05-27 11:50:49.466445064 +0100
@@ -783,6 +783,7 @@
 	{ exploding_pnp_bios, "ASUS P4P800", {	/* PnPBIOS GPF on boot */
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
 			MATCH(DMI_BOARD_NAME, "P4P800"),
+			NO_MATCH, NO_MATCH
 			} },
 
 	/* Machines which have problems handling enabled local APICs */
