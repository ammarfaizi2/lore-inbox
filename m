Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbTCaXnc>; Mon, 31 Mar 2003 18:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbTCaXnc>; Mon, 31 Mar 2003 18:43:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:46310 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261933AbTCaXnZ>;
	Mon, 31 Mar 2003 18:43:25 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 1 Apr 2003 01:54:43 +0200 (MEST)
Message-Id: <UTC200303312354.h2VNshU15505.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, tytso@mit.edu
Subject: [PATCH] kill TIOCTTYGSTRUCT
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: "Theodore Ts'o" <tytso@mit.edu>

	> Hi Ted,
	> 
	> Would you mind if I removed TIOCTTYGSTRUCT?
	> 
	> I suppose you don't need it any longer, and otherwise
	> could easily add some debugging stuff again when needed.
	> This ioctl exports lots of kernel-internal stuff that
	> userspace has no business looking at.

	Sure, go ahead; I'm pretty sure no one has used it for at least 6-7
	years...

							- Ted

Very well..

[In fact I know about one use.]

The patch below kills TIOCTTYGSTRUCT.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Mar 25 04:54:31 2003
+++ b/drivers/char/tty_io.c	Fri Mar 28 16:58:43 2003
@@ -1662,13 +1662,6 @@
 	return put_user(real_tty->session, arg);
 }
 
-static int tiocttygstruct(struct tty_struct *tty, struct tty_struct *arg)
-{
-	if (copy_to_user(arg, tty, sizeof(*arg)))
-		return -EFAULT;
-	return 0;
-}
-
 static int tiocsetd(struct tty_struct *tty, int *arg)
 {
 	int ldisc;
@@ -1795,9 +1788,6 @@
 		case TIOCLINUX:
 			return tioclinux(tty, arg);
 #endif
-		case TIOCTTYGSTRUCT:
-			return tiocttygstruct(tty, (struct tty_struct *) arg);
-
 		/*
 		 * Break handling
 		 */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-alpha/ioctls.h b/include/asm-alpha/ioctls.h
--- a/include/asm-alpha/ioctls.h	Fri Nov 22 22:40:53 2002
+++ b/include/asm-alpha/ioctls.h	Fri Mar 28 17:04:24 2003
@@ -86,7 +86,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-arm/ioctls.h b/include/asm-arm/ioctls.h
--- a/include/asm-arm/ioctls.h	Fri Nov 22 22:40:41 2002
+++ b/include/asm-arm/ioctls.h	Fri Mar 28 17:01:45 2003
@@ -43,7 +43,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-cris/ioctls.h b/include/asm-cris/ioctls.h
--- a/include/asm-cris/ioctls.h	Fri Nov 22 22:40:49 2002
+++ b/include/asm-cris/ioctls.h	Fri Mar 28 17:06:45 2003
@@ -45,7 +45,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/ioctls.h b/include/asm-i386/ioctls.h
--- a/include/asm-i386/ioctls.h	Fri Nov 22 22:40:19 2002
+++ b/include/asm-i386/ioctls.h	Fri Mar 28 17:06:10 2003
@@ -43,14 +43,14 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
+/* #define TIOCTTYGSTRUCT 0x5426 - Former debugging-only ioctl */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
-#define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
+#define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
 #define FIOASYNC	0x5452
 #define TIOCSERCONFIG	0x5453
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ia64/ioctls.h b/include/asm-ia64/ioctls.h
--- a/include/asm-ia64/ioctls.h	Fri Nov 22 22:40:20 2002
+++ b/include/asm-ia64/ioctls.h	Fri Mar 28 17:01:10 2003
@@ -48,7 +48,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-m68k/ioctls.h b/include/asm-m68k/ioctls.h
--- a/include/asm-m68k/ioctls.h	Fri Nov 22 22:40:19 2002
+++ b/include/asm-m68k/ioctls.h	Fri Mar 28 17:01:00 2003
@@ -43,7 +43,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips/ioctls.h b/include/asm-mips/ioctls.h
--- a/include/asm-mips/ioctls.h	Fri Nov 22 22:40:58 2002
+++ b/include/asm-mips/ioctls.h	Fri Mar 28 17:03:18 2003
@@ -74,6 +74,12 @@
 /* #define TIOCSETD	_IOW('t', 27, int)	set line discipline */
 						/* 127-124 compat */
 
+#define TIOCSBRK	0x5427  /* BSD compatibility */
+#define TIOCCBRK	0x5428  /* BSD compatibility */
+#define TIOCGSID	0x7416  /* Return the session ID of FD */
+#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
+#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
 #define TIOCGSOFTCAR	0x5481
@@ -81,15 +87,7 @@
 #define TIOCLINUX	0x5483
 #define TIOCGSERIAL	0x5484
 #define TIOCSSERIAL	0x5485
-
 #define TCSBRKP		0x5486	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5487  /* For debugging only */
-#define TIOCSBRK	0x5427  /* BSD compatibility */
-#define TIOCCBRK	0x5428  /* BSD compatibility */
-#define TIOCGSID	0x7416  /* Return the session ID of FD */
-#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
-
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
 #define TIOCSERSWILD	0x548a
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-mips64/ioctls.h b/include/asm-mips64/ioctls.h
--- a/include/asm-mips64/ioctls.h	Fri Nov 22 22:40:54 2002
+++ b/include/asm-mips64/ioctls.h	Fri Mar 28 17:07:37 2003
@@ -74,6 +74,12 @@
 /* #define TIOCSETD	_IOW('t', 27, int)	set line discipline */
 						/* 127-124 compat */
 
+#define TIOCSBRK	0x5427  /* BSD compatibility */
+#define TIOCCBRK	0x5428  /* BSD compatibility */
+#define TIOCGSID	0x7416  /* Return the session ID of FD */
+#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
+#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
 #define TIOCGSOFTCAR	0x5481
@@ -81,15 +87,7 @@
 #define TIOCLINUX	0x5483
 #define TIOCGSERIAL	0x5484
 #define TIOCSSERIAL	0x5485
-
 #define TCSBRKP		0x5486	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5487  /* For debugging only */
-#define TIOCSBRK	0x5427  /* BSD compatibility */
-#define TIOCCBRK	0x5428  /* BSD compatibility */
-#define TIOCGSID	0x7416  /* Return the session ID of FD */
-#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
-
 #define TIOCSERCONFIG	0x5488
 #define TIOCSERGWILD	0x5489
 #define TIOCSERSWILD	0x548a
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-parisc/ioctls.h b/include/asm-parisc/ioctls.h
--- a/include/asm-parisc/ioctls.h	Fri Nov 22 22:40:19 2002
+++ b/include/asm-parisc/ioctls.h	Fri Mar 28 17:00:24 2003
@@ -43,7 +43,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	_IOR('T', 20, int) /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc/ioctls.h b/include/asm-ppc/ioctls.h
--- a/include/asm-ppc/ioctls.h	Fri Nov 22 22:40:56 2002
+++ b/include/asm-ppc/ioctls.h	Fri Mar 28 17:01:27 2003
@@ -83,7 +83,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc/termios.h b/include/asm-ppc/termios.h
--- a/include/asm-ppc/termios.h	Thu Jan  9 18:07:17 2003
+++ b/include/asm-ppc/termios.h	Fri Mar 28 17:01:36 2003
@@ -97,7 +97,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc64/ioctls.h b/include/asm-ppc64/ioctls.h
--- a/include/asm-ppc64/ioctls.h	Fri Nov 22 22:40:12 2002
+++ b/include/asm-ppc64/ioctls.h	Fri Mar 28 17:00:36 2003
@@ -90,7 +90,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-ppc64/termios.h b/include/asm-ppc64/termios.h
--- a/include/asm-ppc64/termios.h	Fri Nov 22 22:40:14 2002
+++ b/include/asm-ppc64/termios.h	Fri Mar 28 17:00:47 2003
@@ -152,7 +152,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390/ioctls.h b/include/asm-s390/ioctls.h
--- a/include/asm-s390/ioctls.h	Fri Nov 22 22:40:44 2002
+++ b/include/asm-s390/ioctls.h	Fri Mar 28 17:04:47 2003
@@ -51,7 +51,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-s390x/ioctls.h b/include/asm-s390x/ioctls.h
--- a/include/asm-s390x/ioctls.h	Fri Nov 22 22:40:28 2002
+++ b/include/asm-s390x/ioctls.h	Fri Mar 28 17:00:07 2003
@@ -51,7 +51,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sh/ioctls.h b/include/asm-sh/ioctls.h
--- a/include/asm-sh/ioctls.h	Fri Nov 22 22:40:50 2002
+++ b/include/asm-sh/ioctls.h	Fri Mar 28 17:08:03 2003
@@ -75,7 +75,6 @@
 #define TIOCSETD	_IOW('T', 35, int) /* 0x5423 */
 #define TIOCGETD	_IOR('T', 36, int) /* 0x5424 */
 #define TCSBRKP		_IOW('T', 37, int) /* 0x5425 */	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	_IOR('T', 38, struct tty_struct) /* 0x5426 */ /* For debugging only */
 #define TIOCSBRK	_IO('T', 39) /* 0x5427 */ /* BSD compatibility */
 #define TIOCCBRK	_IO('T', 40) /* 0x5428 */ /* BSD compatibility */
 #define TIOCGSID	_IOR('T', 41, pid_t) /* 0x5429 */ /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc/ioctls.h b/include/asm-sparc/ioctls.h
--- a/include/asm-sparc/ioctls.h	Fri Nov 22 22:40:41 2002
+++ b/include/asm-sparc/ioctls.h	Fri Mar 28 17:04:07 2003
@@ -99,7 +99,6 @@
 #define TIOCGSERIAL	0x541E
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
-#define TIOCTTYGSTRUCT	0x5426
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-sparc64/ioctls.h b/include/asm-sparc64/ioctls.h
--- a/include/asm-sparc64/ioctls.h	Fri Nov 22 22:40:43 2002
+++ b/include/asm-sparc64/ioctls.h	Fri Mar 28 17:06:35 2003
@@ -100,7 +100,6 @@
 #define TIOCGSERIAL	0x541E
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
-#define TIOCTTYGSTRUCT	0x5426
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-v850/ioctls.h b/include/asm-v850/ioctls.h
--- a/include/asm-v850/ioctls.h	Fri Nov 22 22:40:29 2002
+++ b/include/asm-v850/ioctls.h	Fri Mar 28 17:07:48 2003
@@ -43,7 +43,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-x86_64/ioctls.h b/include/asm-x86_64/ioctls.h
--- a/include/asm-x86_64/ioctls.h	Fri Nov 22 22:41:12 2002
+++ b/include/asm-x86_64/ioctls.h	Fri Mar 28 17:01:19 2003
@@ -43,7 +43,6 @@
 #define TIOCSETD	0x5423
 #define TIOCGETD	0x5424
 #define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCTTYGSTRUCT	0x5426  /* For debugging only */
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
