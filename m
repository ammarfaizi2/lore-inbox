Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267127AbTGGQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267135AbTGGQ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:56:57 -0400
Received: from pop.gmx.net ([213.165.64.20]:17636 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267127AbTGGQ4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:56:40 -0400
Message-Id: <5.2.1.1.2.20030707170502.025bd888@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 07 Jul 2003 19:15:25 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.74-mm1
Cc: Mel Gorman <mel@csn.ul.ie>, Daniel Phillips <phillips@arcor.de>,
       Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.co
 m>
References: <Pine.LNX.4.53.0307071408440.5007@skynet>
 <20030703023714.55d13934.akpm@osdl.org>
 <200307060414.34827.phillips@arcor.de>
 <Pine.LNX.4.53.0307071042470.743@skynet>
 <200307071424.06393.phillips@arcor.de>
 <Pine.LNX.4.53.0307071408440.5007@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:47 AM 7/7/2003 -0700, Davide Libenzi wrote:
>On Mon, 7 Jul 2003, Mel Gorman wrote:
>
> > On Mon, 7 Jul 2003, Daniel Phillips wrote:
> >
> > > And set up distros to grant it by default.  Yes.
> > >
> > > The problem I see is that it lets user space priorities invade the 
> range of
> > > priorities used by root processes.
> >
> > That is the main drawback all right but it could be addressed by having a
> > CAP_SYS_USERNICE capability which allows a user to renice only their own
> > processes to a highest priority of -5, or some other reasonable value
> > that wouldn't interfere with root processes. This capability would only be
> > for applications like music players which need to give hints to the
> > scheduler.
>
>The scheduler has to work w/out external input, period. If it doesn't we
>have to fix it and not to force the user to submit external hints.

What about internal hints?

Fishing expedition:

I'm tinkering with Linus' backboost trick, and what I'd like to try is 
filtering out things which are doing I/O to graphics card, sound card, 
mouse, kdb... whatnot with an in_interactive_interrupt().  Before I go off 
tilting at that windmill, do you (or anyone) know of any reason why that 
would be either stupid or impossible?

Right now, I've got backboost max cpu consumption restricted, max priority 
restricted /proc enabled and /proc tweakable, but I need to further 
restrict/focus it somehow.  Any ideas wrt taming/focusing the little 
beastie would be appreciated.  I'd really like to get it tame enough to be 
reconsidered...

I like backboost for the desktop quite a bit. Take xmms for instance, fire 
it up and turn on it's cpu-hog-and-a-half gl visualization.  The sound 
thread runs at high priority due to low cpu usage.  The gl thread otoh is 
down in the mud, and is instantly disturbed by background tasks who 
unreasonably ;) want their fair share of cpu.  With backboost, the gl 
thread is boosted above background stuff where he belongs, the whole point 
of interactivity being that it's not only ok to be grossly unfair about 
things a human being is connecting to, it's a goodthing(tm)... worker can 
stare mindlessly at glitz and listen to skip free music while his 
employer's code gets moldy instead of being compiled. ;-)

Neat thing about backboost is that when you cover the gl thread, it 
automagically loses boost, so when unreasonable boss walks in and you cover 
it up, the compile speeds back up.  The glitz thread is only interactive if 
you can see it, and does in fact only receive boost when you can see 
it.  That's pretty cool.

         -Mike 

