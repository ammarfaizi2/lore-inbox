Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130526AbQKIUNb>; Thu, 9 Nov 2000 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQKIUNV>; Thu, 9 Nov 2000 15:13:21 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5505 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130526AbQKIUNG>; Thu, 9 Nov 2000 15:13:06 -0500
Date: Thu, 9 Nov 2000 15:12:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <3A0AFA85.27F38728@didntduck.org>
Message-ID: <Pine.LNX.3.95.1001109150621.15404A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Brian Gerst wrote:

> "Richard B. Johnson" wrote:
> > 
> > `lsmod` shows that a device is open twice when using Linux-2.4.0-test9
> > when, in fact, it has been opened only once.
> > 

> > 
> > When the module is closed, the use-count goes to zero as expected.
> > However, a single open() causes the use-count to be 2.
> 
> This is harmless.  It is caused by a try_inc_mod_count(module) in the
> function calling device_open(), which is the proper way for module
> locking to be handled when not holding the BKL.  You can keep the
> MOD_INC_USE_COUNT in the device driver for compatability with 2.2.
> 
> 				Brian Gerst

This may be, as you say, "harmless". It is, however, a bug. The
reporting must be correct or large complex systems can't be
developed or maintained.

I had two persons, working nearly a week, trying to find out
what one of over 200 processes had a device open when only
one was supposed to have it opened. --Err we have to check
our work here. The fact that something "works" is not
sufficient.

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
