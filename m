Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbUJ2NHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUJ2NHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUJ2NHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:07:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:14747 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263307AbUJ2NHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:07:36 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Print real error when initramfs gunzip failed
Message-Id: <20041029130640.995EB9DEE36E@verdi.suse.de>
Date: Fri, 29 Oct 2004 15:06:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Print the real error when initramfs gunzip failed. gunzip already
sets up message correctly.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/init/initramfs.c
===================================================================
--- linux.orig/init/initramfs.c	2004-08-15 19:45:53.%N +0200
+++ linux/init/initramfs.c	2004-10-21 19:47:46.%N +0200
@@ -445,8 +445,7 @@
 		bytes_out = 0;
 		crc = (ulg)0xffffffffL; /* shift register contents */
 		makecrc();
-		if (gunzip())
-			message = "ungzip failed";
+		gunzip();
 		if (state != Reset)
 			error("junk in gzipped archive");
 		this_header = saved_offset + inptr;
