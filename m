Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCATfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCATfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:35:32 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:58549 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261366AbUCATfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:35:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: finding unused globals in the kernel
Date: Mon, 1 Mar 2004 20:28:33 +0100
User-Agent: KMail/1.6.1
Cc: kernel-janitors@lists.osdl.org, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402282059580.2546-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0402282059580.2546-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012028.34612.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 March 2004 15:32, Marcelo Tosatti wrote:
> 
> On Sat, 28 Feb 2004, Arnd Bergmann wrote:
> > bash /home/arnd/linux-2.6-ipc/scripts/checkunused.sh i386 arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  arch/i386/power/built-in.o  net/built-in.o
> > unreferenced definition VSYSCALL_BASE
> 
> It seems your script is behaving wrongly for the VSYSCALL_BASE case 
> (probably others too):
> 
> elf.h:
> 
> #define VSYSCALL_BASE   (__fix_to_virt(FIX_VSYSCALL))
> #define VSYSCALL_EHDR   ((const struct elfhdr *) VSYSCALL_BASE)
> #define VSYSCALL_ENTRY  ((unsigned long) &__kernel_vsyscall)
> extern void __kernel_vsyscall;

Actually, VSYSCALL_BASE is defined as an absolute symbol in
arch/i386/kernel/vsyscall.lds, so it's not as broken as one might think.
The bug is that the script cannot find symbols defined by the linker
and used only as a constant in the same linker script. Fortunately, this
isn't done in many places.

	Arnd <><
