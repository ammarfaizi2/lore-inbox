Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRC2QVE>; Thu, 29 Mar 2001 11:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132767AbRC2QUy>; Thu, 29 Mar 2001 11:20:54 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:48646 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132765AbRC2QUp>; Thu, 29 Mar 2001 11:20:45 -0500
Date: Thu, 29 Mar 2001 18:29:50 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
cc: Andreas Dilger <adilger@turbolinux.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer???
In-Reply-To: <Pine.A32.3.95.1010329160740.63156B-100000@werner.exp-math.uni-essen.de>
Message-ID: <Pine.LNX.4.30.0103291753220.21682-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Mar 2001, Dr. Michael Weller wrote:
> On Thu, 29 Mar 2001, Szabolcs Szakacsits wrote:
> > The point is AIX *can* guarantee [even for an ordinary process] that
> > your signal handler will be executed, Linux can *not*. It doesn't matter
> No it can't... and the reason is...

So AIX is buggy in eager mode not reserving a couple of extra pages [per
process] to be able to run the handler. What AIX version(s) you use?
Anyway, as you probably noticed at present I'm not a big supporter of
introducing SIGDANGER, too many things can be messed up for little
or no gain.

> Note that there are nasty users like me, which provide a no_op function
> as SIGDANGER handler.

For example this.

> Joe blow user can code a SIGDANGER exploiting prog that will kill the
> whole concept by allocating memory in SIGDANGER.

And this. Moreover it shouldn't be malicious, people write happily
sighandlers that would blowup thing even without they realise ...

And admin still have no control over the things ;) Sure it could be
worked around these but I feel it just doesn't worth for the added
complexity.

> About this early alloction myths: Did you actually read the page?
> The fact its controlled by a silly environment variable shows it
> is a mere user space issue.

This is my question as well ;) Although I didn't read the AIX source but
guessed kernel sets a bit in the task structure for eager mode during
the exec() syscall and takes care about everything, at least this is
what the document suggests ;) [see the bottom of the page]

	Szaka

