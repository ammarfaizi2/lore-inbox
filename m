Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTKLQh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTKLQh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:37:57 -0500
Received: from mail.convergence.de ([212.84.236.4]:61872 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263861AbTKLQhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:37:53 -0500
Date: Wed, 12 Nov 2003 17:37:50 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test9 ioctl compile warnings in userspace
Message-ID: <20031112163750.GB18989@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below fixes

  warning: signed and unsigned type in conditional expression

when compiling userspace programs with a glibc built against
2.6 kernel headers.

This is a better version of my previous patch which aims
to fix all affected architectures.

Johannes


diff -rN -u4 linux-2.6.0-test9-bk17.orig/include/asm-i386/ioctl.h linux-2.6.0-test9-bk17/include/asm-i386/ioctl.h
--- linux-2.6.0-test9-bk17.orig/include/asm-i386/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0-test9-bk17/include/asm-i386/ioctl.h	2003-11-12 16:51:38.000000000 +0100
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
diff -rN -u4 linux-2.6.0-test9-bk17.orig/include/asm-parisc/ioctl.h linux-2.6.0-test9-bk17/include/asm-parisc/ioctl.h
--- linux-2.6.0-test9-bk17.orig/include/asm-parisc/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0-test9-bk17/include/asm-parisc/ioctl.h	2003-11-12 16:51:24.000000000 +0100
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
diff -rN -u4 linux-2.6.0-test9-bk17.orig/include/asm-ppc/ioctl.h linux-2.6.0-test9-bk17/include/asm-ppc/ioctl.h
--- linux-2.6.0-test9-bk17.orig/include/asm-ppc/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0-test9-bk17/include/asm-ppc/ioctl.h	2003-11-12 16:51:34.000000000 +0100
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
diff -rN -u4 linux-2.6.0-test9-bk17.orig/include/asm-ppc64/ioctl.h linux-2.6.0-test9-bk17/include/asm-ppc64/ioctl.h
--- linux-2.6.0-test9-bk17.orig/include/asm-ppc64/ioctl.h	2003-11-12 16:49:14.000000000 +0100
+++ linux-2.6.0-test9-bk17/include/asm-ppc64/ioctl.h	2003-11-12 16:51:28.000000000 +0100
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
