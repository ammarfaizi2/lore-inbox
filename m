Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbTEODTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTEODSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:36 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:4844 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263779AbTEODSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:16 -0400
Date: Thu, 15 May 2003 04:31:04 +0100
Message-Id: <200305150331.h4F3V4bF000568@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Fix standards compliance bugs in the tty layer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This went into 2.4 back last August with the comment in $subject.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/tty_ioctl.c linux-2.5/drivers/char/tty_ioctl.c
--- bk-linus/drivers/char/tty_ioctl.c	2003-04-24 03:50:37.000000000 +0100
+++ linux-2.5/drivers/char/tty_ioctl.c	2003-04-24 03:53:14.000000000 +0100
@@ -394,7 +394,7 @@ int n_tty_ioctl(struct tty_struct * tty,
 				return -EFAULT;
 			return 0;
 		case TCSETSF:
-			return set_termios(real_tty, arg,  TERMIOS_FLUSH);
+			return set_termios(real_tty, arg,  TERMIOS_FLUSH | TERMIOS_WAIT);
 		case TCSETSW:
 			return set_termios(real_tty, arg, TERMIOS_WAIT);
 		case TCSETS:
@@ -402,7 +402,7 @@ int n_tty_ioctl(struct tty_struct * tty,
 		case TCGETA:
 			return get_termio(real_tty,(struct termio *) arg);
 		case TCSETAF:
-			return set_termios(real_tty, arg, TERMIOS_FLUSH | TERMIOS_TERMIO);
+			return set_termios(real_tty, arg, TERMIOS_FLUSH | TERMIOS_WAIT | TERMIOS_TERMIO);
 		case TCSETAW:
 			return set_termios(real_tty, arg, TERMIOS_WAIT | TERMIOS_TERMIO);
 		case TCSETA:
