Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153929AbPGIVm6>; Fri, 9 Jul 1999 17:42:58 -0400
Received: by vger.rutgers.edu id <S153903AbPGIVmu>; Fri, 9 Jul 1999 17:42:50 -0400
Received: from [194.46.8.33] ([194.46.8.33]:6267 "EHLO angusbay.vnl.com") by vger.rutgers.edu with ESMTP id <S153881AbPGIVlS>; Fri, 9 Jul 1999 17:41:18 -0400
Date: Sat, 10 Jul 1999 01:25:27 +0100 (BST)
From: Dale Amon <amon@vnl.com>
Reply-To: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.rutgers.edu
cc: bennett@transnational.net
Subject: Linux and real time process control (Can't sleep less than 20ms)
In-Reply-To: <19990709202830Z154016-4163+689@vger.rutgers.edu>
Message-ID: <Pine.LNX.3.96.990710010050.25053F-100000@angusbay.vnl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Since I happened to be chatting with Richard Gooch
about an area related to timers offline, although
in a different context, I'll toss my ideas into the 
fray.

First, I spent nearly 10 years doing 
real time process control type things.
We never used Unix because it lacked the ability
to accurately control time-based events where
you simply could NOT get things out of sequence or
have two events execute at other than a correct
time +/- some delta. Mostly I was not dealing
with life and death... mostly.

Unix has improved in this, more due to processor
speed and finer time slicing, but I'd still be
leary of controlling seriously critical stuff
with it (go ahead, convince me :-)

I started thinking about this again while
doing a user land serial protocol driver that
requires two indep timers. The only way to do it
is to take a high speed SIGALRM and execute
call backs on timed events from within your
program. This is seriously inefficient when
you may only need a handful of asynch time
interrupts per second. 

This has always struck me as a weakness in
Unix vs say, DEC OS's (or more commonly,
dedicated assembly coded controllers.) If you 
are going to do process control, you would really 
like to register a time based event with the
OS and be awakened to process it within
some reasonably *guaranteeable* delta.
(Otherwise, something might just go 
BOOM and give your employer very bad PR.)

I'm pretty sure some Unices have since added
real time extensions. I've not thought about
it much in years so I haven't really kept
up. However Linux apparently does not. And
I may have some very interesting applications
in about 2 years that will need top notch
industrial strength process control abilities
from a Linux kernel. That's plenty of time
to become second to none.

So has anyone been thinking about this set of
problems? Would it be within the two year 
timeframe? Anyone want to chat about it?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
