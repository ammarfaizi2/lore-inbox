Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbRBWMpo>; Fri, 23 Feb 2001 07:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBWMpe>; Fri, 23 Feb 2001 07:45:34 -0500
Received: from host59.panacealabs.com ([63.88.80.59]:787 "EHLO
	mars.corsol.atlanta.ga.us") by vger.kernel.org with ESMTP
	id <S129350AbRBWMpX>; Fri, 23 Feb 2001 07:45:23 -0500
Message-ID: <3A965B61.B76A96A1@machturtle.com>
Date: Fri, 23 Feb 2001 07:45:21 -0500
From: David Corbin <dcorbin@machturtle.com>
Organization: Mach Turtle Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: [PATCH]: console, kernel 2.2.18
Content-Type: multipart/mixed;
 boundary="------------9DF011F03B8A5E1F9001AD76"
X-via: mars.corsol.atlanta.ga.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9DF011F03B8A5E1F9001AD76
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is my first submitted patch, so please be gentle.  It's
actually made against the 2.2.18 kernel, but it should work fine against
2.4.2 from what I can tell.

The patch is extremely simple, but I would welcome testing and feedback
(I am not on the kernel mailing list).

It provides an ioctl call that will forcibly blank the screen.  It is
essentially the counterpart to TIOCLINUX, subcode=4.


-- 
David Corbin 		
dcorbin@machturtle.com
--------------9DF011F03B8A5E1F9001AD76
Content-Type: text/plain; charset=us-ascii;
 name="patch-dsc-2.2.18a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dsc-2.2.18a"

--- linux-2.2.18/drivers/char/console.c	Sun Dec 10 19:49:41 2000
+++ linux/drivers/char/console.c	Fri Feb 23 06:54:40 2001
@@ -66,6 +66,9 @@
  *
  * Resurrected character buffers in videoram plus lots of other trickery
  * by Martin Mares <mj@atrey.karlin.mff.cuni.cz>, July 1998
+ * 
+ * Added ioctl sub-code to forcibly blank screen.
+ * by David Corbin <dcorbin@ieee.org>, February 2001
  */
 
 #include <linux/module.h>
@@ -2139,6 +2142,9 @@
 			return 0;
 		case 12:	/* get fg_console */
 			return fg_console;
+		case 13:
+			blank_screen();
+			return 0;
 	}
 	return -EINVAL;
 }

--------------9DF011F03B8A5E1F9001AD76
Content-Type: text/plain; charset=us-ascii;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README"

Provide ioctl on console to force immediate "blanking", David Corbin <dcorbin@ieee.org>

--------------9DF011F03B8A5E1F9001AD76--

