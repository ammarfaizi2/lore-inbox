Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUGaVRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUGaVRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUGaVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:17:50 -0400
Received: from holomorphy.com ([207.189.100.168]:3235 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264097AbUGaVRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:17:48 -0400
Date: Sat, 31 Jul 2004 14:17:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kbuild: Various updates for 2.6.8
Message-ID: <20040731211739.GE2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040731075838.GA7469@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731075838.GA7469@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 09:58:38AM +0200, Sam Ravnborg wrote:
> I have arranged with Andrew that he sucks my kbuild tree in -mm,
> and this is the fist update I send direct to you.
> The following set of patches has been in -mm for a few days now
> with no complaints. Please include these before 2.6.8.
> 	bk pull bk://linux-sam.bkbits.net/kbuild
> The most important fix is the $LANG fix. Without this users
> from .cz, .fr etc. cannot use menuconfig/xconfig with good result.

By any chance could you update make rpm so it respects the -j flags?
Single-threaded make rpm is horrifically slow.

I'm using the patch below at the moment, but am not very particular
as to the form of the solution.


-- wli

Index: sched-2.6.8-rc2-mm1/scripts/package/mkspec
===================================================================
--- sched-2.6.8-rc2-mm1.orig/scripts/package/mkspec	2004-07-30 10:53:27.000000000 -0700
+++ sched-2.6.8-rc2-mm1/scripts/package/mkspec	2004-07-30 22:28:05.000000000 -0700
@@ -57,14 +57,14 @@
 echo "%build"
 
 if ! $PREBUILT; then
-echo "make clean && make"
+echo "make clean && make %{_smp_mflags}"
 echo ""
 fi
 
 echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 
-echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
+echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make %{_smp_mflags} modules_install'
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
