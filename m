Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVCSS4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVCSS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVCSS4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:56:25 -0500
Received: from mail.dif.dk ([193.138.115.101]:55761 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261728AbVCSS4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:56:23 -0500
Date: Sat, 19 Mar 2005 19:58:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove redundant NULL check before before kfree() in
 kernel/sysctl.c
Message-ID: <Pine.LNX.4.62.0503191954100.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tiny patch to remove a redundant check for NULL pointer before calling kfree().

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/kernel/sysctl.c linux-2.6.11-mm4/kernel/sysctl.c
--- linux-2.6.11-mm4-orig/kernel/sysctl.c	2005-03-16 15:45:40.000000000 +0100
+++ linux-2.6.11-mm4/kernel/sysctl.c	2005-03-19 19:52:18.000000000 +0100
@@ -991,8 +991,7 @@ int do_sysctl(int __user *name, int nlen
 		int error = parse_table(name, nlen, oldval, oldlenp, 
 					newval, newlen, head->ctl_table,
 					&context);
-		if (context)
-			kfree(context);
+		kfree(context);
 		if (error != -ENOTDIR)
 			return error;
 		tmp = tmp->next;


