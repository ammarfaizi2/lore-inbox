Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTDYSTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTDYSTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:19:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8843 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263594AbTDYSTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:19:04 -0400
Date: Fri, 25 Apr 2003 14:30:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Timothy Miller <miller@techsource.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <Pine.LNX.3.96.1030425141133.16623E-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.53.0304251429020.7388@chaos>
References: <Pine.LNX.3.96.1030425141133.16623E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Bill Davidsen wrote:

> On Thu, 24 Apr 2003, Richard B. Johnson wrote:
>
>
> > > Two alternatives:
> > >
> > > (a)     !!(x & 0x400)
> > >
> > > (b)     (x & 0x400) >> 10
> > >
> >
> > I meant return ((foo & MASK) && 1);
> >
> > Try it, you'll like it! No shifts, no jumps.
>
> Sorry, I still find !!(foo & MASK) easier to read, because !! is only used
> to convert to boolean. Sort of a "boolean cast" in effect. It jumps out at
> you what is intended.
>
> Anyway, a matter of taste, both generate jumpless code.
Yes, you win. This looks good, both as code and as op-codes on
Intel...
#include <stdio.h>
int main()
{
    int i;
    int mask = 0x40;
    for(i=0; i< 0x1000; i++)
        printf("%08x\n", !!(i & mask));
}

You need to actually change something, hense the for() loop. Otherwise
gcc just optimizes everything to a 1!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

