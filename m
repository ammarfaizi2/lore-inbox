Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132891AbRDENLk>; Thu, 5 Apr 2001 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132893AbRDENLa>; Thu, 5 Apr 2001 09:11:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132891AbRDENLO> convert rfc822-to-8bit; Thu, 5 Apr 2001 09:11:14 -0400
Date: Thu, 5 Apr 2001 09:09:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Bart Trojanowski <bart@jukie.net>,
        Manoj Sontakke <manojs@sasken.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version? 
In-Reply-To: <25567.986473592@redhat.com>
Message-ID: <Pine.LNX.3.95.1010405085122.9110B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, David Woodhouse wrote:

> 
> matti.aarnio@zmailer.org said:
> > 	To think of it, there really should be explicitely callable
> > 	versions of these with LinuxKernel names for them, not gcc
> > 	builtins.   That way people would *know* they are doing
> > 	something, which is potentially very slow.
> > 	(And the API would not change from underneath them.) 
> 
> Like include/asm-*/div64.h::do_div()?
> 

Some, perhaps all, of the recent requirements for a 64 bit division
can be handled with the (Intel) 32-bit division because only the
dividend is 64 bits, and the division can be unsigned, i.e.

HIGHLONG = 0x08		; Depends upon caller's stack.
LOWLONG  = 0x0C
DIVISOR  = 0x10

		movl	HIGHLONG(%esp), %edx
		movl	LOWLLONG(%esp), %eax
		movl	DIVISOR(%esp), %ecx
		divl	%ecx,%eax

... returns a longword in %eax

This could be an __inline__ function. Most other stuff can be reduced
with shifts before a 32-bit divide.

64 bit signed division is a bitch in any 32-bit machine because it's
done just line 4th grade long division. There are remainders that have
to carried, etc.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


