Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSIXQoY>; Tue, 24 Sep 2002 12:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSIXQoY>; Tue, 24 Sep 2002 12:44:24 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:6472 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261705AbSIXQoX>; Tue, 24 Sep 2002 12:44:23 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C78052F7406@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, Andy Isaacson <adi@hexapodia.org>
Cc: Larry McVoy <lm@bitmover.com>,
       =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: RE: 1:1 threading vs. scheduler activations (was: Re: [ANNOUNCE] 
	Native POSIX Thread Library 0.1)
Date: Tue, 24 Sep 2002 09:49:26 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and there are some things that i'm not at all sure can be fixed in any
> reasonable way - eg. RT scheduling. [the userspace library 
> would have to
> raise/drop the priority of threads in the userspace 
> scheduler, causing an
> additional kernel entry/exit, eliminating even the 
> theoretical advantage
> it had for pure user<->user context switches.]

So far, the only reasonable way I have found to put RT *scheduling* on NGPT
has been to modify the priority queues on the scheduler [using a simplified
model of your O(1) scheduler]. That gives you, at least, "real time" versus
the other threads. If you want it versus the whole system, then you can
change the attrs of the thread to be SYSTEM scope, so that they compete for
system resources against everybody else [of course, this is cheating, it is
falling back to 1:1 for the real time case].

There are rough edges still, for mutex (futex) waiter selection, signal
delivery, etc ... but so far, I think it is the best sollution [and I'd love
to hear others :)].

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

