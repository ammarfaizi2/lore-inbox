Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSFERe3>; Wed, 5 Jun 2002 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSFERe2>; Wed, 5 Jun 2002 13:34:28 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:1474 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315628AbSFERe1>;
	Wed, 5 Jun 2002 13:34:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 19:32:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206050957250.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Feeo-0001bQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 17:37, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> 
> > This is precisely the sort of design limitation we're tearing down with
> > these hybrid realtime/non-realtime systems.  Your mistake is assuming
> > that every form of communication between the two has to be tightly
> > coupled.
> 
> No, the mistake is assuming that loosely coupling UNIX to RT lets you
> leverage much of anything from UNIX.

   - Compiler
   - Debugger
   - Editor
   - GUI
   - IPC
   - Any program that doesn't require realtime response
   - Memory protection
   - Physical hardware can be shared
   - I could go on...

> The whole attraction of a hybrid
> system is the idea of building an app in a "normal" operating system on
> top of a realtime layer because it's much easier to code for normal
> operating system than realtime. Normal operating systems lets you have
> real stacks and memory management and paging and fast filesystems and TCP
> and load >= 1.

You're fighting an uphill battle here.  The question of whether users want 
hybrid systems or not has already been answered: it's a definite yes.  At 
this point we're only discussing how best to do it.  I hope.

> And your MP3-player example is a great one of where you don't get much out
> of it. You have to rewrite _everything_ to run in the RT space.

That's something of an exaggeration.  In fact, starting with an audio 
application that was well-factored in the first place, it would not be 
necessary to do such grunt work as breaking out the gui.  A lot of the work 
would consist of removing cruft that was only put in there in the first place 
only to deal with problems inherent in trying to make a non-realtime system 
act as though it were realtime.  It's always a pleasure to heave such dung 
out of an application.

If we do this properly, the first big thing you'll notice is that the latency 
between operating the playback volume control and the change taking effect 
disappears.  You don't have to keep a 1,000 ms buffer any more, in an attempt 
to deal with potential scheduling delays.[1]

That alone is worth the price of admission.

> Yes, doable, but how is it better from a developer perspective than the
> duct-taped RIO approach?  Tape it inside the box with USB (there's your
> shared filesystem) if that makes you happier.

I don't want a RIO ducttaped to the inside of my computer, and anyway, it 
hasn't got a fraction of the memory my personal system has.  I'd consider 
that an inferior solution.

I already have all the hardware I need to run a combined 
realtime/non-realtime system right now, ready to go.  You're arguing I should 
go out and get more, and even suggesting that a duct-taped solution is 
somehow superior to actually thinking the problem through and solving it 
properly in software.  I believe we agree the software-only solution is 
possible, correct?  It's not even particularly hard, as I see it, thanks to 
the way Karim has factored the problem.

[1] Assuming we either preload the mp3 or implement a realtime filesystem, 
the former being nothing more than a quick hack, and the latter being 'hard', 
but hey, if it's not hard it's not interesting, right?

-- 
Daniel
