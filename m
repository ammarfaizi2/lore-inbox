Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271734AbRHQWMe>; Fri, 17 Aug 2001 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRHQWMY>; Fri, 17 Aug 2001 18:12:24 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:31982 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S271733AbRHQWMG>; Fri, 17 Aug 2001 18:12:06 -0400
Date: Fri, 17 Aug 2001 23:11:42 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' produces lots of errors with this .config
In-Reply-To: <20010817234626.A29467@telia.com>
Message-ID: <Pine.LNX.4.33.0108172305530.9362-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, André Dahlqvist wrote:

> I have come across what might be a problem and what might be
> completely harmless. I have noticed that when I configure my kernel in
> a certain way (the config file is attached) 'make dep' produces these
> errors while it is being run (these are just the errors, normal output
> is omitted):

Dear Gods, not another of Linus's "holiday presents".  These are for the
Sparc32 port, I came across one earlier and here's a slightly modified
patch for drivers/char/vt.c. Original patch came from a l-lk post earlier
(must have missed it, found a reference to it on sparclinux)

--- linux/drivers/char/vt.c.original       Fri Aug 17 21:21:47 2001
+++ linux/drivers/char/vt.c        Fri Aug 17 22:29:46 2001
@@ -28,7 +28,10 @@

 #include <asm/io.h>
 #include <asm/uaccess.h>
+
+#if !defined(__sparc__)
 #include <asm/keyboard.h>
+#endif

 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
@@ -499,7 +502,8 @@
 #endif

        /* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
-
+
+#if !defined(__sparc__)
        case KDKBDREP:
        {
                struct kbd_repeat kbrep;
@@ -518,6 +522,7 @@
                        return -EFAULT;
                return 0;
        }
+#endif

        case KDSETMODE:
                /*


-- 
A pancake! I've photocopied a pancake!

http://www.tahallah.demon.co.uk

