Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUBBTmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUBBTmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:42:24 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:3429 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265911AbUBBTmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:42:20 -0500
Date: Mon, 2 Feb 2004 20:42:19 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 7/42]
Message-ID: <20040202194219.GG6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cmdlinepart.c:345: warning: `mtdpart_setup' defined but not used

Function is not used when driver is modular.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/mtd/cmdlinepart.c linux-2.4/drivers/mtd/cmdlinepart.c
--- linux-2.4-vanilla/drivers/mtd/cmdlinepart.c	Fri Jun 13 16:51:34 2003
+++ linux-2.4/drivers/mtd/cmdlinepart.c	Sat Jan 31 16:57:32 2004
@@ -335,7 +335,7 @@
 	return -EINVAL;
 }
 
-
+#ifndef MODULE
 /* 
  * This is the handler for our kernel parameter, called from 
  * main.c::checksetup(). Note that we can not yet kmalloc() anything,
@@ -348,6 +348,7 @@
 }
 
 __setup("mtdparts=", mtdpart_setup);
+#endif
 
 EXPORT_SYMBOL(parse_cmdline_partitions);
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"I've seen things you people wouldn't believe...
 Attack Ships on fire off the shores of Orion.
 I've watched C-beams glitter in the dark off of Tanhauser Gate.
 All those moments will be lost in time...like tears, in rain.
 Time to die." -- Roy Batty (played by Rutger Hauer)
