Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVALTVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVALTVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVALTUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:20:12 -0500
Received: from waste.org ([216.27.176.166]:24026 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261305AbVALTKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:10:25 -0500
Date: Wed, 12 Jan 2005 11:09:49 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050112190949.GH2940@waste.org>
References: <20050111230642.GD2940@waste.org> <200501120213.j0C2DjGO008084@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501120213.j0C2DjGO008084@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:13:44PM -0500, Paul Davis wrote:
> >And that is a failure of imagination on the part of the JACK
> 
> Please be careful with your words. Based on your comments below, it
> appears that you've never read any of the technical docs on it, and
> almost certainly never read the source code.

I thought I made it clear that I didn't even know the name of library.
And I thought I understood from you that you had to do different
start-up per client depending on whether RT was available. Have I
misunderstood you?

> >A client starts at normal priority, asks jack nicely to promote it to
> >RT, then jackd, if so configured/enabled, calls the wrapper with a PID
> 
> a PID? clients are multithreaded, and only specific threads run with
> RT scheduling (normally just the one created for them by
> libjack). So you presumably mean a TID, which in turn creates a
> problem for any system (e.g. 2.4) where all threads share the PID, and
> sched_setscheduler() really does use the PID as a PID, not a TID.

That actually sounds like an independent API problem.

> but its gets worse. JACK clients need to drop RT scheduling under
> certain, well-defined circumstances. how do they get it back under
> this scheme?

Assuming a more thread-aware API, they just ask for privileges again.
But with the non-thread-aware API, my first reaction would be the thread in
question clones, and the clone drops privileges.

-- 
Mathematics is the supreme nostalgia of our time.
