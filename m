Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUJTOmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUJTOmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUJTOjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:39:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268029AbUJTOeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:34:36 -0400
Date: Wed, 20 Oct 2004 10:34:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tomas Carnecky <tom@dbservice.com>
cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my opinion about VGA devices
In-Reply-To: <417672BF.5040708@dbservice.com>
Message-ID: <Pine.LNX.4.61.0410201022370.12062@chaos.analogic.com>
References: <417590F3.1070807@dbservice.com> <200410201318.26430.oliver@neukum.org>
 <41765A8C.2020309@dbservice.com> <Pine.LNX.4.61.0410200851080.10711@chaos.analogic.com>
 <417672BF.5040708@dbservice.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Tomas Carnecky wrote:

> Richard B. Johnson wrote:
>
>> On ix86 machines, regardless of whatever code initialized the
>> hardware, if the screen-card is not put into graphics mode,
>> anybody can write characters and attributes at 0xb8000 directly
>> to the screen. Even user-mode code can mmap() that area and write
>> to it. So, the key seems to be to get out of graphics mode
>> before suspend, and go back later after resume.
>
> Why do you let user-mode programs access the hardware directly?
> You don't do this with network devices (there you have syscalls), you don't 
> do this with sound devices (alsa).

Any root process can mmap() any of the memory-mapped hardware
including network devices. This isn't normally done because
handling interrupts from such hardware isn't very efficient
in user-mode, and redistributing data meant for another
process would be a nightmare. However, it can be done.

> IMO it makes a proper power managment implementation impossible.
>

Wrong. The 'normal' user can't do such I/O, root can. See iopl(), which
sets the I/O privilege level. This has nothing to do with power-
management.

> You can say that there are two different drivers for screen-cards in the 
> kernel. One is the VGA which enables the card during early boot time to 
> display the first text messages and the other is fb/DRI or even an nvidia/ati 
> kernel module which is enabled later on.

Doesn't require two drivers.

> Last time I've tried a LiveCD distro I've seen a nice boot console with 
> background picture, high resolution (1024x768) and nice small font. That 
> means that the framebuffer driver had to be initialized at that time. I don't 
> have framebuffer drivers compiled into my kernel so I don't know at which 
> point these are initialized, but it must be at a quite early point in the 
> boot process.

Even Fedora, which boots in a 'graphical' mode, really boots standard
text-mode until 'init' gets control. They just hide the console output
by setting the grub command-line parameter, "quiet".

The kernel messages are still available using `dmesg`. If you want
to eliminate any possibility of losing kernel messages because
the kernel failed to get up all the way, just use /dev/ttyS0 as
your console during boot.

> When looking at the output of dmesg I can see that the first thing that is 
> initialized are the CPU's, ACPI, IRQ's and then the PCI bus is scanned. Did 
> anyones machine crash during these steps? I don't think a healthy box will 
> crash here. And at this point you can initialize your graphics card driver 
> like it is done in the LiveCD distro.
>
> tom
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
