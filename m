Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbRHFMqf>; Mon, 6 Aug 2001 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268302AbRHFMqZ>; Mon, 6 Aug 2001 08:46:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61569 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268295AbRHFMqG>; Mon, 6 Aug 2001 08:46:06 -0400
Date: Mon, 6 Aug 2001 08:45:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Frank Torres <frank@ingecom.net>
cc: Russell King <rmk@arm.linux.org.uk>, jdow@earthlink.net,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
In-Reply-To: <00a801c11e4a$5571a950$66011ec0@frank>
Message-ID: <Pine.LNX.3.95.1010806081157.3088A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Frank Torres wrote:

> 
> > On Fri, Aug 03, 2001 at 04:01:28PM +0200, Frank Torres wrote:
> > > > This is not valid. You cannot reasonably have parity and 8 bits. One
> > > > of them has to go. Either use 8 bits and no parity or 7 bits with
> > > > parity.
> >
> > All standard 16550 family ports support 8 bits _and_ parity.  Ancient
> > serial ports did have a restriction, but that restriction is no more.
> >

He said that he was connecting to a RS232C __terminal__. The fact that
a device (like the 8250x/16550) can be used for non-standard serial
communications is moot if you are not connecting to another 8250x/16550.
And, somebody who has "been doing it for 40 years", as was stated
in one response, should know that.

The RS-232C standard does not provide 8 bits at the same time parity
us enabled. The fact that you "can do it" with certain devices says
nothing for the standard. In fact, to help "fix" communications
problems caused by non-standard hookups, "ISTRIP" was provided in Unix
(and Linux), to strip off the parity bit that shouldn't be there anyway.
It occurs when there is a 7-bit with parity terminal talking to a 8-bit,
no parity host. If you are connecting to a terminal, and have some
communications problems, it's best to feed it standard stuff to start.

The current problem:
During the console initialization sequence, its speed gets set to
38400 baud. This means nothing to a virtual terminal. However, if
the attached RS-232C termional is also being set to the same speed,
this could explain the garbage characters.

So I suggest that Frank set his terminal to 38400 baud and see if
the problems disappear.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


