Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVB0XEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVB0XEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 18:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVB0XEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 18:04:13 -0500
Received: from alog0110.analogic.com ([208.224.220.125]:34688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261509AbVB0XDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:03:40 -0500
Date: Sun, 27 Feb 2005 18:02:23 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
cc: linux-kernel@vger.kernel.org
Subject: Re: System call problem
In-Reply-To: <42208509.3080201@euroweb.net.mt>
Message-ID: <Pine.LNX.4.61.0502271755100.20728@chaos.analogic.com>
References: <42208509.3080201@euroweb.net.mt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2005, Josef E. Galea wrote:

> Hi,
>
> I am implemeting a new system call for a project I'm working on. I added the 
> system call to the file arch/i386/kernel/process.c and added the relevant 
> entries in the files arch/i386/entry.S and include/asm-i386/unistd.h. My 
> system call is made up of only two lines, a printk statement, and a return 
> statement which gets the value of a field that I added to the task_struct 
> structure.
>
> I compiled and booted the kernel and am trying to build a user space 
> application that uses my system call, however gcc is returning this error:
> /tmp/cc4zgzUr.o(.text+0x4e): In functiono `get_rmt_paging':
> : undefined reference to `errno'
>
> Can anyone help me with this?
>
> Thanks
> Josef

You can't use kernel headers in user-mode functions. For one thing,
they bring in undefined stuff.

Your user mode code can, of course get the definition of errno
by #include <errno.h>. That's the errno that exists in every user-
mode 'C' program-developed process space. However, if get_rmt_paging
is not one of your functions, you are in trouble by mixing up
user-mode and kernel-mode headers.

Normally, the return value of a kernel function is checked and
if it's negative, the positive equivalent is put into the global
variable errno and then the return value is changed to -1. This
is where the user-mode reference to errno occurs.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
