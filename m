Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSKUUVv>; Thu, 21 Nov 2002 15:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSKUUVv>; Thu, 21 Nov 2002 15:21:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22145 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264624AbSKUUVu>; Thu, 21 Nov 2002 15:21:50 -0500
Date: Thu, 21 Nov 2002 15:31:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matt Young <wz6b@arrl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Operations inside a module
In-Reply-To: <200211211159.03552.wz6b@arrl.net>
Message-ID: <Pine.LNX.3.95.1021121152104.8882A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Matt Young wrote:

> Within the open routine of  my module I need to open another device; and the 
> write routine needs to write to the other device.
> 
> User space system calls seem to be unavailable to module code.
> I know about swapping the DS and ES to fake out other modules; then using 
> sys_write etc. 
> 
> Can my code just include the standard  syscall lib and use them from kernel 
> space?
> 
> My module code would also like to use user space malloc, is this a problem?
> 
> Matt
> 

This is a FAQ by people who think a module is just some 'C' code that
you hack.

To use open/close/read/write files, you need a process context. You
can make one by creating a kernel thread. The kernel is some protected
code that performs tasks on behalf of the caller, in the context of
the caller. You can't call the kernel from within the kernel, i.e.,
sys-calls because you will never get back. It's like main() calling main()
in user-mode 'C'. And if you "know about swapping DS and ES", as you
state, then you know nothing and shouldn't get near kernel code.

If you need read or write from a device in the kernel, you just
read or write, just put your request in the queue for that device.
Of course if you really mean "files", then your module is broken by
design.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


