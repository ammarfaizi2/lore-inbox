Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269073AbTBZXPn>; Wed, 26 Feb 2003 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269131AbTBZXPm>; Wed, 26 Feb 2003 18:15:42 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10659 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S269073AbTBZXPl>; Wed, 26 Feb 2003 18:15:41 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][2.4] Speedup 'make dep'
Date: Thu, 27 Feb 2003 00:25:02 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@Jaluna.com>
References: <lnlm1ffh5d.fsf@walhalla.agaha>
In-Reply-To: <lnlm1ffh5d.fsf@walhalla.agaha>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QPVXTHB6QGC10MIVX3PC"
Message-Id: <200302270025.02512.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QPVXTHB6QGC10MIVX3PC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 January 2003 02:03, Benoit Poulot-Cazajous wrote:

Hi Marcelo,

apply this too, please!

> During 'make dep', make spends most of its time (sometimes more
> than 75%) uselessly analysing .hdepend. Delaying its production
> makes 'make dep' much faster.
> The following patch also builds .depend last, in order to make
> the dependency information generation more resistant against
> ^C and other failures.
>
> Regards,
>
>   -- Benoit

--------------Boundary-00=_QPVXTHB6QGC10MIVX3PC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="speedup-make-dep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="speedup-make-dep.patch"

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2003-01-10 22:32:25.000000000 +0100
+++ b/Makefile	2003-01-20 09:52:43.000000000 +0100
@@ -488,12 +488,13 @@
 	find . -type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
-	scripts/mkdep -- init/*.c > .depend
-	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	rm -f .depend .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
+	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- init/*.c > .depend
 
 ifdef CONFIG_MODVERSIONS
 MODVERFILE := $(TOPDIR)/include/linux/modversions.h

--------------Boundary-00=_QPVXTHB6QGC10MIVX3PC--

