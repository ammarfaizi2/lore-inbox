Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVCTKRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVCTKRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVCTKQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:16:41 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:36783 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262110AbVCTKOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:44 -0500
Subject: [PATCH][6/5] Bonus: unrelated minor cleanup of enum pid_directory_inos
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.aedaC.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup: remove PROC_TGID_FD_DIR because it's unused.  Also put
PROC_TID_FD_DIR at the end of the enum to avoid clashing of the FD
range (as noted in the comment) with PROC_TID_OOM_SCORE and
PROC_TID_OOM_ADJUST.  It's not a _problem_, because FD links and
these OOM related files are in different directories.  It is
certainly untidy.

diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-03-19 22:16:48.000000000 +0100
+++ l2/fs/proc/base.c	2005-03-19 22:16:59.000000000 +0100
@@ -84,7 +84,6 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TGID_LOGINUID,
 #endif
-	PROC_TGID_FD_DIR,
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
 	PROC_TID_INO,
@@ -121,9 +120,9 @@ enum pid_directory_inos {
 #ifdef CONFIG_AUDITSYSCALL
 	PROC_TID_LOGINUID,
 #endif
-	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
 
 struct pid_entry {

