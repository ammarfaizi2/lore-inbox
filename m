Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbTC1VnR>; Fri, 28 Mar 2003 16:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTC1VnQ>; Fri, 28 Mar 2003 16:43:16 -0500
Received: from ns0.cobite.com ([208.222.80.10]:28945 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S263159AbTC1VnP>;
	Fri, 28 Mar 2003 16:43:15 -0500
Date: Fri, 28 Mar 2003 16:54:26 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: very poor performance in 2.5.66[-mm1]
In-Reply-To: <20030328124451.2d09bd33.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303281641320.11928-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Andrew Morton wrote:
> > After all of the rave reviews about the interactivity fixes (both regular 
> > and I/O scheduler related), I decided to give the 2.5.latest a try on my 
> > desktop machine (system described below)
> > 
> > I started X, everything seemed fine, maybe a bit faster.  I opened a 
> > 'gnome-terminal' and typed 'ls -ltr'.  Wow, it was 20x slower.
> > 
> > Here are the timings for 'ls -ltr':
> > 
> > 2.5.66-mm1:      'ls -ltr'         31 seconds
> > 2.5.66-mm1:      'ls -ltr | cat'   2 seconds
> > 2.4.18-rhlatest: 'ls -ltr'         1.14 seconds
> 
> How many files were there?

1337 files.

> My /usr/bin contains 3168 files.  An `ls -ltr' in gnome-terminal takes 9.6
> seconds.  In rxvt it takes 0.5 seconds.  That's an 850MHz P3.
> 
> So gnome-terminal appears to be a pretty slow application.  My guess would be
> that something in the 2.5 kernel has exposed a marginality or an outright
> bug in it.

Yes. gnome-terminal is godawful slow on RHAT 8.0 (it does Xrender
alpha-channel crap for every character to get the anti-aliasing).  But I
think the problem has to do with the pipe/pty wakeups.  After 'ls' writes
a line to the pty, it seems as though the gnome-terminal is being woken up
(even though 'ls' has more to write), it's generating the Xrender 
X-command and sending it to X.  X is waking up and rendering it (which 
forces a complete update of the screen).

Under 2.4.18-whatever, it would seem as though 'ls' is generating a large
number of lines of output before the gnome-terminal is waking up, causing
a dramatically fewer number of redraws.

> It would be interesting to edit include/asm-i386/param.h and set HZ to 100.
> 

I'll try to check this out over the weekend.

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

