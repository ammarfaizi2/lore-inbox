Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267792AbTBRNdu>; Tue, 18 Feb 2003 08:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267793AbTBRNdt>; Tue, 18 Feb 2003 08:33:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50566 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267792AbTBRNdt>; Tue, 18 Feb 2003 08:33:49 -0500
Date: Tue, 18 Feb 2003 08:44:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sudharsan Vijayaraghavan <svijayar@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help !! calling function in module from a user program 
In-Reply-To: <4.3.2.7.2.20030218181634.01fb5428@desh>
Message-ID: <Pine.LNX.3.95.1030218083945.2432B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Sudharsan Vijayaraghavan wrote:

> Hi,
> 
> Am a new bee to linux internals.
> I am trying to make a simple program witch will call a function from a 
> module. I made a module compiled it and INSMOD-it into kernel, that works 
> fine. I would like to call from my user program a function defined in my 
> kernel module.
> 
> Please suggest any method thro' which this could be accomplished.
> The only way i did it was by running my new module as insmod mymodule.o and 
> get my job done.
> 
> Thanks,
> Sudharsan.

Unix/Linux uses open() close() read() write() and ioctl() (plus a few
others) to interface with modules or any kind of driver. To 'call' some
module function from user-mode, you impliment open() and close(). That
will provide a file-descriptor for subsequent operations. Then you
impliment either read() write() or ioctl() or all, whichever is
most appropriate for the function your module is going to provide.

You never 'call' a kernel function directly from user-mode. One of
the kernel's primary functions is to make this impossible. Kernel
code is protected from direct user-mode access.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


