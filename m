Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273281AbRINEbO>; Fri, 14 Sep 2001 00:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273280AbRINEbE>; Fri, 14 Sep 2001 00:31:04 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:2578 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S273281AbRINEaz>; Fri, 14 Sep 2001 00:30:55 -0400
Message-Id: <200109140431.f8E4VEk28518@cambot.lecs.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: jelson@circlemud.org
Subject: Re: User Space Emulation of Devices
In-Reply-To: <20010912214444Z271795-760+12170@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28515.1000441874.1@cambot.lecs.cs.ucla.edu>
Date: Thu, 13 Sep 2001 21:31:14 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Coincidentally enough I was about to release a system called FUSD
which does exactly what you describe - marshal the arugments of a
system call into a message and proxy it to userspace.  The source will
be out in a couple of days, but for now here's a link to some
incomplete documentation:

http://www.circlemud.org/~jelson/software/fusd

FUSD (pronounced "fused", as in fusing kernel with userspace) is a
Linux framework for proxying device file callbacks into user-space,
allowing device files to be implemented by daemons instead of kernel
code. Despite being implemented in user-space, FUSD devices can look
and act just like any other file under /dev which is implemented by
kernel callbacks.

FUSD drivers are conceptually similar to kernel drivers: a set of
callback functions called in response to system calls made on file
descriptors by user programs. FUSD's C library provides a device
registration function, similar to the kernel's devfs_register_chrdev()
function, to create new devices. fusd_register() accepts the device
name and a structure full of pointers. Those pointers are callback
functions which are called in response to certain user system
calls--for example, when a process tries to open, close, read from, or
write to the device file. The callback functions should conform to the
standard definitions of POSIX system call behavior. In many ways, the
user-space FUSD callback functions are identical to their kernel
counterparts.



>Followup to: <20010912214444Z271795-760+12170@vger.kernel.org>
>By author: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
>In newsgroup: linux.dev.kernel
>>
>> How do you pass an ioctl ? If any parameter is a pointer you actually need a
>> complex protocol for passing memory content to make it useful.
>>
>
>You need a parameter marshalling system; however, they do exist. It
>might actually be that the best way to deal with this is to make a
>general module framework and compile a specific module to marshall the
>parameters of the device you want to emulate.

