Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268927AbRG0TMs>; Fri, 27 Jul 2001 15:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRG0TMi>; Fri, 27 Jul 2001 15:12:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268927AbRG0TMf>; Fri, 27 Jul 2001 15:12:35 -0400
Date: Fri, 27 Jul 2001 15:12:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hai Xu <xhai@CLEMSON.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about libc.a libgcc.a
In-Reply-To: <000901c116cd$c67b4a40$3cac7f82@crb50>
Message-ID: <Pine.LNX.3.95.1010727150616.2689A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Hai Xu wrote:

> Dear all,
> 
> I am focus on a device driver. I compile it to a model.o and try to insmod
> it to kernel. But when do so, I will get:
> 
> unresolved symbol: __udividi3
> unresolved symbol: __umoddi3
> 
> As someone tell me, I have to link the libgcc.a to my model.o. I did it but
> I when I try to insmod the model.o, I will get segamentation fault.
> 

[SNIPPED...]

You have some 64-bit divisions in your code. Make them shifts.
Everything in drivers will be powers-of-two (except some dumb
printk()s, where somebody tried to make decimals), so shifts
should work fine. If you have some offending decimal math, fix
it to display kbytes, megabytes, or gigabytes before you do
do integer decimal conversion. That way you never have to do
64-bit math.

Don't link in the 'C' runtime library.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


