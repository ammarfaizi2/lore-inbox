Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbTEHLTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTEHLTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:19:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60547 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261319AbTEHLTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:19:02 -0400
Date: Thu, 8 May 2003 07:33:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <3EB96FB2.2020401@techsource.com>
Message-ID: <Pine.LNX.4.53.0305080729410.16638@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
 <Pine.LNX.4.53.0305071523010.13724@chaos> <52n0hyo85x.fsf@topspin.com>
 <Pine.LNX.4.53.0305071547060.13869@chaos> <3EB96FB2.2020401@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
> >
> > When a caller executes int 0x80, this is a software interrupt,
> > called a 'trap'. It enters the trap handler on the kernel stack,
> > with the segment selectors set up as defined for that trap-handler.
> > It happens because software told hardware what to do ahead of time.
> > Software doesn't do it during the trap event. In the trap handler,
> > no context switch normally occurs.
>
> On typical processors, when one gets an interrupt, the current program
> counter and processor state flags are pushed onto a stack.  Which stack
> gets used for this?
>

In protected mode, the kernel stack. And, regardless of implimentation
details, there can only be one. It's the one whos stack-selector
is being used by the CPU. So, in the case of Linux, with multiple
kernel stacks (!?????), one for each process, whatever process is
running in kernel mode (current) has it's SS active. It's the
one that gets hit with the interrupt.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

