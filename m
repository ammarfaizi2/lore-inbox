Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbRFLQMr>; Tue, 12 Jun 2001 12:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbRFLQMg>; Tue, 12 Jun 2001 12:12:36 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:14323 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S262120AbRFLQMX>;
	Tue, 12 Jun 2001 12:12:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: DJBARROW@de.ibm.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c 
In-Reply-To: Your message of "Tue, 12 Jun 2001 08:46:00 MST."
             <15142.14648.665490.589503@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 02:11:26 +1000
Message-ID: <10112.992362286@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001 08:46:00 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>So, if the s390 folks move their stuff into the appropriate spot it
>will work.  In fact, I personally like to see the s390 net devices
>under drivers/net/s390 anyways.  They'll get free maintenance from
>myself and Jeff Garzik in this way as I rarely look int
>drivers/${PLATFORM} type directories unless I'm doing a tree-wide
>grep. :-)

Leave s390 separate for the moment, all the other architectures work
the same way.

Minimal (and totally untested) patch to compile s390/net as part of the
other network drivers follows - if it's good enough for acorn, it's
good enough for s390.  The method is as ugly as hell but it is the
least possible change for 2.4, major redesign will have to wait for
2.5.  Patch against 2.4.6-pre2.

Index: 6-pre2.1/drivers/s390/Makefile
--- 6-pre2.1/drivers/s390/Makefile Fri, 13 Apr 2001 12:02:38 +1000 kaos (linux-2.4/u/b/43_Makefile 1.3 644)
+++ 6-pre2.1(w)/drivers/s390/Makefile Wed, 13 Jun 2001 02:05:24 +1000 kaos (linux-2.4/u/b/43_Makefile 1.3 644)
@@ -4,7 +4,7 @@
 
 O_TARGET := io.o
 
-subdir-y := block char misc net
+subdir-y := block char misc
 subdir-m := $(subdir-y)
 obj-y := $(foreach dir,$(subdir-y),$(dir)/s390-$(dir).o)
 
@@ -12,3 +12,5 @@ obj-y += s390io.o s390mach.o s390dyn.o i
 export-objs += ccwcache.o idals.o s390dyn.o s390io.o
 
 include $(TOPDIR)/Rules.make
+
+# the NET subdir is included from drivers/net now
Index: 6-pre2.1/drivers/net/Makefile
--- 6-pre2.1/drivers/net/Makefile Thu, 17 May 2001 10:25:35 +1000 kaos (linux-2.4/l/c/26_Makefile 1.1.1.1.3.3.1.1.1.2 644)
+++ 6-pre2.1(w)/drivers/net/Makefile Wed, 13 Jun 2001 02:03:09 +1000 kaos (linux-2.4/l/c/26_Makefile 1.1.1.1.3.3.1.1.1.2 644)
@@ -214,6 +214,12 @@ subdir-y	+= ../acorn/net
 obj-y		+= ../acorn/net/acorn-net.o
 endif
 
+ifeq ($(CONFIG_ARCH_S390),y)
+mod-subdirs	+= ../s390/net
+subdir-y	+= ../s390/net
+obj-y		+= ../s390/net/s390-net.o
+endif
+
 #
 # HIPPI adapters
 #

