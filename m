Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWF0V5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWF0V5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWF0V5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:57:54 -0400
Received: from mail.gmx.net ([213.165.64.21]:15570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030398AbWF0V5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:57:53 -0400
X-Authenticated: #704063
Subject: [Patch] Off by one in drivers/block/floppy.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 27 Jun 2006 23:57:49 +0200
Message-Id: <1151445469.15166.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another bug spotted by coverity (id #481).
In the case that drive == N_DRIVE we acess past the
drive_params array which is defined as 
drive_params[N_DRIVE]. By using the UDP define
in the else case because UDP is &drive_params[drive]

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/block/floppy.c.orig	2006-06-27 23:49:22.000000000 +0200
+++ linux-2.6.17-git11/drivers/block/floppy.c	2006-06-27 23:49:40.000000000 +0200
@@ -684,7 +684,7 @@ static void __reschedule_timeout(int dri
 	if (drive == current_reqD)
 		drive = current_drive;
 	del_timer(&fd_timeout);
-	if (drive < 0 || drive > N_DRIVE) {
+	if (drive < 0 || drive > N_DRIVE-1) {
 		fd_timeout.expires = jiffies + 20UL * HZ;
 		drive = 0;
 	} else


