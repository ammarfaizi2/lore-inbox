Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUIAVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUIAVgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267987AbUIAVGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:06:34 -0400
Received: from baikonur.stro.at ([213.239.196.228]:63172 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267958AbUIAU4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:39 -0400
Subject: [patch 11/25]  drivers/char/selection.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:38 +0200
Message-ID: <E1C2c9n-0007Mz-5O@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/selection.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

diff -puN drivers/char/selection.c~min-max-char_selection drivers/char/selection.c
--- linux-2.6.9-rc1-bk7/drivers/char/selection.c~min-max-char_selection	2004-09-01 19:34:10.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/selection.c	2004-09-01 19:34:10.000000000 +0200
@@ -26,10 +26,6 @@
 #include <linux/tiocl.h>
 #include <linux/console.h>
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
 #define isspace(c)	((c) == ' ')
 
@@ -295,7 +291,7 @@ int paste_selection(struct tty_struct *t
 			continue;
 		}
 		count = sel_buffer_lth - pasted;
-		count = MIN(count, tty->ldisc.receive_room(tty));
+		count = min(count, tty->ldisc.receive_room(tty));
 		tty->ldisc.receive_buf(tty, sel_buffer + pasted, NULL, count);
 		pasted += count;
 	}

_
