Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287945AbSAMSqr>; Sun, 13 Jan 2002 13:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287656AbSAMSqh>; Sun, 13 Jan 2002 13:46:37 -0500
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:5135 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S287488AbSAMSq3>; Sun, 13 Jan 2002 13:46:29 -0500
Message-ID: <3C41D5D1.93FA2C05@easynet.be>
Date: Sun, 13 Jan 2002 19:45:37 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Paul Bristow <paul@paulbristow.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]: fix-up ide-floppy in 2.5.2-preX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for a bug introduced probably in 2.5.2-pre1.
The patch apply against 2.5.2-pre11.

diff -ur linux-2.5.2-pre11/drivers/ide/ide-floppy.c
linux/drivers/ide/ide-floppy.c
--- linux-2.5.2-pre11/drivers/ide/ide-floppy.c  Sat Jan 12 22:09:48 2002
+++ linux/drivers/ide/ide-floppy.c      Sun Jan 13 17:47:27 2002
@@ -680,7 +680,7 @@
        /* Why does this happen? */
        if (!rq)
                return;
-       if (rq->flags & IDEFLOPPY_RQ) {
+       if (!(rq->flags & IDEFLOPPY_RQ)) {
                ide_end_request (uptodate, hwgroup);
                return;
        }

-- 
Luc Van Oostenryck
