Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423857AbWLHCYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423857AbWLHCYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 21:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164382AbWLHCYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 21:24:19 -0500
Received: from ns1.suse.de ([195.135.220.2]:34703 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164380AbWLHCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 21:24:19 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: What was in the x86 merge for .20
Date: Fri, 8 Dec 2006 04:01:25 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612080401.25746.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[The merge already made it to Linus' tree. Sorry for sending this message
late]

Most of this is for both i386 and x86-64, unless when noted

These are just some high lights. As usual there are more
smaller optimizations, cleanups etc

- paravirt support for i386: the basic hooks for replacing all 
non virtualizable instructions on x86 are in. This currently
only runs on native hardware, but will allow to link in
modules  for paravirtualized Xen/Vmware/lhype.
There are some limitations like no SMP support yet. 
- Support for a Processor Data Area (PDA) on i386. This makes
the code more similar to x86-64 and will allow some other
optimizations in the future. 
- Relocatable kernel support for i386. This allows to load 
a single kernel binary on multiple addresses. This is useful
to use kdump kernels without having to maintain separate
binaries.
- Sleazy FPU feature also supported now on i386 -- this will
give a small improvement to FPU intensive programs because
they have to do  less lazy FPU exceptions.
- When a spinlock lockup occurs print backtraces of all CPUs. This 
makes debugging deadlocks easier
- x86-64 now also spins on spinlocks with interrupts enabled when
possible.
- Various dwarf2 unwinder improvements.
In particular better debugging support for figuring out what's wrong
and the unwinder should be less likely to crash now when it finds
invalid unwinding data.
- Use more efficient cache flushing when cache attributes are changed
- Allow compiling kernel for core2.  To be really useful this
will require gcc support to compile for core2 which isn't ready yet.
- Various fixes to the MTRR code
- Some preparatory infrastructure for perfmon
- Improve TSC setup heuristics on Core2 and AMD K8
- Don't try to synchronize TSCs on boot anymore. Instead just
checks if they are synchronized or not and disable TSC use
when unsynchronized. 
- More fixes to the idle notifier
- Various other bug fixes and cleanups

-Andi 
