Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbUJ0OXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbUJ0OXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUJ0OXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:23:10 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46742 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262457AbUJ0OVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:21:18 -0400
Date: Wed, 27 Oct 2004 16:21:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: tty_write fix.
Message-ID: <20041027142107.GA3405@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] s390: tty_write fix.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make the s/390 console drivers compile without warnings again
after the recent tty layer change that moved the copy_from_user
out of the drivers.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/con3215.c  |    1 -
 drivers/s390/char/sclp_tty.c |    4 +---
 drivers/s390/char/tty3270.c  |    1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff -urN linux-2.6/drivers/s390/char/con3215.c linux-2.6-patched/drivers/s390/char/con3215.c
--- linux-2.6/drivers/s390/char/con3215.c	2004-10-27 12:20:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3215.c	2004-10-27 12:21:03.000000000 +0200
@@ -987,7 +987,6 @@
 	      const unsigned char *buf, int count)
 {
 	struct raw3215_info *raw;
-	int length, ret;
 
 	if (!tty)
 		return 0;
diff -urN linux-2.6/drivers/s390/char/sclp_tty.c linux-2.6-patched/drivers/s390/char/sclp_tty.c
--- linux-2.6/drivers/s390/char/sclp_tty.c	2004-10-27 12:20:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_tty.c	2004-10-27 12:21:03.000000000 +0200
@@ -397,8 +397,6 @@
 static int
 sclp_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	int length, ret;
-
 	if (sclp_tty_chars_count > 0) {
 		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count);
 		sclp_tty_chars_count = 0;
@@ -603,7 +601,7 @@
 
 	/* if set in ioctl write operators input to console  */
 	if (sclp_ioctls.echo)
-		sclp_tty_write(sclp_tty, 0, start, count);
+		sclp_tty_write(sclp_tty, start, count);
 
 	/* transfer input to high level driver */
 	sclp_tty_input(start, count);
diff -urN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2004-10-27 12:20:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2004-10-27 12:21:03.000000000 +0200
@@ -1603,7 +1603,6 @@
 	      const unsigned char *buf, int count)
 {
 	struct tty3270 *tp;
-	int length, ret;
 
 	tp = tty->driver_data;
 	if (!tp)
