Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbTLROna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265220AbTLROna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:43:30 -0500
Received: from mail.dietlibc.org ([212.84.236.4]:56202 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265218AbTLROn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:43:26 -0500
Date: Thu, 18 Dec 2003 15:43:24 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0: ioctl related warnings in userspace
Message-ID: <20031218144324.GA15580@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below (2nd resend) removes warnings like:

  warning: signed and unsigned type in conditional expression

when compiling userspace applications against a glibc built with 2.6
kernel headers (like on Debian unstable). Please apply.

Regards,
Johannes


diff -rN -u4 linux-2.6.0.orig/include/asm-i386/ioctl.h linux-2.6.0/include/asm-i386/ioctl.h
--- linux-2.6.0.orig/include/asm-i386/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0/include/asm-i386/ioctl.h	2003-11-12 16:51:38.000000000 +0100
@@ -52,9 +52,9 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
diff -rN -u4 linux-2.6.0.orig/include/asm-parisc/ioctl.h linux-2.6.0/include/asm-parisc/ioctl.h
--- linux-2.6.0.orig/include/asm-parisc/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0/include/asm-parisc/ioctl.h	2003-11-12 16:51:24.000000000 +0100
@@ -44,9 +44,9 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
diff -rN -u4 linux-2.6.0.orig/include/asm-ppc/ioctl.h linux-2.6.0/include/asm-ppc/ioctl.h
--- linux-2.6.0.orig/include/asm-ppc/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0/include/asm-ppc/ioctl.h	2003-11-12 16:51:34.000000000 +0100
@@ -37,9 +37,9 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
diff -rN -u4 linux-2.6.0.orig/include/asm-ppc64/ioctl.h linux-2.6.0/include/asm-ppc64/ioctl.h
--- linux-2.6.0.orig/include/asm-ppc64/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0/include/asm-ppc64/ioctl.h	2003-11-12 16:51:28.000000000 +0100
@@ -42,9 +42,9 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
        ((sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
          sizeof(t) : __invalid_size_argument_for_IOC)
