Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSCOVhD>; Fri, 15 Mar 2002 16:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSCOVgv>; Fri, 15 Mar 2002 16:36:51 -0500
Received: from adsl-64-169-88-198.dsl.snfc21.pacbell.net ([64.169.88.198]:30098
	"EHLO fokker") by vger.kernel.org with ESMTP id <S293286AbSCOVg0>;
	Fri, 15 Mar 2002 16:36:26 -0500
Message-ID: <3C926952.A274773D@ianduggan.net>
Date: Fri, 15 Mar 2002 13:36:18 -0800
From: Ian Duggan <ian@ianduggan.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18+mki+w4l i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
In-Reply-To: <3C91B2A1.48C74B82@ianduggan.net> <E16lsiz-0003ly-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > "This kernel module attempts to isolate all of the functions and
> > structures that NeTraverse utilizes in it's binary kernel modules."
> >
> > The win4lin patch (also GPL) provides hooks for the mki-adapter module
> > to call.
> 
> Not really. Because if the win4lin patch provides hooks for binary modules
> that the binary modules depend upon then its hard to see how the two are
> resolvable. Either its GPL , in which case why is nonGPL code dependant
> on it and not shipped GPL, or it isnt

Perhaps there is a license violation here then. There are two patches
involved, both available from the Netraverse site once you are
registered there.

	https://www.netraverse.com/member/downloads/misc.php?refresh=yes&

The first patch, w4l-hooks, modifies these files, which are all part of
the kernel, thus GPL. The mki.c file has a header which says that it is
GPL.

	arch/i386/Makefile
	arch/i386/boot/compressed/head.S
	arch/i386/boot/compressed/misc.c
	arch/i386/boot/setup.S
	arch/i386/config.in   
	arch/i386/kernel/entry.S
	arch/i386/kernel/head.S 
	arch/i386/kernel/process.c
	arch/i386/kernel/signal.c 
	arch/i386/kernel/smpboot.c
	arch/i386/kernel/trampoline.S
	arch/i386/mki/Makefile
	arch/i386/mki/mki.c   
	arch/i386/mm/fault.c  
	include/asm-i386/desc.h
	include/asm-i386/mki.h 
	include/asm-i386/mkiversion.h
	include/asm-i386/segment.h 
	include/linux/sched.h
	kernel/exit.c 
	kernel/fork.c 
	kernel/sched.c
	mm/vmscan.c   

The second patch, mki-adapter, creates a new kernel module with a
LICENSE file that says that it is GPL, version 2. All the files in the
patch refer to the LICENSE file.

The output of lsmod shows:

	fokker% lsmod
	Module                  Size  Used by    Tainted: P
	Mvnetd                  8676   1 (unused)
	Mvnet                  51952   0 [Mvnetd]
	Mvnetint                 216   0 (unused)
	Mvw                     4172   0 (unused)
	Mvmouse                  704   0 (unused)
	Mvkbd                    824   0 (unused)
	Mvgic                   3160   0 (unused)
	Mvdsp                    904   0 (unused)
	Mserial                 5724   0 (unused)
	Mmpip                   6796   0 (unused)
	Mmerge                127556   0 [Mvnetd Mvnet Mvw Mvmouse Mvkbd Mvgic
Mvdsp Mserial Mmpip]
	mki-adapter            20944   0 [Mvnetd Mvnet Mvnetint Mvw Mvmouse
Mvkbd Mvgic Mvdsp Mserial Mmpip Mmerge]
	[...]


All of M* modules are binary modules that come as part of the win4lin
binary package. It looks like they are all dependent on Mmerge (binary)
and mki-adapter (GPL). Additionally, the mki-adapter README file has
this:

"This kernel module attempts to isolate all of the functions and
structures that NeTraverse utilizes in it's binary kernel modules."

So it certainly seems that they are dependent on the existence of
mki-adapter.

The M* modules should be available as GPL then?

-- Ian

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ian Duggan                    ian@ianduggan.net
                              http://www.ianduggan.net
