Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270931AbUJVJkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbUJVJkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270877AbUJVJiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:38:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28345 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S270942AbUJVJfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:35:54 -0400
Date: Fri, 22 Oct 2004 11:34:23 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: [PATCH] Quota warnings somewhat broken
Message-ID: <20041022093423.GC31932@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> When a user exceeds his soft (and hard) disk quota, a warning message is
> printed to current->tty. However, output is a bit offset:
> 
> $ dd if=/dev/zero of=blk bs=1024 count=100000
> hda1: write failed, user block limit reached.
>                                              dd: opening `blk': Disk quota exceeded
> 
> This is due to the messages in fs/dquot.c only ending in "\n" but should
> probably end in "\r\n".
  Thanks for notifying. It looks like a good idea. Attached patch should apply
well to 2.6.9. Linus, please apply.

									Honza

Fix end of lines in quota messages.
Signed-off-by: Jan Kara

diff -ru linux-2.6.8.1/fs/dquot.c linux-2.6.8.1-messfix/fs/dquot.c
--- linux-2.6.8.1/fs/dquot.c	2004-10-19 12:07:08.000000000 +0200
+++ linux-2.6.8.1-messfix/fs/dquot.c	2004-10-22 11:28:26.678037906 +0200
@@ -811,22 +811,22 @@
 	tty_write_message(current->signal->tty, quotatypes[dquot->dq_type]);
 	switch (warntype) {
 		case IHARDWARN:
-			msg = " file limit reached.\n";
+			msg = " file limit reached.\r\n";
 			break;
 		case ISOFTLONGWARN:
-			msg = " file quota exceeded too long.\n";
+			msg = " file quota exceeded too long.\r\n";
 			break;
 		case ISOFTWARN:
-			msg = " file quota exceeded.\n";
+			msg = " file quota exceeded.\r\n";
 			break;
 		case BHARDWARN:
-			msg = " block limit reached.\n";
+			msg = " block limit reached.\r\n";
 			break;
 		case BSOFTLONGWARN:
-			msg = " block quota exceeded too long.\n";
+			msg = " block quota exceeded too long.\r\n";
 			break;
 		case BSOFTWARN:
-			msg = " block quota exceeded.\n";
+			msg = " block quota exceeded.\r\n";
 			break;
 	}
 	tty_write_message(current->signal->tty, msg);
