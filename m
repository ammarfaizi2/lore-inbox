Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUBBSXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUBBSWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:22:08 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:40260 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265791AbUBBSVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:21:52 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 19:21:50 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 4/42]
Message-ID: <20040202182150.GD6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aha1542.c:114: warning: `setup_str' defined but not used

Move setup_str inside #ifndef MODULE. The string in not used when the
driver is compiled statically.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/aha1542.c linux-2.4/drivers/scsi/aha1542.c
--- linux-2.4-vanilla/drivers/scsi/aha1542.c	Sat Oct 13 00:35:53 2001
+++ linux-2.4/drivers/scsi/aha1542.c	Sat Jan 31 16:25:17 2004
@@ -111,8 +111,6 @@
 static int setup_busoff[MAXBOARDS];
 static int setup_dmaspeed[MAXBOARDS] __initdata = { -1, -1, -1, -1 };
 
-static char *setup_str[MAXBOARDS] __initdata;
-
 /*
  * LILO/Module params:  aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]
  *
@@ -960,6 +958,7 @@
 
 #ifndef MODULE
 static int setup_idx = 0;
+static char *setup_str[MAXBOARDS] __initdata;
 
 void __init aha1542_setup(char *str, int *ints)
 {

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.
