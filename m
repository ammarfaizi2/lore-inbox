Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSHWND5>; Fri, 23 Aug 2002 09:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSHWND5>; Fri, 23 Aug 2002 09:03:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318792AbSHWND4>; Fri, 23 Aug 2002 09:03:56 -0400
Date: Fri, 23 Aug 2002 09:07:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kerenyi Gabor <wom@tateyama.hu>
cc: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: interrupt handler
In-Reply-To: <200208231254.VAA20879@cttsv008.ctt.ne.jp>
Message-ID: <Pine.LNX.3.95.1020823085830.198A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Kerenyi Gabor wrote:

> 8/23/2002 9:17:07 PM, "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> 
> >On Fri, 23 Aug 2002, sanket rathi wrote:
> >
> >> hi,
> >> Can i use spin lock in the interrupt handler for a singlre processor
> >> machine. because books says u can not use locks but spin lock is some
> >> thing diffrent 
> >> 
> >> thanks in advance
> >> 
> >> --Sanket
> >> ---------
> >
> >Interrupts default to OFF within an interrupt handler. Given this,
> >why would you use a spin-lock within the ISR on a single-processor
> >machine?
> 
> Because he would like to write a code that can be run on a computer
> with more than one CPU. 
> 
> Anyway, do anybody know what kind of advantages/disadvantages I can get
> if I don't disable interrupts at all in my driver? Even if I have to
> use a circular
> buffer or anything else? Is it worth trying to find such a solution or is it
> a wasted time?
> 
> Gabor

If your ISR manipulates any data, which is quite likely, then
your driver code, that is outside the ISR, must be written
with the knowledge that an interrupt can happen at any time.

There are probably certain critical regions of code that must
be protected against modification from the ISR code. You need
to protect those critical regions with spin-locks.

Spin-locks have very little code. If there is no contention,
they do not affect performance in any measurable way. If there
is contention, they simply delay execution of the ISR to a time
where code is executing in a non-critical section. This delay
is necessary so, even though it does affect performance, the
system would not work without it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

