Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTAJN2u>; Fri, 10 Jan 2003 08:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAJN2u>; Fri, 10 Jan 2003 08:28:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:36993 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265081AbTAJN2s>; Fri, 10 Jan 2003 08:28:48 -0500
Date: Fri, 10 Jan 2003 08:39:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sakib mondal <sakib@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem of undefined reference
In-Reply-To: <F1550VnkB4ltFlmmlQ00000384c@hotmail.com>
Message-ID: <Pine.LNX.3.95.1030110082132.12832A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, sakib mondal wrote:

> Hi,
> 
> Wish you all a happy new year.
> 
> I appologize in case you are getting multiple copies of this message.
> 
> I am facing the problem of "undefined reference" for my task of using 
> extended functionality of linux kernel (2.4.18) as detailed below. I shall 
> appreciate any suggestion to solve the problem.
> 
> 
> I would like to incorporate new functions into linux kernel. Therefore I 
> created a file f.c with function "void foo()". Source f.c uses header file 
> f.h. The header file "f.h" has declaration "extern void foo(void);". I 
> included f.o in the obj-y in the Makefile in the corresponding directory. I 
> could build the new kernel without any error or warning.
> 
> Now, I intended to use the extended functionality of the kernel from my 
> program. I wrote g.c which calls foo(); I have included header f.h in g.c. 
> However when I build g, I get the error:
> 
> "g.o(.text+ox35): undefined reference to `foo`".
> 
> I am unable to understand why "foo" is not resolved as the resident kernel 
> ius built with object f.o. To diagonose the problem further I did the 
> follwing things which could neither solve my problem.

First, you don't resolve external references by including a header file.
External references are resolved by the linker which doesn't read header
files. The prototype(s) in header files just tell the 'C' compiler what
it needs to know about the function parameters.

Second, a user program cannot call a kernel function. That's not how an
operating system works. The general-purpose method of having the kernel
execute something on behalf of the user is through the open()/close()
read()/write()/ioctl() mechanism(s). You make a module containing the
required functionality. The user-mode code opens the device, which in
your case would be a virtual device. The result is a file-descriptor that
the user-mode code uses to communicate with the device.

User-mode code normally communicates with the kernel through the
'C' runtime library. This library translates user-mode calls into
kernel function numbers. After putting the required parameters into
registers, depending upon the specific function number, the 'C' runtime
library code generates a software interrupt (on Intel machines, other
methods exist for other architectures). This signals the kernel
that the user wants it to do something for it.

In principle, you could modify the kernel to add another function number.
But, this is not the correct way to add kernel functionality. The
correct way is to use modules.

> 
> i) Used "EXPORT_SYMBOL(foo);" in f.c and had f.o included in export-objs in 
> the Makefile.  ==> I still get the problem of undefined reference
>

See above.

 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


