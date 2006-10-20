Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422881AbWJTMxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWJTMxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWJTMxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:53:37 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:53419 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030241AbWJTMxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:53:36 -0400
Subject: [PATCH] 2.6.19.-rc2-mm2 compile fix for sclp_tty
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 20 Oct 2006 14:53:32 +0200
Message-Id: <1161348812.3135.8.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extern declaration of tty_std_termios in sclp_tty was a hack
which is obsolete.

  CC      drivers/s390/char/sclp_tty.o
drivers/s390/char/sclp_tty.c:63: error: conflicting types for 'tty_std_termios'
include/linux/tty.h:261: error: previous declaration of 'tty_std_termios' was here
drivers/s390/char/sclp_tty.c: In function 'sclp_tty_init':
drivers/s390/char/sclp_tty.c:790: error: incompatible types in assignment
make[2]: *** [drivers/s390/char/sclp_tty.o] Error 1
make[1]: *** [drivers/s390/char] Error 2
make: *** [drivers/s390] Error 2
Kernel compilation...FAILED

Signed-off-by: Martin Peschke <mp3@de.ibm.com> 
Acked-by: Peter Oberparleiter <oberpar@de.ibm.com>
---

 sclp_tty.c |    2 --
 1 files changed, 2 deletions(-)

--- a/drivers/s390/char/sclp_tty.c	2006-10-19 23:10:31.000000000 +0200
+++ b/drivers/s390/char/sclp_tty.c	2006-10-19 23:10:32.000000000 +0200
@@ -60,8 +60,6 @@ static unsigned short int sclp_tty_chars
 
 struct tty_driver *sclp_tty_driver;
 
-extern struct termios  tty_std_termios;
-
 static struct sclp_ioctls sclp_ioctls;
 static struct sclp_ioctls sclp_ioctls_init =
 {


