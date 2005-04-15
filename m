Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVDORQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVDORQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVDORQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:16:48 -0400
Received: from alog0416.analogic.com ([208.224.222.192]:16536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261867AbVDORQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:16:44 -0400
Date: Fri, 15 Apr 2005 13:16:24 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Allison <fireflyblue@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
In-Reply-To: <17d798805041509022ba6df49@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504151258540.31259@chaos.analogic.com>
References: <17d798805041509022ba6df49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Allison wrote:

> Hi,
>
> I was curious about how kernel rootkits become a part of the kernel ?
> One way I guess is by inserting a kernel module.  And rootkits also
> manage to hide themselves from rootkit detectors.
>

I'm not sure there really are any "kernel" rootkits. You need to be
root to install a module and you need to be root to replace a kernel
with a new (possibly altered) one. If you are root, you don't
need an exploit.

> few questions:
> 1. Are there any other ways by which rootkits become part of the kernel ?
>

Anybody with knowledge of kernel internals could write some code
and put it into the kernel. The code could do anything the kernel
can do. That kernel could replace an existing one.

You can make your own development system where you know the root
password. You can make a new kernel with whatever Trojans you
want, create a bootable floppy (or Flash RAM disk), then reboot
the target machine with that boot device. The new kernel and its
startup code that you develop could mount the target-machine
root file-system and replace its kernel with yours.

A subsequent reboot brings up the target machine as though
normal. Then, whenever you are logged onto the target machine,
even as a normal user, you could call your new kernel function
with a simple 'C' program.

> 2. If modules can access only exported symbols, how is it that kernel
> rootkits manage to get hold of other information from the kernel ? For
> ex, the process table.
>

Modules can access any symbol that is in /boot/System.map if it's
the correct System.map for the current kernel version.

> I am not familiar with the /dev/kmem interface. Does this interface
> let any kernel module read any symbol (even non-exported) from the
> kernel ?
>

That doesn't contain symbols. It's a binary image of the executing
kernel. You need to be root to read the contents.

> 3. If I want to hide a function which is part of the kernel from
> kernel modules, is this possible ideally ?

It is possible to obfuscate the function by indirection. As a
practical matter, a module can be built which can access anything
in the kernel address-space. Exporting symbols isn't necessary
at all. It's just a protocol.

>
> thanks,
> Allison
> -


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
