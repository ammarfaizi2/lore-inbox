Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbQJ0Iff>; Fri, 27 Oct 2000 04:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129082AbQJ0IfZ>; Fri, 27 Oct 2000 04:35:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1032 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129035AbQJ0IfP>;
	Fri, 27 Oct 2000 04:35:15 -0400
Message-ID: <39F93E20.EC1C2D9@mandrakesoft.com>
Date: Fri, 27 Oct 2000 04:34:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.0.10.6: always no-strict-aliasing
In-Reply-To: <Pine.LNX.4.10.10010262345530.1231-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------8D1D42275A6BCAF3DB39F863"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8D1D42275A6BCAF3DB39F863
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
>  (a) the new compiler requirements (sorry, but it turned out that 2.7.2.3
>      really is too subtly broken with named structure initializers that
>      are very heavily used these days inside the kernel)
> 
>      Suggested stable compiler: gcc-2.91.66, aka egcs-1.1.2, which is the
>      one most vendors have been shipping for a long time, and while sure
>      to be buggy too has not been found to be seriously so at least yet.
> 
>      Other modern gcc versions may well work too.

Since egcs-1.1.2 supports -fno-strict-aliasing, would the attached patch
against linux/Makefile be appropriate?

-- 
Jeff Garzik                    | Raft naked...
Building 1024                  | It adds color to your cheeks.
MandrakeSoft                   |
--------------8D1D42275A6BCAF3DB39F863
Content-Type: text/plain; charset=us-ascii;
 name="makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makefile.patch"

Index: Makefile
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/Makefile,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 Makefile
--- Makefile	2000/10/22 23:14:50	1.1.1.11
+++ Makefile	2000/10/27 08:32:28
@@ -16,7 +16,7 @@
 FINDHPATH	= $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
 
 HOSTCC  	= gcc
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
 
 CROSS_COMPILE 	=
 
@@ -87,7 +87,7 @@
 
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
-CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 #
@@ -181,9 +181,6 @@
 DRIVERS += $(DRIVERS-y)
 
 include arch/$(ARCH)/Makefile
-
-# use '-fno-strict-aliasing', but only if the compiler can take it
-CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)
 
 export	CPPFLAGS CFLAGS AFLAGS
 

--------------8D1D42275A6BCAF3DB39F863--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
