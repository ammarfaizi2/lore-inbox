Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbTCaPgr>; Mon, 31 Mar 2003 10:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbTCaPgq>; Mon, 31 Mar 2003 10:36:46 -0500
Received: from almesberger.net ([63.105.73.239]:787 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id <S261690AbTCaPgp>;
	Mon, 31 Mar 2003 10:36:45 -0500
Date: Mon, 31 Mar 2003 12:48:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTRACE_KILL doesn't (2.5.44 and others)
Message-ID: <20030331124800.H7414@almesberger.net>
References: <20030330205126.G7414@almesberger.net> <20030331145519.GA12984@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331145519.GA12984@win.tue.nl>; from aebr@win.tue.nl on Mon, Mar 31, 2003 at 04:55:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> First of all, it is dangerous to depend on subtle properties
> of obscure calls like ptrace.

Indeed ;-) Well, there are worse things, e.g. DWARF2
information versus optimization.

> The Linux man page says

It also says (man-pages-1.56):

| For requests other than  PTRACE_KILL,  the  child  process
| must be stopped.

Of course, it doesn't explicitly say that PTRACE_KILL will do
anything in this case, but the wording kind of suggests that.

> Since it is not clear what the right behaviour is, it is not clear
> whether there is something to fix.

Yes, that's my question. If we're trying to emulate the exact
behaviour of some other OS or some specification, that would
give the answer. If not, we can decide what makes sense, and,
if a change would be needed for the semantics to make sense,
whether it's worth making that change.

At least it seems that existing code is fine with how
PTRACE_KILL works, given how long it has behaved like that.
(But then, existing code may rarely use PTRACE_KILL, and may
not be particularly picky about the result.)

What puzzles me a little is that kill(2) seems to do precisely
what I would have expected PTRACE_KILL to do, i.e. kill the
process no matter whether it's stopped or not, and detach from
it. So why is there a PTRACE_KILL in the first place ?

The non-Linux man page you quote says:

|    8     This request causes the child to  terminate  with  the
|          same consequences as exit(2).

Then it would make sense. Of course, this isn't what
PTRACE_KILL does under Linux. Does that non-Linux man page
also say anything about the exit status ?

Another subtlety, seen under 2.5.44: if PTRACE_ATTACH is
immediately followed by PTRACE_KILL, PTRACE_KILL is silently
ignored (no error).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
