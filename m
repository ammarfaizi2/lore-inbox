Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSG3QVA>; Tue, 30 Jul 2002 12:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSG3QVA>; Tue, 30 Jul 2002 12:21:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30221 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318317AbSG3QU7>; Tue, 30 Jul 2002 12:20:59 -0400
Date: Tue, 30 Jul 2002 12:18:24 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "T.Raykoff" <traykoff@snet.net>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 IDE channels block each other under load?
In-Reply-To: <Pine.LNX.4.44.0207221859070.18179-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020730121057.4042I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, T.Raykoff wrote:

> This lockup only happens under write load.  Heavy reads don't cause the 
> prob.  Hmmmm.
> 
> Not sure that it really is memory thrashing.  The box is unloaded and 
> really has about 1GB free, to use for buffer as it sees fit.  No I/O to 
> the swap file going on, cause there is no mounted swap.

The aa kernels can be tuned to reduce this to a great extent. It seems to
happen on machines with large memory, so if you don't have that this is
not part of your problem. When doing heavy writes, a lot of data gets
buffered, then bdflush checks and sees that there is a shitload of data to
write and queues it. I used to see it with mkisofs CD images, where I
would get one or even two images in memory before the write started.

Andrea gave me some tips on tuning bdflush, although they work best on his
kernels they help a lot on other kernels as well. The trick seems to be to
check more often and be more aggressive about keeping the size of the
buffered data down by writing a a low threshold. No IDE system is going to
like trying to write 500MB all at once, and the best you can do until low
level changes go in is to start sooner getting the data out.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

