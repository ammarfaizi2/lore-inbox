Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWAHNeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWAHNeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWAHNeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:34:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52379 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932731AbWAHNen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:34:43 -0500
Date: Sun, 8 Jan 2006 14:34:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060108133425.GA1711@elf.ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net> <200601071604.03846.lkml@spitalnik.net> <20060106043019.GA2545@ucw.cz> <200601072042.07337.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601072042.07337.lkml@spitalnik.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > fixes Kconfig to disallow such combination. I'm not 100% sure about
> > > > > the ACPI_SLEEP part, as it might be disabling some working setup -
> > > > > but i think that s2r and s2d are the only acpi sleeps allowed, no?
> > > >
> > > > s2ram probably works. Try getting it working without highmem64,
> > > > then turn it on.
> > >
> > > It works with HIGHMEM but not HIGHMEM64G. You can find the oops from
> > > HIGHMEM64G below. It crashes very reliably on little stress after resume.
> >
> > s2ram should not depend on ammount of memory. Try debugging
> > it, but do not disable feature just because it does not work
> > for you. I'd start with minimum drivers...
> 
> Well, I've tried it with the bare minimum that was needed to run the system, 
> but it did the same. I'm sorry but i lack the knowledge to properly debug it 
> on source level.  Do you see something that perhaps i don't see in the oops? 
> Maybe some clues as what might be going wrong?

I tried highmem64 on -mm2 here, and machine did not even boot :-(. I
may try it again on latest -git a bit later.
								Pavel

--- clean-mm/.config	2006-01-08 13:55:53.000000000 +0100
+++ linux-mm/.config	2006-01-08 14:18:22.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.15-mm2
-# Sun Jan  8 13:55:53 2006
+# Sun Jan  8 14:18:22 2006
 #
 CONFIG_X86_32=y
 CONFIG_GENERIC_TIME=y
@@ -165,9 +165,10 @@
 # CONFIG_DELL_RBU is not set
 # CONFIG_DCDBAS is not set
 # CONFIG_NOHIGHMEM is not set
-CONFIG_HIGHMEM4G=y
-# CONFIG_HIGHMEM64G is not set
+# CONFIG_HIGHMEM4G is not set
+CONFIG_HIGHMEM64G=y
 CONFIG_HIGHMEM=y
+CONFIG_X86_PAE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
@@ -179,7 +180,7 @@
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPARSEMEM_STATIC=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_HIGHPTE is not set
+CONFIG_HIGHPTE=y
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
 # CONFIG_EFI is not set

-- 
Thanks, Sharp!
