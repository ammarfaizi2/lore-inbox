Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272875AbTG3Mi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272878AbTG3Mi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:38:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:982 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S272875AbTG3Miz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:38:55 -0400
Subject: Re: another must-fix: major PS/2 mouse problem
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mikpe@csd.uu.se, 0@pervalidus.tk, pavel@ucw.cz,
       Andrew Morton <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>, zwane@arm.linux.org.uk,
       linux-yoann@ifrance.com, vojtech@suse.cz
In-Reply-To: <20030730050857.GF2601@openzaurus.ucw.cz>
References: <3EDCF47A.1060605@ifrance.com>
	 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
	 <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org>
	 <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org>
	 <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
	 <1059447325.3862.86.camel@cube> <20030728201459.78c8c7c6.akpm@osdl.org>
	 <20030730050857.GF2601@openzaurus.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1059568172.3861.173.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jul 2003 08:29:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 01:08, Pavel Machek wrote:
> Hi!
> 
> > > Loosing too many ticks!
> > > TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> > > Falling back to a sane timesource.
> > > psmouse.c: Lost synchronization, throwing 3 bytes away.
> > > psmouse.c: Lost synchronization, throwing 1 bytes away.
> > > 
> > > Arrrrgh! The TSC is my only good time source!
> > 
> > Arrrgh!  More PS/2 problems!
> > 
> > I think the lost synchronisation is the problem, would you agree?
> > 
> > The person who fixes this gets a Nobel prize.
> 
> 
> If you set ps/2 synchronization timeout to 20 seconds, you are going to make vojtech
> unhappy (he likes that code :-), but at least 2.6.0 will not be worse than 2.4.x...
> 
> Do you want me to create a patch?

No. That will just hide one symptom of the problem,
making things more difficult to debug.

It won't fix my clock, which the ntpd program keeps
complaining about. Under heavy load, my clock falls
behind so much that ntpd gives up on the gentle treatment
and just yanks the clock forward by as much as 10 minutes.

It won't make the mouse run well. Maybe you'd stop the
mouse from going crazy from time to time, but there'd
still temporary freezes from time to time. (not OK!)

It won't convince Linux that my TSC isn't broken.

It won't solve Mikael Pettersson's problem, posted
under the subject "[BUG] 2.6.0-test2 loses time on 486".
He writes:

"My old 486 test box is losing time at an alarming rate
when running 2.6.0-test kernels. It loses almost 2 minutes
per hour, less if it sits idle. This problem does not
occur when it's running a 2.4 kernel."

Gee, I get that too, on a 1 GHz Pentium III. It seems
we're all losing LOTS of clock ticks and other interrupts.

I took the net-related email addresses off the Cc: list.
Please leave me on it so I don't have to break threading.


