Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUJUMP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUJUMP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUJUMOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:14:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268698AbUJUMKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:10:37 -0400
Date: Thu, 21 Oct 2004 08:10:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Paulo Marques <pmarques@grupopie.com>
cc: Mildred Frisco <mildred.frisco@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: making a linux kernel with no root filesystem
In-Reply-To: <417792F0.20008@grupopie.com>
Message-ID: <Pine.LNX.4.61.0410210757040.10239@chaos.analogic.com>
References: <e7b30b2404102102466dc71118@mail.gmail.com>
 <e7b30b24041021030535925d1d@mail.gmail.com> <417792F0.20008@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, Paulo Marques wrote:

> Mildred Frisco wrote:
>> Hi,
>> I would like to ask help in compiling a minimal linux kernel.
>> Basically, it would only contain the kernel andno filesystem (or
>> probably devfs).  I would only have to boot the kernel from floppy.
>> Then after the necessary kernel initializations, I would issue a
>> prompt where I can either shutdown or reboot the system. That's the
>> only functionality required.  As I've learned from the init program
>> (and startup scripts), the init services and shutdown commands are
>> called from /sbin. However, I do not require to mount the root fs
>> anymore.  I also tried to search for the source code of the shutdown
>> program but I can't find it.  Please help on the steps that I should
>> do.
>
> Your /sbin/init can be a simple script (or even just bash or another shell).
>
> You can use statically compiled binaries against dietlibc from here:
>
> ftp://foobar.math.fu-berlin.de:2121/pub/dietlibc/bin-i386/
>
> If you use "ash" as /sbin/init and place busybox there with the appropriate 
> symlinks, you get a small semi-functional shell for a mere 120kb of 
> executables.
>
> If you're really desperate for space, you can build your own executable that 
> asks for shutdown/reboot and calls reboot(2) with the appropriate parameters, 
> and link against dietlibc (or ulibc).
>
> This is not really kernel related and you should not mess with the kernel 
> code for acomplishing this. If you really need to cut down extra space in the 
> kernel you can check the patches from the "tiny" tree to build an incredibly 
> small kernel.
>
> I hope this helps,
>
> -- 
> Paulo Marques - www.grupopie.com


Let me add the basics that the kernel expects to execute
/sbin/init. This means that there must be a root file-system
to contain it. However, it can be a RAM-disk. That's how
initrd works. /sbin/init can be a program that you write
that does everything you need yout system to do. It can
fork off multiple tasks, etc. Just don't accidentally call
exit() or return from main()!

The kernel configuration can be changed so that it's really
small. It is possible to boot the Linux operating system plus
an entire network router from a 1.44Mb floppy disk, or anything
that can emulate such a disk (a NVRAM disk).

Shutdown and reboot are simple, for instance 'reboot' is
system-call number 88. It takes some documented parameters.
You don't really need a 'C' runtime library if you want
to make your own interface to the kernel. The kernel
directly provides the non-buffered file stuff, basically
most everything in unistd.h and more.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
