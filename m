Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbRFLQog>; Tue, 12 Jun 2001 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFLQo0>; Tue, 12 Jun 2001 12:44:26 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:3721 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262659AbRFLQoY>; Tue, 12 Jun 2001 12:44:24 -0400
From: DJBARROW@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Keith Owens <kaos@ocs.com.au>, schwidefsky@de.ibm.com,
        Ulrich.Weigand@de.ibm.com
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A69.005BF601.00@d12mta09.de.ibm.com>
Date: Tue, 12 Jun 2001 18:43:41 +0200
Subject: Re: bug in /net/core/dev.c
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=qsIlWbIH90hCCJc1ayqJs7h5vLHbJWKyguxKAz82SiZ6ZITkXGCB2Gxu"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=qsIlWbIH90hCCJc1ayqJs7h5vLHbJWKyguxKAz82SiZ6ZITkXGCB2Gxu
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Hi Keith,
This is a cure the syntom not the problem, build order shouldn't mess u=
p
something this simple.
I've forwarded your patch to Ulrich & Martin ( the s390 maintainers ) &=

they may use it
seeing as you & possibly others would prefer a /drivers/net/s390.
David admitted it is a bug, if the patch is good hopefully it will be
taken,
 it if better can be done hopefully someone will do better.

D.J. Barrow Gnu/Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Sch=F6naicherstr. 220, 71032 B=F6blingen


Keith Owens <kaos@ocs.com.au> on 12.06.2001 18:11:26

Please respond to Keith Owens <kaos@ocs.com.au>

To:   "David S. Miller" <davem@redhat.com>
cc:   Denis Joseph Barrow/Germany/Contr/IBM@IBMDE,
      alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject:  Re: bug in /net/core/dev.c



=

--0__=qsIlWbIH90hCCJc1ayqJs7h5vLHbJWKyguxKAz82SiZ6ZITkXGCB2Gxu
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline


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
--- 6-pre2.1/drivers/s390/Makefile Fri, 13 Apr 2001 12:02:38 +1000 kaos
(linux-2.4/u/b/43_Makefile 1.3 644)
+++ 6-pre2.1(w)/drivers/s390/Makefile Wed, 13 Jun 2001 02:05:24 +1000 kaos
(linux-2.4/u/b/43_Makefile 1.3 644)
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
--- 6-pre2.1/drivers/net/Makefile Thu, 17 May 2001 10:25:35 +1000 kaos
(linux-2.4/l/c/26_Makefile 1.1.1.1.3.3.1.1.1.2 644)
+++ 6-pre2.1(w)/drivers/net/Makefile Wed, 13 Jun 2001 02:03:09 +1000 kaos
(linux-2.4/l/c/26_Makefile 1.1.1.1.3.3.1.1.1.2 644)
@@ -214,6 +214,12 @@ subdir-y += ../acorn/net
 obj-y         += ../acorn/net/acorn-net.o
 endif

+ifeq ($(CONFIG_ARCH_S390),y)
+mod-subdirs   += ../s390/net
+subdir-y += ../s390/net
+obj-y         += ../s390/net/s390-net.o
+endif
+
 #
 # HIPPI adapters
 #



--0__=qsIlWbIH90hCCJc1ayqJs7h5vLHbJWKyguxKAz82SiZ6ZITkXGCB2Gxu--

