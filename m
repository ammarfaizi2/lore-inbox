Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277808AbRJRRLw>; Thu, 18 Oct 2001 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277828AbRJRRLn>; Thu, 18 Oct 2001 13:11:43 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:27480 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277808AbRJRRLb>; Thu, 18 Oct 2001 13:11:31 -0400
Posted-Date: Thu, 18 Oct 2001 07:32:09 GMT
Date: Thu, 18 Oct 2001 08:32:09 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Timur Tabi <ttabi@interactivesi.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: *(int *)0 = 0
In-Reply-To: <3BCB08B2.5060207@interactivesi.com>
Message-ID: <Pine.LNX.4.21.0110180823550.4173-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timur.

>>> What is the effect of the following statement at the end of a
>>> function definition?
>>>
>>>	*(int *)0 = 0;	

>> That should throw a segmentation fault, in the kernel an OOPS, in
>> this statement the code is trying to dereference a NULL pointer and
>> store a value at 0x0.

> A much smarter way to do this would be to use this code:

> static inline void int3(void) { __asm__ __volatile__ (".byte 0xCC\n"); };

> Granted, it's x86-specific, but it works better, since gdb will halt
> the code right at that spot rather than inside some trap hander.  
> And it's just more elegant.

As I understand it, there's two problems with your suggestion:

 1. The fact that it's x86-specific would rule it out as part of
    the actual code of most functions, as they are designed to
    work on any of the supported processors without change.

    However, this can be dealt with by using a macro function and
    dropping the macro definition in an arch-specific header file.

 2. The code isn't normally designed for what gdb does with it,
    but for what it does when run on its own. I believe that the
    original results in an error message being thrown up on the
    screen, but I suspect your replacement would just halt the
    processor and make the user think Linux had crashed.

Comments, anybody?

Best wishes from Riley.

