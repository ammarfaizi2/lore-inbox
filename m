Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbTCFVrk>; Thu, 6 Mar 2003 16:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268412AbTCFVrj>; Thu, 6 Mar 2003 16:47:39 -0500
Received: from wpax13.physik.uni-wuerzburg.de ([132.187.42.13]:25618 "EHLO
	wpax13.physik.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id <S268402AbTCFVri>; Thu, 6 Mar 2003 16:47:38 -0500
Date: Thu, 6 Mar 2003 22:58:09 +0100 (MET)
From: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, mantel@suse.de
Subject: ioremap off by one bug
Message-ID: <Pine.GHP.4.21.0303062253390.5677-100000@wpax13.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

we have found an off by one bug in ioremap.
The following patch fixes the problem.

--- arch/i386/mm/ioremap.c.orig	2003-03-06 23:16:12.000000000 +0100
+++ arch/i386/mm/ioremap.c	2003-03-06 23:16:30.000000000 +0100
@@ -142,7 +142,7 @@
 	 */
 	offset = phys_addr & ~PAGE_MASK;
 	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr) - phys_addr;
+	size = PAGE_ALIGN(last_addr+1) - phys_addr;
 
 	/*
 	 * Ok, go for it..


bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de
   root / webmaster @cip.physik.uni-wuerzburg.de
   root / webmaster @www.physik.uni-wuerzburg.de
_____________________________________
|                                   | 
|   Long live our gracious AMIGA!   |
|___________________________________|



