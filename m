Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135540AbRD1RzB>; Sat, 28 Apr 2001 13:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135535AbRD1Ryj>; Sat, 28 Apr 2001 13:54:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50953 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132932AbRD1Rya>; Sat, 28 Apr 2001 13:54:30 -0400
Date: Sat, 28 Apr 2001 10:54:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
Message-ID: <Pine.LNX.4.21.0104281046240.9559-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Apr 2001, Peter Osterlund wrote:
> 
> For example, when running the gcc configure script, the X mouse pointer is
> very jerky. The configure script itself runs approximately as fast as in
> 2.4.3.

Ok. Fair enough. The new "run the child first" approach has advantages,
but it is entirely possible that the advantages unfairly prioritize things
that do a lot of forking.

> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.

This, however, is a bash bug, not a kernel issue. Bash does something
strange with the terminal and ignores ^C at times, and basically only
react correctly to the ^C under the right circumstances. Changing the
child to run first probably makes the pre-existing bug much easier to see.

> Reverting the fork patch makes all these problems go away on my machine.

Reverting it outright may be an acceptable approach. I'll think about
it: the arguments _for_ the patch are true and real, and it shows up as
real improvements on some things..

An alternative approach might be to not give the child the _whole_
timeslice, but give it more than half. Partition it out 66% - 33% or
something.

		Linus


