Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTK3TAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTK3TAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:00:47 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:1980 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S262782AbTK3TAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:00:45 -0500
Message-ID: <35356.68.105.173.45.1070219694.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 30 Nov 2003 14:14:54 -0500 (EST)
Subject: [PATCH 2.6.0-test11] agpgart [amd64] fix (off by one)
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AGPGart would report "Too many northbridges" without this
patch. The problem was that 'i' was incremented before being
checked against the MAX GARTS, just making the check > instead
of == fixes the problems.  Patch here:

http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.7/101_amd64_agpgart_fix.patch


Also inlined below.
Please CC me on any replies

-Brad House
brad_mssw@gentoo.org


diff -ruN linux-2.6.0-test11.old/drivers/char/agp/amd64-agp.c
linux-2.6.0-test11/drivers/char/agp/amd64-agp.c
--- linux-2.6.0-test11.old/drivers/char/agp/amd64-agp.c	2003-11-26
15:44:44.000000000 -0500
+++ linux-2.6.0-test11/drivers/char/agp/amd64-agp.c	2003-11-30
14:07:38.690330488 -0500
@@ -357,7 +357,7 @@
 		}
 		hammers[i++] = loop_dev;
 		nr_garts = i;
-		if (i == MAX_HAMMER_GARTS) {
+		if (nr_garts > MAX_HAMMER_GARTS) {
 			printk(KERN_INFO PFX "Too many northbridges for AGP\n");
 			return -1;
 		}



