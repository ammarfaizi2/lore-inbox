Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUBBTsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUBBTrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:47:40 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:51313 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265961AbUBBTrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:47:18 -0500
Date: Mon, 2 Feb 2004 20:47:16 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 17/42]
Message-ID: <20040202194716.GQ6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


g_NCR5380.c:212: warning: `do_NCR5380_setup' defined but not used
g_NCR5380.c:230: warning: `do_NCR53C400_setup' defined but not used
g_NCR5380.c:248: warning: `do_NCR53C400A_setup' defined but not used
g_NCR5380.c:266: warning: `do_DTC3181E_setup' defined but not used

These functions are used to handle boot params and are useless when the
driver is modular.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/g_NCR5380.c linux-2.4/drivers/scsi/g_NCR5380.c
--- linux-2.4-vanilla/drivers/scsi/g_NCR5380.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/scsi/g_NCR5380.c	Sat Jan 31 17:36:59 2004
@@ -146,6 +146,7 @@
 
 #define NO_OVERRIDES (sizeof(overrides) / sizeof(struct override))
 
+#ifndef MODULE
 /**
  *	internal_setup		-	handle lilo command string override
  *	@board:	BOARD_* identifier for the board
@@ -270,6 +271,7 @@
 	internal_setup(BOARD_DTC3181E, str, ints);
 	return 1;
 }
+#endif
 
 /**
  * 	generic_NCR5380_detect	-	look for NCR5380 controllers

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein
