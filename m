Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTKHAdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTKGWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:05:25 -0500
Received: from mail.convergence.de ([212.84.236.4]:25034 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264511AbTKGRcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 12:32:10 -0500
Date: Fri, 7 Nov 2003 18:32:05 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ioctl compile warnings in userspace
Message-ID: <20031107173205.GA4425@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Debian unstable now has glibc 2.3.2 and includes kernel headers
from "2.5.999-test7-bk-8".

$ gcc --version
gcc (GCC) 3.3.2 (Debian)


When compiling my DVB test programs I get warnings like:

  test_stc.c:64: warning: signed and unsigned type in conditional expression

with test_stc.c:64 being:

        if (ioctl(dmxfd, DMX_GET_STC, &stc) == -1) {

Patch below fixes it for i386, but there are more platforms
which need fixing.


diff -ru linux-2.6.0-test9-bk8/include/asm-i386/ioctl.h linux-2.6.0-test9-bk8-fix/include/asm-i386/ioctl.h
--- linux-2.6.0-test9-bk8/include/asm-i386/ioctl.h	2003-11-07 18:03:23.000000000 +0100
+++ linux-2.6.0-test9-bk8-fix/include/asm-i386/ioctl.h	2003-11-07 18:03:53.000000000 +0100
@@ -53,7 +53,7 @@
 	 ((size) << _IOC_SIZESHIFT))
 
 /* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
+extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \


Johannes
