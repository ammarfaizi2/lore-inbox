Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319575AbSH3Otv>; Fri, 30 Aug 2002 10:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319576AbSH3Otv>; Fri, 30 Aug 2002 10:49:51 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:5261 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S319575AbSH3Otu>; Fri, 30 Aug 2002 10:49:50 -0400
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: [Patch] Futex misses kill_sb
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 30 Aug 2002 16:52:37 +0200
Message-ID: <wrpptw05rgq.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The enclosed patch fixes a missing .kill_sb in futexes' fs_type
declaration. Without this patch, kernel oopses if someone ever tries
to mount futexfs...

Thanks for any comments.

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.542   -> 1.543  
#	      kernel/futex.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	maz@if.wild-wind.fr.eu.org	1.543
# futex.c:
#   Fixed missing .kill_sb
# --------------------------------------------
#
diff -Nru a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	Fri Aug 30 19:26:44 2002
+++ b/kernel/futex.c	Fri Aug 30 19:26:44 2002
@@ -359,6 +359,7 @@
 static struct file_system_type futex_fs_type = {
 	.name		= "futexfs",
 	.get_sb		= futexfs_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static int __init init(void)

-- 
Places change, faces change. Life is so very strange.
