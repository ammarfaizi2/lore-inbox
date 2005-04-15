Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVDOBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDOBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDOBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:04:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:44165 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261689AbVDOBEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:04:54 -0400
Date: Fri, 15 Apr 2005 03:07:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Message-ID: <Pine.LNX.4.62.0504150303480.3466@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'arg' is unsigned so it can never be less than zero, so testing for that 
is pointless and also generates a warning when building with gcc -W. This 
patch eliminates the pointless check.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/fs/fcntl.c	2005-04-11 21:20:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/fcntl.c	2005-04-15 03:03:00.000000000 +0200
@@ -308,7 +308,7 @@ static long do_fcntl(int fd, unsigned in
 		break;
 	case F_SETSIG:
 		/* arg == 0 restores default behaviour. */
-		if (arg < 0 || arg > _NSIG) {
+		if (arg > _NSIG) {
 			break;
 		}
 		err = 0;

