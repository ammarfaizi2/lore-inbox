Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWHZB5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWHZB5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 21:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWHZB5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 21:57:16 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52688 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422851AbWHZB5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 21:57:16 -0400
Date: Sat, 26 Aug 2006 10:56:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kmannth@gmail.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: another NUMA build error
Message-Id: <20060826105639.5680429d.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060825160115.7f768797.rdunlap@xenotime.net>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825103507.4f2d193e.rdunlap@xenotime.net>
	<a762e240608251544t2e15ec8dq5a8f95f02eecb0a4@mail.gmail.com>
	<20060825160115.7f768797.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 16:01:15 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > I thought there was a patch fix a while ago to fix this build issue.
> > If you want to anything that includes the SUMMIT sub arch you need
> > CONFIG_ACPI_SRAT.
> > 
> > Option 1 is a good solution as only NUMAQ and ACPI_SRAT have tables
> > that are used to setup NUMA in the kernel.
> > 
> > > OK, I prefer option 2 because it is more generic (not hardware-
> > > specific).  Someone else can prefer option 1 because it is
> > > hardware-specific.  :)
> > 
> > I guess I am that other person.  Really you only want/need NUMA if you
> > have ACPI_SRAT (Summit) or NUMAQ.
> 
> That's fine.  Any fix is OK with me, as long as a .config
> won't generate a build error.
> 
Hmm... is this the way to go ?
Keith-san, please ack if Okay.
-Kame

--
When we select NUMA with i386, the system is only X86_NUMAQ or using ACPI.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.18-rc4/arch/i386/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/Kconfig
+++ linux-2.6.18-rc4/arch/i386/Kconfig
@@ -142,6 +142,7 @@ config X86_SUMMIT
 	  In particular, it is needed for the x440.
 
 	  If you don't have one of these computers, you should say N here.
+	  If you want to build NUMA kernel, you have to select ACPI
 
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
@@ -169,6 +170,7 @@ config X86_GENERICARCH
        help
           This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
 	  It is intended for a generic binary kernel.
+	  if you want NUMA kernel, select ACPI. we need SRAT for build NUMA
 
 config X86_ES7000
 	bool "Support for Unisys ES7000 IA32 series"
@@ -542,7 +544,7 @@ config X86_PAE
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
-	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
+	depends on SMP && HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT || X86_GENERICARCH) && ACPI)
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 

