Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTGGS3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTGGS3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:29:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47006 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264115AbTGGS3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:29:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 7 Jul 2003 11:36:31 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <jamie@shareable.org>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <200307071955.58774.phillips@arcor.de>
Message-ID: <Pine.LNX.4.55.0307071105110.4704@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org> <20030707152339.GA9669@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com>
 <200307071955.58774.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Daniel Phillips wrote:

> On Monday 07 July 2003 19:25, Davide Libenzi wrote:
> >
> > Jamie, looking at those reports it seems it is not only a sound players
> > problem.
>
> You still seem to be having trouble with the idea that the sound servicing
> thread is a realtime process, and thus fundamentally different from other
> kinds of processes.  Could you please explain why you disagree with this?

I'm just trying to figure out why :

1) RealPlayer does not skip on my 2.4.20
2) RealPlayer does not skip on my office XP
3) MediaPlayer does not skip on my office XP

Maybe it is more of an application problem.


> > The *application* has to hint the scheduler, not the user.
>
> Partly true, in that users should be able to supply the hint in some way, they
> desire.  However in this case - Zinf - the point is moot, because Zinf is
> trying hard to give the hint, but it fails because of above-mentioned
> braindamage.

Try to play with SNDCTL_DSP_SETFRAGMENT. Last time I checked the kernel
let you set a dma buf for 0.5 up to 1 sec of play (upper limited by 64Kb).
Feeding the sound card with 4Kb writes will make you skip after about 50ms
CPU blackout at 44KHz 16 bit. RealPlayer uses 16Kb feeding chunks that
makes it able to sustain up to 200ms of blackout.



- Davide

