Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271714AbTG2NEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271713AbTG2ND3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:03:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47785 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271712AbTG2NDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:03:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 29 Jul 2003 15:02:52 +0200 (MEST)
Message-Id: <UTC200307291302.h6TD2q310517.aeb@smtp.cwi.nl>
To: clepple@ghz.cc, root@chaos.analogic.com
Subject: Re: Turning off automatic screen clanking
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Yes. This is f*ing absurb. A default that kills the screen and the
    requirement to send some @!_$%!@$ sequences to turn it off. This
    is absolute crap, absolutely positively, with no possible justification
    whatsoever. If I made an ioctl, it will probably be rejected.........

What language. What about the below (not compiled, not tested)?

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Mon Jun 23 04:43:32 2003
+++ b/drivers/char/vt.c	Tue Jul 29 15:36:58 2003
@@ -2294,6 +2294,12 @@
 		case TIOCL_BLANKEDSCREEN:
 			ret = console_blanked;
 			break;
+		case TIOCL_SETBLANKINTERVAL:
+			if (get_user(data, (char *)arg+1))
+				ret = -EFAULT;
+			else
+				blankinterval = ((unsigned)data)*60*HZ;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/tiocl.h b/include/linux/tiocl.h
--- a/include/linux/tiocl.h	Sun Jun 15 01:41:07 2003
+++ b/include/linux/tiocl.h	Tue Jul 29 15:34:39 2003
@@ -34,5 +34,6 @@
 #define TIOCL_SCROLLCONSOLE	13	/* scroll console */
 #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
 #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
+#define TIOCL_SETBLANKINTERVAL	16	/* in minutes; 0: don't blank */
 
 #endif /* _LINUX_TIOCL_H */
