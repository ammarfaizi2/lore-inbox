Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbULWAsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbULWAsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 19:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbULWAp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 19:45:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17933 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262101AbULWAhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 19:37:21 -0500
Date: Thu, 23 Dec 2004 01:37:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_io.c: misc cleanups (fwd)
Message-ID: <20041223003719.GH5217@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 5 Dec 2004 18:23:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/tty_io.c: misc cleanups

The patch below contains the following cleanups:
- remove the unused global function tty_push_data
- make some needlessly global functions static


diffstat output:
 drivers/char/tty_io.c |   28 +++-------------------------
 1 files changed, 3 insertions(+), 25 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/tty_io.c.old	2004-11-07 01:25:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/tty_io.c	2004-11-07 01:28:36.000000000 +0100
@@ -327,7 +327,7 @@
 	
 EXPORT_SYMBOL_GPL(tty_ldisc_put);
 
-void tty_ldisc_assign(struct tty_struct *tty, struct tty_ldisc *ld)
+static void tty_ldisc_assign(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	tty->ldisc = *ld;
 	tty->ldisc.refcount = 0;
@@ -583,7 +583,7 @@
 /*
  * This routine returns a tty driver structure, given a device number
  */
-struct tty_driver *get_tty_driver(dev_t device, int *index)
+static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
 
@@ -744,7 +744,7 @@
  * but doesn't hold any locks, so we need to make sure we have the appropriate
  * locks for what we're doing..
  */
-void do_tty_hangup(void *data)
+static void do_tty_hangup(void *data)
 {
 	struct tty_struct *tty = (struct tty_struct *) data;
 	struct file * cons_filp = NULL;
@@ -2504,28 +2504,6 @@
 }
 
 /*
- *	Call the ldisc flush directly from a driver. This function may
- *	return an error and need retrying by the user.
- */
-
-int tty_push_data(struct tty_struct *tty, unsigned char *cp, unsigned char *fp, int count)
-{
-	int ret = 0;
-	struct tty_ldisc *disc;
-	
-	disc = tty_ldisc_ref(tty);
-	if(test_bit(TTY_DONT_FLIP, &tty->flags))
-		ret = -EAGAIN;
-	else if(disc == NULL)
-		ret = -EIO;
-	else
-		disc->receive_buf(tty, cp, fp, count);
-	tty_ldisc_deref(disc);
-	return ret;
-	
-}
-
-/*
  * Routine which returns the baud rate of the tty
  *
  * Note that the baud_table needs to be kept in sync with the

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

