Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWIXNLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWIXNLt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 09:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIXNLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 09:11:49 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:1298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750762AbWIXNLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 09:11:48 -0400
Date: Sun, 24 Sep 2006 14:11:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, Junio C Hamano <junkio@cox.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm1
Message-ID: <20060924131132.GC25666@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060924124647.GB25666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 01:46:47PM +0100, Russell King wrote:
> On Sun, Sep 24, 2006 at 04:02:15AM -0700, Andrew Morton wrote:
> >  git-arm.patch
> 
> It's worth pointing out that something has gone horribly wrong in the
> devel branch of this tree, resulting in a load of files being deleted
> which shouldn't have been.
> 
> Absolutely no idea how that happened, but it's a commit buried behind
> lots of other commits and has taken some 4 days to be spotted.  At a
> guess, a perl bug where a new associative array somehow manages to pick
> up on old values and forget values from previous assignments.
> 
> Oddly, running the script in debug mode (where the only things which
> don't happen is the git commands get called) appears to give correct
> behaviour.
> 
> So I'm in the situation where I need to rebuild 4 days work in the ARM
> devel tree. ;(

Okay, it's not as serious as I first thought, but there is still a
problem.

The issue is as follows.  When applying patches, my perl script effectively
does:

patch -p1 < patch
git add list-of-files-which-patch-added
git rm list-of-files-which-patch-removed
echo commit-message | git commit -F - -- list-of-files-added-and-changed

For 3834/1 (2172590e3aea712a4da90ac4eb6ca88f19a4ebea) which only removed
files, "list-of-files-added-and-changed" was empty, so it committed
_everything_.

However, one might ask why don't I include the list of deleted files
there.  Well, if I do, I get the following from my script and from
git:

Patching 3817/1...
patching file arch/arm/Kconfig
patching file arch/arm/Makefile
patching file arch/arm/configs/ep80219_defconfig
patching file arch/arm/configs/iq31244_defconfig
patching file arch/arm/configs/iq80321_defconfig
patching file arch/arm/configs/iq80331_defconfig
patching file arch/arm/configs/iq80332_defconfig
patching file arch/arm/mach-iop32x/Kconfig
patching file arch/arm/mach-iop32x/Makefile
patching file arch/arm/mach-iop32x/Makefile.boot
patching file arch/arm/mach-iop32x/common.c
patching file arch/arm/mach-iop32x/iq31244-mm.c
patching file arch/arm/mach-iop32x/iq31244-pci.c
patching file arch/arm/mach-iop32x/iq80321-mm.c
patching file arch/arm/mach-iop32x/iq80321-pci.c
patching file arch/arm/mach-iop32x/irq.c
patching file arch/arm/mach-iop32x/pci.c
patching file arch/arm/mach-iop32x/setup.c
patching file arch/arm/mach-iop32x/time.c
patching file arch/arm/mach-iop33x/Kconfig
patching file arch/arm/mach-iop33x/Makefile
patching file arch/arm/mach-iop33x/Makefile.boot
patching file arch/arm/mach-iop33x/common.c
patching file arch/arm/mach-iop33x/iq80331-mm.c
patching file arch/arm/mach-iop33x/iq80331-pci.c
patching file arch/arm/mach-iop33x/iq80332-mm.c
patching file arch/arm/mach-iop33x/iq80332-pci.c
patching file arch/arm/mach-iop33x/irq.c
patching file arch/arm/mach-iop33x/pci.c
patching file arch/arm/mach-iop33x/setup.c
patching file arch/arm/mach-iop33x/time.c
patching file arch/arm/mach-iop3xx/Kconfig
patching file arch/arm/mach-iop3xx/Makefile
patching file arch/arm/mach-iop3xx/Makefile.boot
patching file arch/arm/mach-iop3xx/common.c
patching file arch/arm/mach-iop3xx/iop321-irq.c
patching file arch/arm/mach-iop3xx/iop321-pci.c
patching file arch/arm/mach-iop3xx/iop321-setup.c
patching file arch/arm/mach-iop3xx/iop321-time.c
patching file arch/arm/mach-iop3xx/iop331-irq.c
patching file arch/arm/mach-iop3xx/iop331-pci.c
patching file arch/arm/mach-iop3xx/iop331-setup.c
patching file arch/arm/mach-iop3xx/iop331-time.c
patching file arch/arm/mach-iop3xx/iq31244-mm.c
patching file arch/arm/mach-iop3xx/iq31244-pci.c
patching file arch/arm/mach-iop3xx/iq80321-mm.c
patching file arch/arm/mach-iop3xx/iq80321-pci.c
patching file arch/arm/mach-iop3xx/iq80331-mm.c
patching file arch/arm/mach-iop3xx/iq80331-pci.c
patching file arch/arm/mach-iop3xx/iq80332-mm.c
patching file arch/arm/mach-iop3xx/iq80332-pci.c
patching file arch/arm/mm/Kconfig
patching file drivers/i2c/busses/Kconfig
patching file include/asm-arm/arch-iop32x/debug-macro.S
patching file include/asm-arm/arch-iop32x/dma.h
patching file include/asm-arm/arch-iop32x/entry-macro.S
patching file include/asm-arm/arch-iop32x/hardware.h
patching file include/asm-arm/arch-iop32x/io.h
patching file include/asm-arm/arch-iop32x/iop321.h
patching file include/asm-arm/arch-iop32x/iq31244.h
patching file include/asm-arm/arch-iop32x/iq80321.h
patching file include/asm-arm/arch-iop32x/irqs.h
patching file include/asm-arm/arch-iop32x/memory.h
patching file include/asm-arm/arch-iop32x/system.h
patching file include/asm-arm/arch-iop32x/timex.h
patching file include/asm-arm/arch-iop32x/uncompress.h
patching file include/asm-arm/arch-iop32x/vmalloc.h
patching file include/asm-arm/arch-iop33x/debug-macro.S
patching file include/asm-arm/arch-iop33x/dma.h
patching file include/asm-arm/arch-iop33x/entry-macro.S
patching file include/asm-arm/arch-iop33x/hardware.h
patching file include/asm-arm/arch-iop33x/io.h
patching file include/asm-arm/arch-iop33x/iop331.h
patching file include/asm-arm/arch-iop33x/iq80331.h
patching file include/asm-arm/arch-iop33x/iq80332.h
patching file include/asm-arm/arch-iop33x/irqs.h
patching file include/asm-arm/arch-iop33x/memory.h
patching file include/asm-arm/arch-iop33x/system.h
patching file include/asm-arm/arch-iop33x/timex.h
patching file include/asm-arm/arch-iop33x/uncompress.h
patching file include/asm-arm/arch-iop33x/vmalloc.h
patching file include/asm-arm/arch-iop3xx/debug-macro.S
patching file include/asm-arm/arch-iop3xx/dma.h
patching file include/asm-arm/arch-iop3xx/entry-macro.S
patching file include/asm-arm/arch-iop3xx/hardware.h
patching file include/asm-arm/arch-iop3xx/io.h
patching file include/asm-arm/arch-iop3xx/iop321-irqs.h
patching file include/asm-arm/arch-iop3xx/iop321.h
patching file include/asm-arm/arch-iop3xx/iop331-irqs.h
patching file include/asm-arm/arch-iop3xx/iop331.h
patching file include/asm-arm/arch-iop3xx/iq31244.h
patching file include/asm-arm/arch-iop3xx/iq80321.h
patching file include/asm-arm/arch-iop3xx/iq80331.h
patching file include/asm-arm/arch-iop3xx/iq80332.h
patching file include/asm-arm/arch-iop3xx/irqs.h
patching file include/asm-arm/arch-iop3xx/memory.h
patching file include/asm-arm/arch-iop3xx/system.h
patching file include/asm-arm/arch-iop3xx/timex.h
patching file include/asm-arm/arch-iop3xx/uncompress.h
patching file include/asm-arm/arch-iop3xx/vmalloc.h
rm 'arch/arm/mach-iop3xx/Kconfig'
rm 'arch/arm/mach-iop3xx/Makefile'
rm 'arch/arm/mach-iop3xx/Makefile.boot'
rm 'arch/arm/mach-iop3xx/common.c'
rm 'arch/arm/mach-iop3xx/iop321-irq.c'
rm 'arch/arm/mach-iop3xx/iop321-pci.c'
rm 'arch/arm/mach-iop3xx/iop321-setup.c'
rm 'arch/arm/mach-iop3xx/iop321-time.c'
rm 'arch/arm/mach-iop3xx/iop331-irq.c'
rm 'arch/arm/mach-iop3xx/iop331-pci.c'
rm 'arch/arm/mach-iop3xx/iop331-setup.c'
rm 'arch/arm/mach-iop3xx/iop331-time.c'
rm 'arch/arm/mach-iop3xx/iq31244-mm.c'
rm 'arch/arm/mach-iop3xx/iq31244-pci.c'
rm 'arch/arm/mach-iop3xx/iq80321-mm.c'
rm 'arch/arm/mach-iop3xx/iq80321-pci.c'
rm 'arch/arm/mach-iop3xx/iq80331-mm.c'
rm 'arch/arm/mach-iop3xx/iq80331-pci.c'
rm 'arch/arm/mach-iop3xx/iq80332-mm.c'
rm 'arch/arm/mach-iop3xx/iq80332-pci.c'
rm 'include/asm-arm/arch-iop3xx/debug-macro.S'
rm 'include/asm-arm/arch-iop3xx/dma.h'
rm 'include/asm-arm/arch-iop3xx/entry-macro.S'
rm 'include/asm-arm/arch-iop3xx/hardware.h'
rm 'include/asm-arm/arch-iop3xx/io.h'
rm 'include/asm-arm/arch-iop3xx/iop321-irqs.h'
rm 'include/asm-arm/arch-iop3xx/iop321.h'
rm 'include/asm-arm/arch-iop3xx/iop331-irqs.h'
rm 'include/asm-arm/arch-iop3xx/iop331.h'
rm 'include/asm-arm/arch-iop3xx/iq31244.h'
rm 'include/asm-arm/arch-iop3xx/iq80321.h'
rm 'include/asm-arm/arch-iop3xx/iq80331.h'
rm 'include/asm-arm/arch-iop3xx/iq80332.h'
rm 'include/asm-arm/arch-iop3xx/irqs.h'
rm 'include/asm-arm/arch-iop3xx/memory.h'
rm 'include/asm-arm/arch-iop3xx/system.h'
rm 'include/asm-arm/arch-iop3xx/timex.h'
rm 'include/asm-arm/arch-iop3xx/uncompress.h'
rm 'include/asm-arm/arch-iop3xx/vmalloc.h'
Checking in...
Different in index and the last commit:
D	arch/arm/mach-iop3xx/Kconfig
D	arch/arm/mach-iop3xx/Makefile
D	arch/arm/mach-iop3xx/Makefile.boot
D	arch/arm/mach-iop3xx/common.c
D	arch/arm/mach-iop3xx/iop321-irq.c
D	arch/arm/mach-iop3xx/iop321-pci.c
D	arch/arm/mach-iop3xx/iop321-setup.c
D	arch/arm/mach-iop3xx/iop321-time.c
D	arch/arm/mach-iop3xx/iop331-irq.c
D	arch/arm/mach-iop3xx/iop331-pci.c
D	arch/arm/mach-iop3xx/iop331-setup.c
D	arch/arm/mach-iop3xx/iop331-time.c
D	arch/arm/mach-iop3xx/iq31244-mm.c
D	arch/arm/mach-iop3xx/iq31244-pci.c
D	arch/arm/mach-iop3xx/iq80321-mm.c
D	arch/arm/mach-iop3xx/iq80321-pci.c
D	arch/arm/mach-iop3xx/iq80331-mm.c
D	arch/arm/mach-iop3xx/iq80331-pci.c
D	arch/arm/mach-iop3xx/iq80332-mm.c
D	arch/arm/mach-iop3xx/iq80332-pci.c
D	include/asm-arm/arch-iop3xx/debug-macro.S
D	include/asm-arm/arch-iop3xx/dma.h
D	include/asm-arm/arch-iop3xx/entry-macro.S
D	include/asm-arm/arch-iop3xx/hardware.h
D	include/asm-arm/arch-iop3xx/io.h
D	include/asm-arm/arch-iop3xx/iop321-irqs.h
D	include/asm-arm/arch-iop3xx/iop321.h
D	include/asm-arm/arch-iop3xx/iop331-irqs.h
D	include/asm-arm/arch-iop3xx/iop331.h
D	include/asm-arm/arch-iop3xx/iq31244.h
D	include/asm-arm/arch-iop3xx/iq80321.h
D	include/asm-arm/arch-iop3xx/iq80331.h
D	include/asm-arm/arch-iop3xx/iq80332.h
D	include/asm-arm/arch-iop3xx/irqs.h
D	include/asm-arm/arch-iop3xx/memory.h
D	include/asm-arm/arch-iop3xx/system.h
D	include/asm-arm/arch-iop3xx/timex.h
D	include/asm-arm/arch-iop3xx/uncompress.h
D	include/asm-arm/arch-iop3xx/vmalloc.h
You might have meant to say 'git commit -i paths...', perhaps?
git commit -F - -- arch/arm/mach-iop32x/Kconfig arch/arm/mach-iop32x/Makefile arch/arm/mach-iop32x/Makefile.boot arch/arm/mach-iop32x/common.c arch/arm/mach-iop32x/iq31244-mm.c arch/arm/mach-iop32x/iq31244-pci.c arch/arm/mach-iop32x/iq80321-mm.c arch/arm/mach-iop32x/iq80321-pci.c arch/arm/mach-iop32x/irq.c arch/arm/mach-iop32x/pci.c arch/arm/mach-iop32x/setup.c arch/arm/mach-iop32x/time.c arch/arm/mach-iop33x/Kconfig arch/arm/mach-iop33x/Makefile arch/arm/mach-iop33x/Makefile.boot arch/arm/mach-iop33x/common.c arch/arm/mach-iop33x/iq80331-mm.c arch/arm/mach-iop33x/iq80331-pci.c arch/arm/mach-iop33x/iq80332-mm.c arch/arm/mach-iop33x/iq80332-pci.c arch/arm/mach-iop33x/irq.c arch/arm/mach-iop33x/pci.c arch/arm/mach-iop33x/setup.c arch/arm/mach-iop33x/time.c include/asm-arm/arch-iop32x/debug-macro.S include/asm-arm/arch-iop32x/dma.h include/asm-arm/arch-iop32x/entry-macro.S include/asm-arm/arch-iop32x/hardware.h include/asm-arm/arch-iop32x/io.h include/asm-arm/arch-iop32x/iop321.h include/asm-arm/arch-iop32x/iq31244.h include/asm-arm/arch-iop32x/iq80321.h include/asm-arm/arch-iop32x/irqs.h include/asm-arm/arch-iop32x/memory.h include/asm-arm/arch-iop32x/system.h include/asm-arm/arch-iop32x/timex.h include/asm-arm/arch-iop32x/uncompress.h include/asm-arm/arch-iop32x/vmalloc.h include/asm-arm/arch-iop33x/debug-macro.S include/asm-arm/arch-iop33x/dma.h include/asm-arm/arch-iop33x/entry-macro.S include/asm-arm/arch-iop33x/hardware.h include/asm-arm/arch-iop33x/io.h include/asm-arm/arch-iop33x/iop331.h include/asm-arm/arch-iop33x/iq80331.h include/asm-arm/arch-iop33x/iq80332.h include/asm-arm/arch-iop33x/irqs.h include/asm-arm/arch-iop33x/memory.h include/asm-arm/arch-iop33x/system.h include/asm-arm/arch-iop33x/timex.h include/asm-arm/arch-iop33x/uncompress.h include/asm-arm/arch-iop33x/vmalloc.h arch/arm/Kconfig arch/arm/Makefile arch/arm/configs/ep80219_defconfig arch/arm/configs/iq31244_defconfig arch/arm/configs/iq80321_defconfig arch/arm/configs/iq80331_defconfig arch/arm/configs/iq80332_defconfig arch/arm/m!
 m/Kconfi
g drivers/i2c/busses/Kconfig arch/arm/mach-iop3xx/Kconfig arch/arm/mach-iop3xx/Makefile arch/arm/mach-iop3xx/Makefile.boot arch/arm/mach-iop3xx/common.c arch/arm/mach-iop3xx/iop321-irq.c arch/arm/mach-iop3xx/iop321-pci.c arch/arm/mach-iop3xx/iop321-setup.c arch/arm/mach-iop3xx/iop321-time.c arch/arm/mach-iop3xx/iop331-irq.c arch/arm/mach-iop3xx/iop331-pci.c arch/arm/mach-iop3xx/iop331-setup.c arch/arm/mach-iop3xx/iop331-time.c arch/arm/mach-iop3xx/iq31244-mm.c arch/arm/mach-iop3xx/iq31244-pci.c arch/arm/mach-iop3xx/iq80321-mm.c arch/arm/mach-iop3xx/iq80321-pci.c arch/arm/mach-iop3xx/iq80331-mm.c arch/arm/mach-iop3xx/iq80331-pci.c arch/arm/mach-iop3xx/iq80332-mm.c arch/arm/mach-iop3xx/iq80332-pci.c include/asm-arm/arch-iop3xx/debug-macro.S include/asm-arm/arch-iop3xx/dma.h include/asm-arm/arch-iop3xx/entry-macro.S include/asm-arm/arch-iop3xx/hardware.h include/asm-arm/arch-iop3xx/io.h include/asm-arm/arch-iop3xx/iop321-irqs.h include/asm-arm/arch-iop3xx/iop321.h include/asm-arm/arch-iop3xx/iop331-irqs.h include/asm-arm/arch-iop3xx/iop331.h include/asm-arm/arch-iop3xx/iq31244.h include/asm-arm/arch-iop3xx/iq80321.h include/asm-arm/arch-iop3xx/iq80331.h include/asm-arm/arch-iop3xx/iq80332.h include/asm-arm/arch-iop3xx/irqs.h include/asm-arm/arch-iop3xx/memory.h include/asm-arm/arch-iop3xx/system.h include/asm-arm/arch-iop3xx/timex.h include/asm-arm/arch-iop3xx/uncompress.h include/asm-arm/arch-iop3xx/vmalloc.h exited with non-zero status: 256
Unable to commit:  at /usr/local/bin/pdb line 253.

Yes, git refuses to commit because I specified files which I wanted to be
committed but were deleted.  It seems that if I _don't_ specify these
files, they aren't committed in any case, unless I specify no files.

git bug I'd say - no way to specify a list of files added, changed _and_
_removed_ to be committed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
