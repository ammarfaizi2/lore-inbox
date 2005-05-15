Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVEOJ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVEOJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVEOJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:59:16 -0400
Received: from colin.muc.de ([193.149.48.1]:50436 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262658AbVEOJ7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:59:01 -0400
Date: 15 May 2005 11:58:59 +0200
Date: Sun, 15 May 2005 11:58:59 +0200
From: Andi Kleen <ak@muc.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515095859.GG68736@muc.de>
References: <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain> <1116088229.8880.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116088229.8880.7.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 12:30:28PM -0400, Lee Revell wrote:
> On Sat, 2005-05-14 at 16:23 +0100, Alan Cox wrote:
> > On Sad, 2005-05-14 at 00:38, Lee Revell wrote:
> > > Well yes but you would still have to recompile those apps.  And take the
> > > big performance hit from using gettimeofday vs rdtsc.  Disabling HT by
> > > default looks pretty good by comparison.
> > 
> > You cannot use rdtsc for anything but rough instruction timing. The
> > timers for different processors run at different speeds on some SMP
> > systems, the timer rates vary as processors change clock rate nowdays.
> > Rdtsc may also jump dramatically on a suspend/resume.
> > 
> > If the app uses rdtsc then generally speaking its terminally broken. The
> > only exception is some profiling tools.
> 
> That is basically all JACK and mplayer use it for.  They have RT
> constraints and the tsc is used to know if we got woken up too late and
> should just drop some frames.  The developers are aware of the issues
> with rdtsc and have chosen to use it anyway because these apps need
> every ounce of CPU and cannot tolerate the overhead of gettimeofday(). 

I would consider jack broken then. For once it breaks
on Centrinos and on AMD systems with PowerNow and some others which all
have frequency scaling with non pstate invariant TSC.

As an additional problem the modern Opterons which support SMP
powernow can even have completely different TSC frequencies
on different CPUs.

All I can recommend is to use gettimeofday() for this. The kernel
goes to considerable pains to make gettimeofday() fast, and when
it is not fast then the system in general cannot do it better.

-Andi
