Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbRFTEjj>; Wed, 20 Jun 2001 00:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbRFTEj3>; Wed, 20 Jun 2001 00:39:29 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21632 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264476AbRFTEjU>; Wed, 20 Jun 2001 00:39:20 -0400
Date: Tue, 19 Jun 2001 22:39:04 -0600
Message-Id: <200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
In-Reply-To: <01062003503300.00439@starship>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de>
	<01061816220503.11745@starship>
	<01062003503300.00439@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> I never realized how much I didn't like the good old 5 second delay
> between saving an edit and actually getting it written to disk until
> it went away.  Now the question is, did I lose any performance in
> doing that.  What I wrote in the previous email turned out to be
> pretty accurate, so I'll just quote it

Starting I/O immediately if there is no load sounds nice. However,
what about the other case, when the disc is already spun down (and
hence there's no I/O load either)? I want the system to avoid doing
writes while the disc is spun down. I'm quite happy for the system to
accumulate dirtied pages/buffers, reclaiming clean pages as needed,
until it absolutely has to start writing out (or I call sync(2)).

Right now I hack that by setting bdflush parameters to 5 minutes. But
that's not ideal either.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
