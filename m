Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCaXLC>; Sun, 31 Mar 2002 18:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSCaXKx>; Sun, 31 Mar 2002 18:10:53 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:53237 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S288748AbSCaXKd>; Sun, 31 Mar 2002 18:10:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Randy Hron <rwhron@earthlink.net>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Linux 2.4.19-pre5
Date: Sun, 31 Mar 2002 18:11:17 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020330135333.A16794@rushmore> <E16reZK-0001IL-00@pintail.mail.pas.earthlink.net> <1017605142.641.119.camel@psuedomode>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16roT1-0005al-00@pintail.mail.pas.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the problem.  You said it makes the box look like it's halted in your
> tests, I saw no such thing.  

I haven't directly observed any box tightening up for
more than a few seconds.  There have been a few reports
on lkml of things like that happening.  Based on tiotest
results, I can see if the I/O request you are waiting for 
is one of those few that isn't serviced for dozens or
hundreds of seconds, you'll be annoyed.  

The number of requests that takes over 10 seconds is 
often just 3 in 10,000.  There may be only 1 request in 
500,000 that takes 500 seconds to service.  The chance 
of your interactive i/o being the "longest" is small, unless
your interactive work is producing enough I/O to compete
with tiotest.  

What I like about read_latency2 is that most latencies
are less, and the highest latency is much less.
 
> Heh, maybe i'm confused on your definition of the wall. 

Sorry if that wasn't clear.  "The wall" is the point where
the highest latency in the test skyrockets.

For instance, in recent ac kernels, the _highest_ latency for 
sequential reads is less than 5 seconds at 64 threads in all 
the ac's I've tested.  At 128 threads, the _lowest_ max
latency figure is 200 seconds.   So, I used the "wall" term 
for 128 in the ac series.

Similarly, in the Marcelo tree, 1.7 seconds is the _highest_
latency with 16 threads in all the mainline kernels I've tested.
At 32 threads, 137 seconds is the _lowest_ maximum latency.
So I used the idea "wall = 32 threads" for 2.4 mainline.

The actual number of seconds will vary depending on the
hardware.  I've observed the "skyrocketing" max latency
or "wall" phenomemon on several boxes though.

The max latency growth before and after "the wall" is similar
as threads increase.  That is max latency grows slowly, then
jumps enormously, then grows gradually again.

A little picture, not to scale:
m                                        x
a                               x
x                       x                *

l
a
t
e
n
c
y

s
e
q
                                         #
r
e ........ the wall ......................
a                               #
d                       #       *
s               x       * 
       x*#      *#
threads 8       16      32      64      128

* = ac
x = mainline
# = read_latency2

The "not to scale" means the distance between points 
above and below "the wall" is actually much greater.

If you feel like it, perhaps you could test ac with preempt 
and 8 16 32 64 128 256 threads and see if exhibits a wall
pattern or not.  

Thanks for your interest.
