Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131120AbQKIU55>; Thu, 9 Nov 2000 15:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131176AbQKIU5i>; Thu, 9 Nov 2000 15:57:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8833 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131120AbQKIU5b>; Thu, 9 Nov 2000 15:57:31 -0500
Date: Thu, 9 Nov 2000 15:57:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <3A0B08A4.38A37F1F@mandrakesoft.com>
Message-ID: <Pine.LNX.3.95.1001109154744.16836A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Jeff Garzik wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Thu, 9 Nov 2000, Brian Gerst wrote:
> > 
> > > "Richard B. Johnson" wrote:
> > > >
> > > > `lsmod` shows that a device is open twice when using Linux-2.4.0-test9
> > > > when, in fact, it has been opened only once.
> > > >
> > 
> > > >
> > > > When the module is closed, the use-count goes to zero as expected.
> > > > However, a single open() causes the use-count to be 2.
> > >
> > > This is harmless.  It is caused by a try_inc_mod_count(module) in the
> > > function calling device_open(), which is the proper way for module
> > > locking to be handled when not holding the BKL.  You can keep the
> > > MOD_INC_USE_COUNT in the device driver for compatability with 2.2.
> > >
> > >                               Brian Gerst
> > 
> > This may be, as you say, "harmless". It is, however, a bug. The
> > reporting must be correct or large complex systems can't be
> > developed or maintained.
> > 
> > I had two persons, working nearly a week, trying to find out
> > what one of over 200 processes had a device open when only
> > one was supposed to have it opened. --Err we have to check
> > our work here. The fact that something "works" is not
> > sufficient.
> 
> There is NO guarantee that module use count == device open count.  Never
> has been, AFAIK.  It just happens to work out that way on a lot of
> pre-2.4 code.
> 
> The kernel is free to bump the module reference count up and down as it
> pleases.  For example, if a driver creates a kernel thread, that will
> increase its module usage count by one, for the duration of the kernel
> thread's lifetime.
> 
> The only rule is that you cannot unload a module until its use count it
> zero.  
> 
> 	Jeff
> 

I suppose. Look at what you just stated! This means that a reported
value is now worthless.

To restate, somebody decided that we didn't need this reported value
anymore. Therefore, it is okay to make it worthless.

I don't agree. The De-facto standard has been that the module usage
count is equal to the open count. This became the standard because
of a long established history.

This is one of the tools we use to verify that an entire system
is functioning properly. Now, somebody decided that I didn't need
this tool.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
