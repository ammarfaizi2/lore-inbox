Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUKUWq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUKUWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbUKUWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:46:14 -0500
Received: from mail.dif.dk ([193.138.115.101]:4054 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261828AbUKUWp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:45:58 -0500
Date: Sun, 21 Nov 2004 23:55:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
Message-ID: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch removes a pointless comparison. "arg" is an unsigned long, thus 
it can never be <0, so testing that is pointless.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/fs/fcntl.c linux-2.6.10-rc2-bk6/fs/fcntl.c
--- linux-2.6.10-rc2-bk6-orig/fs/fcntl.c	2004-11-17 01:20:14.000000000 +0100
+++ linux-2.6.10-rc2-bk6/fs/fcntl.c	2004-11-21 23:49:20.000000000 +0100
@@ -340,7 +340,7 @@ static long do_fcntl(int fd, unsigned in
 		break;
 	case F_SETSIG:
 		/* arg == 0 restores default behaviour. */
-		if (arg < 0 || arg > _NSIG) {
+		if (arg > _NSIG) {
 			break;
 		}
 		err = 0;


