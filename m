Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJBMwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJBMwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUJBMwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 08:52:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:65488 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265029AbUJBMwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 08:52:21 -0400
Date: Sat, 2 Oct 2004 14:52:20 +0200
From: Olaf Hering <olh@suse.de>
To: Alan Cox <alan@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: missing tty in sclp_tty.c and sclp_vt220.c
Message-ID: <20041002125220.GA19908@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

what 'tty' did you mean here? gcc says its undeclared.

should that be sclp_tty and sclp_vt220_tty?

diff -Nru a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
--- a/drivers/s390/char/sclp_tty.c      2004-09-29 20:07:09 -07:00
+++ b/drivers/s390/char/sclp_tty.c      2004-09-29 20:07:09 -07:00
@@ -277,10 +277,7 @@
        wake_up(&sclp_tty_waitq);
        /* check if the tty needs a wake up call */
        if (sclp_tty != NULL) {
-               if ((sclp_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-                   sclp_tty->ldisc.write_wakeup)
-                       (sclp_tty->ldisc.write_wakeup)(sclp_tty);
-               wake_up_interruptible(&sclp_tty->write_wait);
+               tty_wakeup(tty);
        }
 }

diff -Nru a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
--- a/drivers/s390/char/sclp_vt220.c    2004-09-29 20:06:20 -07:00
+++ b/drivers/s390/char/sclp_vt220.c    2004-09-29 20:06:20 -07:00
@@ -139,10 +139,7 @@
        wake_up(&sclp_vt220_waitq);
        /* Check if the tty needs a wake up call */
        if (sclp_vt220_tty != NULL) {
-               if ((sclp_vt220_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-                   (sclp_vt220_tty->ldisc.write_wakeup != NULL))
-                       (sclp_vt220_tty->ldisc.write_wakeup)(sclp_vt220_tty);
-               wake_up_interruptible(&sclp_vt220_tty->write_wait);
+               tty_wakeup(tty);
        }
 }



-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
