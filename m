Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUKEStU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUKEStU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 13:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUKEStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 13:49:20 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:64910 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261158AbUKEStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 13:49:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3: (fix for make xconfig)
Date: Fri, 5 Nov 2004 19:48:32 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051907.19008.rjw@sisk.pl>
In-Reply-To: <200411051907.19008.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411051948.32936.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of November 2004 19:07, Rafael J. Wysocki wrote:
> On Friday 05 of November 2004 09:13, Andrew Morton wrote:
> > 
> > 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/
> > 
> > 
> > - Added Andi's 4-level-pagetable patches.  It's tested on x86, x86_64, 
ia64
> >   and ppc64.  These are fairly intrusive patches and I'll probably push 
them
> >   upstream soon.
> > 
> > - UML updates, ppc64 updates.
> > 
> > - Should fix a few bugs which people reported in 2.6.10-rc1-mm2.
> 
> I get this from "make xconfig" on x86-64 ("make menuconfig" apparently 
works):
> 
> rafael@albercik:/local/src/mm/linux-2.6.10-rc1-mm3> make xconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kconfig_load.o
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTCXX scripts/kconfig/qconf.o
>   HOSTLD  scripts/kconfig/qconf
> scripts/kconfig/qconf arch/x86_64/Kconfig
> ./scripts/kconfig/libkconfig.so: cannot open shared object file: No such 
file 
> or directory
> make[1]: *** [xconfig] Error 1
> make: *** [xconfig] Error 2

I did this to fix it:

--- scripts/kconfig/Makefile.orig	2004-11-05 19:16:23.000000000 +0100
+++ scripts/kconfig/Makefile	2004-11-05 19:18:08.000000000 +0100
@@ -70,9 +70,11 @@
 #         Based on GTK which needs to be installed to compile it
 # object files used by all kconfig flavours
 
+libkconfig-objs := zconf.tab.o
+
 hostprogs-y	:= conf mconf qconf gconf
-conf-objs	:= conf.o  zconf.tab.o
-mconf-objs	:= mconf.o zconf.tab.o
+conf-objs	:= conf.o  libkconfig.so
+mconf-objs	:= mconf.o libkconfig.so
 
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
