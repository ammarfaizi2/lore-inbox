Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288321AbSAHUu0>; Tue, 8 Jan 2002 15:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288322AbSAHUuQ>; Tue, 8 Jan 2002 15:50:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30848 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288321AbSAHUuK>; Tue, 8 Jan 2002 15:50:10 -0500
Date: Tue, 8 Jan 2002 15:51:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Castle <dalgoda@ix.netcom.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: "shutdown -r now" (lilo, win98) (fwd)
In-Reply-To: <20020108202358.GO22948@thune.mrc-home.com>
Message-ID: <Pine.LNX.3.95.1020108153345.3179A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Mike Castle wrote:

> On Tue, Jan 08, 2002 at 08:15:07PM +0000, Alan Cox wrote:
> > Some windows driver is assuming things that the BIOS has not cleared up
> > on reset and whichit probably shouldn't. Its not uncommon to have to 
> > powercycle a box between OS's. Sometimes you see it with windows hanging
> > sometimes with Linux
> 
> I thought that Linux forced a cold-restart upon a reboot to solve this very
> issue.  At least wrt the BIOS.
> 
> Perhaps a physical component needs that power cycle to do a reset?
> 

You can force a processor-reset in the simplist way, with an Intel
paged executive....

make a module that has open() only. Call it a character device with
some unused major number. Make a 'device', /dev/reboot with that
major number. 

Install it. When you want to re-boot, execute cat</dev/reboot
from your scripts after file-systems have been umounted.

The simple code in open() is:

   __asm__ __volatile__("movl $0, %%eax\n movl %%eax, %%cr0\n");

Actually, all you have to do is reset the paging-bit when executing
from an area in which there is not a 1:1 correspondence between
physical and virtual (like in the module).

This has worked on every system in which I have found the normal
shut-down code resulted in some strange start-up or a failure to
shut down.

This processor-reset starts execution at 0xffff0000, where the
BIOS ROM exists before it's shadowed, just like power-on.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


