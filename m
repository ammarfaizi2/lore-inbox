Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRH0U7v>; Mon, 27 Aug 2001 16:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRH0U7l>; Mon, 27 Aug 2001 16:59:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39178 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268916AbRH0U7X>; Mon, 27 Aug 2001 16:59:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 23:06:11 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010827185803Z16034-32384+632@humbolt.nl.linux.org> <200108271955.f7RJtia19506@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200108271955.f7RJtia19506@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827205931Z16232-32383+1742@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 09:55 pm, Richard Gooch wrote:
> Daniel Phillips writes:
> > The quesion is, how do you know you're streaming?  Some files are
> > read/written many times and some files are accessed randomly.  I'm
> > trying to avoid penalizing these admittedly rarer, but still
> > important cases.
> 
> I wonder if we're trying to do the impossible: an algorithm that works
> great for very different workloads, without hints from the process.

By nature, it's impossible to do optimal page replacement without being 
prescient.  Nonetheless, it is possible to spot some patterns and take 
advantage of them.

Look at bzip if you need inspiration.  I've seen it do a few bytes worse 
occasionally, but on average it does the job about 20% better than gzip, 
amazing.

> Shouldn't we encourage use of madvise(2) more? And if needed, add
> O_DROPBEHIND and similar flags for open(2).
> 
> The application knows how it's going to use data/memory. It should
> tell the kernel so the kernel can choose the best algorithm.

The hooks are there but it's unlikely very many people will ever use them, 
even if encouraged.  Also, the kernel has information available to it that 
the application programmer does not.  For example, the kernel knows about the 
current, system-wide load.

The ideal arrangement is for madvise to complement the kernel's automagic 
heuristics.  Bearing that in mind, I'll take care not to break it.

--
Daniel

--
Daniel
