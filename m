Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTJRKVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 06:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbTJRKVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 06:21:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41189 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261506AbTJRKVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 06:21:33 -0400
Date: Sat, 18 Oct 2003 12:21:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031018102127.GE12423@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de> <20031015161251.7de440ab.akpm@osdl.org> <20031015232440.GU17986@fs.tum.de> <20031015165205.0cc40606.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015165205.0cc40606.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 04:52:05PM -0700, Andrew Morton wrote:
>...
> I really doubt it.  Kernel CPU footprint is dominated by dcache misses.  If
> -Os reduces icache footprint it may even be a net win; people tend to
> benchmark things in tight loops, which favours fast code over small code.

The main effect of -Os compared to -O2 (besides disabling some
reordering of the code and prefetching) is the disabling of various
alignments. I doubt that's a win on all CPUs.

> > - I've already seen a report for an ICE in gcc 2.95 of a user compiling
> >   kernel 2.4 with -Os [1]
> 
> Well there's only one way to find out if we'll hit that.  How's about you
> cook me a patch which switches to -Os unconditionally and we'll see how it
> goes?

I still dislike it, but the patch is below.

cu
Adrian


--- linux-2.6.0-test5-mm4/arch/arm/Makefile.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/arm/Makefile	2003-09-25 14:40:47.000000000 +0200
@@ -14,8 +14,6 @@
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
 
-CFLAGS		:=$(CFLAGS:-O2=-Os)
-
 ifeq ($(CONFIG_FRAME_POINTER),y)
 CFLAGS		+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
--- linux-2.6.0-test5-mm4/arch/h8300/Makefile.old	2003-09-25 14:38:18.000000000 +0200
+++ linux-2.6.0-test5-mm4/arch/h8300/Makefile	2003-09-25 14:38:24.000000000 +0200
@@ -34,7 +34,7 @@
 ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self
 
 CFLAGS += $(cflags-y)
-CFLAGS += -mint32 -fno-builtin -Os
+CFLAGS += -mint32 -fno-builtin
 CFLAGS += -g
 CFLAGS += -D__linux__
 CFLAGS += -DUTS_SYSNAME=\"uClinux\"
--- linux-2.6.0-test8/Makefile.old	2003-10-18 12:15:51.000000000 +0200
+++ linux-2.6.0-test8/Makefile	2003-10-18 12:16:26.000000000 +0200
@@ -275,7 +275,7 @@
 CPPFLAGS        := -D__KERNEL__ -Iinclude \
 		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -Os \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
