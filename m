Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUCAOfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUCAOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:35:00 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:63751 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261297AbUCAOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:34:18 -0500
Date: Mon, 1 Mar 2004 11:32:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@dmt.cyclades
To: Arnd Bergmann <arnd@arndb.de>
cc: kernel-janitors@lists.osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: finding unused globals in the kernel
In-Reply-To: <200402282213.34657.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44.0402282059580.2546-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Feb 2004, Arnd Bergmann wrote:

> I've been looking for a way to find symbols in the kernel that
> are not referenced anywhere and could be removed. This script is
> what I came up with, it's rather slow and complicated, but I have
> managed to find quite a bit of dead code with it.
> 
> It will also write a message for symbols that are both defined
> static and global in some places, that information is available
> for free here.
> 
> Going through the output might be a long-term task for the
> janitors.
> 
> As an example, I'm including the output of the script for the
> current i386 defconfig.

<snip>

> bash /home/arnd/linux-2.6-ipc/scripts/checkunused.sh i386 arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  arch/i386/power/built-in.o  net/built-in.o
> unreferenced definition VSYSCALL_BASE

Hi Arnd,

It seems your script is behaving wrongly for the VSYSCALL_BASE case 
(probably others too):

elf.h:

#define VSYSCALL_BASE   (__fix_to_virt(FIX_VSYSCALL))
#define VSYSCALL_EHDR   ((const struct elfhdr *) VSYSCALL_BASE)
#define VSYSCALL_ENTRY  ((unsigned long) &__kernel_vsyscall)
extern void __kernel_vsyscall;






