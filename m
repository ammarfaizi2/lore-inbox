Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSFOK5V>; Sat, 15 Jun 2002 06:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSFOK5U>; Sat, 15 Jun 2002 06:57:20 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:29960 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315266AbSFOK5R>; Sat, 15 Jun 2002 06:57:17 -0400
Date: Sat, 15 Jun 2002 12:30:16 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Developing multi-threading applications
Message-ID: <20020615123016.M22429@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <5.1.1.6.0.20020613171707.03f09720@mail.tekno-soft.it> <20020614205601.AAA9369@shell.webmaster.com@whenever> <5.1.1.6.0.20020615104206.05291720@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 11:01:44AM +0200, Roberto Fichera wrote:
> >         Even if that's true, and it's often not, how many different types 
> > of data
> >acquisition can you have? Ten? Twenty? That's a far cry from 300.
> 
> Currently are 190! Always active are ~110! So thinking by separating I/O from
> the computation we double the threads.

So basically you are just traversing your data depedency graph
wrongly. Do a level order traversion if it is a dependency forest
or an breadth first traversion if not.

If this node require IO -> schedule the IO and return back to the upper
level noticing it, that you like to be woken, if the IO is
finished.

If this node require Computation -> do it, if this CPU is the one with
lowest load, else schedule it for the CPU with lowest load.

Continue with next node.

(load is meant "number of compuations with same metric scheduled
on this thread")

Use only one thread per CPU. Try to make the IO-Waiting as unique
as possible (poll would be perfect).


So this is all doable, once you analyze your data dependency
graph properly and make the simulation data driven (which it
usally is).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
