Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbRFTQNC>; Wed, 20 Jun 2001 12:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbRFTQMw>; Wed, 20 Jun 2001 12:12:52 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6785 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263298AbRFTQMp>; Wed, 20 Jun 2001 12:12:45 -0400
Date: Wed, 20 Jun 2001 10:12:38 -0600
Message-Id: <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
In-Reply-To: <01062016294903.00439@starship>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de>
	<01062003503300.00439@starship>
	<200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca>
	<01062016294903.00439@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Wednesday 20 June 2001 06:39, Richard Gooch wrote:
> > Starting I/O immediately if there is no load sounds nice. However,
> > what about the other case, when the disc is already spun down (and
> > hence there's no I/O load either)? I want the system to avoid doing
> > writes while the disc is spun down. I'm quite happy for the system to
> > accumulate dirtied pages/buffers, reclaiming clean pages as needed,
> > until it absolutely has to start writing out (or I call sync(2)).
> 
> I'd like that too, but what about sync writes?  As things stand now,
> there is no option but to spin the disk back up.  To get around this
> we'd have to change the basic behavior of the block device and
> that's doable, but it's an entirely different proposition than the
> little patch above.

I don't care as much about sync writes. They don't seem to happen very
often on my boxes.

> You know about this project no doubt:
> 
>    http://noflushd.sourceforge.net/

Only vaguely. It's huge. Over 2300 lines of C code and >560 lines in
.h files! As you say, not really lightweight. There must be a better
way. Also, I suspect (without having looked at the code) that it
doesn't handle memory pressure well. Things may get nasty when we run
low on free pages.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
