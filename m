Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265040AbSJWO7k>; Wed, 23 Oct 2002 10:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbSJWO7k>; Wed, 23 Oct 2002 10:59:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7216 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265040AbSJWO7g>; Wed, 23 Oct 2002 10:59:36 -0400
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Hearty AOL" for kexec
References: <Pine.LNX.4.44.0210230926320.9286-100000@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Oct 2002 09:03:54 -0600
In-Reply-To: <Pine.LNX.4.44.0210230926320.9286-100000@localhost.localdomain>
Message-ID: <m1hefdrycl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin <proski@gnu.org> writes:

> Hello!
> 
> I have tested the latest kexec patch (linux-2.5.44.x86kexec.diff) with
> the kernel 2.5.44.  It works for me on AOpen AK-33 motherboard with 1GHz
> Athlon.  I tried the same kernel and 2.4.20-pre10.
> 
> I really want to see this feature in the kernel.  It is very useful in
> embedded systems.  Just imagine loading the bootstrap kernel, then
> downloading the new kernel over anything - HDLC, 802.11, USB, decrypting
> it from flash etc.  Possibilities are infinite.

Yay!!!!  My first embedded developer who doesn't think it is silly to
use a kernel as a bootloader :)  Or at least the first to admit they
embedded developer.

I need to brush it off but I have a 16K user space that implements a
standard DHCP/TFTP network bootloader. 16K == sizeof(initrd)

> Believe me, this code is needed, and there will be kernel hackers using
> it, so if anything needs fixing, it will be fixed by people who know to
> fix it.  It will be more an asset than a responsibility for the kernel
> maintainers.
> 
> That said, I don't like the name kexec, and especially the work "execing" 
> in arch/i386/config.in.  I think "in-kernel bootloader" or something like 
> that would be better.  It is a reboot after all.

It is basically a kernel level exec system call.
But I will see if I can come up with better wording for arch/i386/config.in.
A mass renaming would probably be a hindrance at this point, unless I
see a name that really screams that it is the perfect name.

> Little fix: there is no need to add kexec.o twice to obj-$(CONFIG_KEXEC)
> in kernel/Makefile - it causes rebuilding kexec.o on every make.  One time 
> is enough.

Oh, thanks.  When I updated my patch at some point that line must have
doubled.
 
> Little bug (missing feature): I cannot execute memtest.bin 
> (http://www.memtest86.com/):
> 
> ./kexec /boot/memtest.bin
> read error: Success
> Cannot determine the file type of /boot/memtest.bin

Sorry to be clear:
./kexec memtest 
is the case that is expected to work.

My user space code currently understands two images formats.
bzImage 2.0 or greater and static ELF executables.  So you need
the memtest86 static ELF executable.  
 
> I'm using kexec-tools-1.2.  The rest of the system is Red Hat 8.0.

Thanks for the success report.

Eric

