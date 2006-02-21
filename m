Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWBUQKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWBUQKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWBUQKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:10:37 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:64014 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S932304AbWBUQKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:10:36 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: mauelshagen@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: *** Announcement: dmraid 1.0.0.rc10 ***
Organization: Mandrakesoft
References: <20060217210635.GA13074@redhat.com>
X-URL: <http://www.linux-mandrake.com/
Date: Tue, 21 Feb 2006 17:10:26 +0100
In-Reply-To: <20060217210635.GA13074@redhat.com> (Heinz Mauelshagen's message
	of "Fri, 17 Feb 2006 22:06:35 +0100")
Message-ID: <m28xs4k80d.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Heinz Mauelshagen <mauelshagen@redhat.com> writes:

>                *** Announcement: dmraid 1.0.0.rc10 ***
> 
> dmraid 1.0.0.rc10 is available at
> http://people.redhat.com/heinzm/sw/dmraid/ in source tarball,
> source rpm and i386 rpm (with shared and static binary).
> 
> This release adds support for Adaptec HostRAID and JMicron JMB36X
> (see CHANGELOG below for more information).

you're missusing AC_ARG_ENABLE: it cannot assume whereas you want to
default to --enable-XXX or --disable-XXX.

eg passing --disable-selinux to dmraid's configures make it actually
enable selinux support :-(

the format is "AC_ARG_ENABLE(name, help, [ use given value ], [ default action ])"

the following patch fixes it:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=dmraid-1.0.0.rc10-fix-autoconf.patch

--- ./1.0.0.rc10/configure.in.tv2	2006-02-21 16:57:45.000000000 +0100
+++ ./1.0.0.rc10/configure.in	2006-02-21 16:58:21.000000000 +0100
@@ -101,19 +101,19 @@
 AC_ARG_ENABLE(jobs,  [  --enable-jobs=NUM       Number of jobs to run simultaneously], JOBS=-j$enableval, JOBS=-j1)
 
 dnl Enables linking to libselinux
-AC_ARG_ENABLE(libselinux, [  --enable-libselinux     Use this to link the tools to libselinux ], LIBSELINUX=yes, LIBSELINUX=no)
+AC_ARG_ENABLE(libselinux, [  --enable-libselinux     Use this to link the tools to libselinux ], LIBSELINUX=$enableval, LIBSELINUX=no)
 
 dnl Enables linking to libselinux
-AC_ARG_ENABLE(libsepol, [  --enable-libsepol       Use this to link the tools to libsepol ], LIBSEPOL=yes, LIBSEPOL=no)
+AC_ARG_ENABLE(libsepol, [  --enable-libsepol       Use this to link the tools to libsepol ], LIBSEPOL=$enableval, LIBSEPOL=no)
 
 dnl Enables mini binary
 AC_ARG_ENABLE(mini, [  --enable-mini           Use this to create a minimal binrary suitable
-                          for early boot environments],  DMRAID_MINI=yes, DMRAID_MINI=no)
+                          for early boot environments],  DMRAID_MINI=$enableval, DMRAID_MINI=no)
 
 echo $ac_n "checking whether to disable native metadata logging""... $ac_c" 1>&6
 dnl Disable native metadata logging
 AC_ARG_ENABLE(native_log, [  --disable-native_log    Disable native metadata logging. Default is enabled],  \
-DMRAID_NATIVE_LOG=no, DMRAID_NATIVE_LOG=yes)
+DMRAID_NATIVE_LOG=$enableval, DMRAID_NATIVE_LOG=yes)
 echo "$ac_t""$DMRAID_NATIVE_LOG" 1>&6
 
 dnl Enables staticly linked tools

--=-=-=


you might want to alter default values then since i guess you
misunderstood what the arguments should have been.

--=-=-=--

