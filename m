Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTDXQbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTDXQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:31:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50313 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263730AbTDXQbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:31:43 -0400
Date: Thu, 24 Apr 2003 12:46:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <3EA8114A.4020309@techsource.com>
Message-ID: <Pine.LNX.4.53.0304241244430.32333@chaos>
References: <200304241128_MC3-1-35DA-F3DA@compuserve.com>
 <Pine.LNX.4.53.0304241147420.32073@chaos> <3EA8114A.4020309@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
>
> >On Thu, 24 Apr 2003, Chuck Ebbert wrote:
> >
> >
> >
> >>Jens Axboe wrote:
> >>
> >>
> >>
> >>
> >>>>+	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
> >>>> }
> >>>>
> >>>>
> >>>Seconded, it causes a lot more confusion than it does good.
> >>>
> >>>
> >>  The return looks like a function call in that last line.
> >>
> >>  That's one of the few things I find really annoying -- extra parens
> >>are fine when they make code clearer, but not there.
> >>
> >>
> >>-------
> >> Chuck [ C Style Police, badge #666 ]
> >>
> >>
> >
> >return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
> >                                  ^^^^^^|__________ wtf?
> >These undefined numbers in the code are much more annoying to me...
> >but I don't have a C Style Police Badge.
> >
> >Also, whatever that is, 0x400, I'll call it MASK, can have shorter
> >code like:
> >
> >   return (drive->id->cfs_enable_1 && MASK); // TRUE/FALSE
> >... for pedantics...
> >   return (int) (drive->id->cfs_enable_1 && MASK);
> >
> >
> >
> >
>
> That wouldn't work, because && isn't a bitwise operator.  But I agree
> that the ( x ? 1 : 0 ) method may not be very efficient, because it may
> involve branches.
>
> Two alternatives:
>
> (a)     !!(x & 0x400)
>
> (b)     (x & 0x400) >> 10
>

I meant return ((foo & MASK) && 1);

Try it, you'll like it! No shifts, no jumps.

int main()
{
    int foo = 0x12340400;
    printf("%d\n", ((foo & 0x400) && 1));
    printf("%d\n", ((foo & 0x300) && 1));
    printf("%d\n", ((foo & 0x500) && 1));
}



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

