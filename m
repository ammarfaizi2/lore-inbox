Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTFDPrc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFDPrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:47:32 -0400
Received: from imap.gmx.net ([213.165.64.20]:26295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263461AbTFDPr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:47:26 -0400
Message-Id: <5.2.0.9.2.20030604172528.00cd4320@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 04 Jun 2003 18:05:18 +0200
To: Tom Sightler <ttsig@tuxyturvy.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk
  trees.
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1054739304.1820.25.camel@iso-8590-lx.zeusinc.com>
References: <5.2.0.9.2.20030604100227.00cd2020@pop.gmx.net>
 <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
 <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
 <5.2.0.9.2.20030604100227.00cd2020@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:08 AM 6/4/2003 -0400, Tom Sightler wrote:

> > >Yes, I thought the same thing, and I did just that, but no, it doesn't
> > >fix the latency issue.  This system has very little running, I made sure
> > >that there were no sound servers such as esd or arts running, nothing.
> > >Basically, a plain KDE (with artsd disabled), mozilla, and Crossover
> > >wine plugin.  Even though I couldn't see how it would affect anything I
> > >tried bumping up the priorities of other processes such as mozilla
> > >itself, X, etc.  Nothing fixed the problem except for lowering the
> > >priority of the wine process.
> >
> > Feel like trying something else for grins?  If it's thud.c type starvation
> > you're seeing, the attached club should beat it into submission.
>
>I gave this a try this morning and it still doesn't seem to solve my
>issue.  I have no idea what is going on with this particular scenario.
>For now I've fixed it with a simple wrapper script that start up wine
>with a '15' nice level.

Ok, at least we know what it's not.  (_slightly_ better than complete unknown;)

>I did do some playing, it seems the problem mostly goes away right
>around nice level 8, before that I seen no noticable difference, after
>that it seems completely gone.  Would there be anything special about
>that range?

A queue's a queue.  What likely matters is what's above there.

>I do have one, probably wildly incorrect theory.  Most of the problems
>I'm seeing seem to revolve around issues when there is a fairly CPU and
>graphics intensive application running.  In this case flash has lots of
>glitzy stuff happening, interactive menus popping up using lots of
>graphics and sound, etc., while in the meantime wine is using lots of
>CPU to keep these things all working.  It almost seems that it's the
>combination of the two of them that leave too little time for sound to
>be played correctly.
>
>As a test of this idea I simply reniced the X server to 19 and the
>problem did get a LOT better, although it did not go completely away.  I
>could make the problem go completely away with the X server niced at 19
>and wine niced at 5.  With X at it's normal 0 nice level I had to renice
>wine to 8 before the problem was corrected.

Can you send me (offline) some top output while it's bust and working to 
ponder?

>This seems to match up with the issue that some people have noted that
>their XMMS skips during virtual desktop switched, etc.

Hmm.  I thought the TIMESLICE_GRANULARITY change that's in mm fixed those.

>I'm not sure if any of that helps anything really, or if there is really
>a "correct" fix for this, or even if this behavior would be considered
>broken.
>
>I've corrected it for now with some simple wrapper scripts to set nice
>levels on the offending processes.  So far this works great.

That's good, but you shouldn't need to.

>  I'll gladly test any other patches, suggestions.

Good.  I do have another rock I'd like to throw at it, but I need to play 
with the idea some more first.  I'll drop you a line privately if I can 
convince it to work as intended.

         -Mike 

