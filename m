Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289325AbSAIKpK>; Wed, 9 Jan 2002 05:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSAIKov>; Wed, 9 Jan 2002 05:44:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:45889 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289322AbSAIKon>; Wed, 9 Jan 2002 05:44:43 -0500
Date: Wed, 9 Jan 2002 11:44:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109114403.E1543@inspiron.school.suse.de>
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br> <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>, <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>; <20020108163925.F1894@inspiron.school.suse.de> <3C3B5580.63DB0760@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C3B5580.63DB0760@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 12:24:32PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 12:24:32PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > > What is 00_nanosleep-5 and bootmem ?
> > 
> > nanosleep gives usec resolution to the rest-of-time returned by
> > nanosleep, this avoids glibc userspace starvation on nanosleep
> > interrupted by a flood of signals. It was requested by glibc people.
> > 
> 
> It would be really nice to do something about that two millisecond
> busywait for RT tasks in sys_nanosleep().  It's really foul.
> 
> The rudest thing about it is that programmers think "oh, let's
> be nice to the machine and use usleep(1000)".  Boy, do they
> get a shock when they switch their pthread app to use an
> RT policy.
> 
> Does anyone have any clever ideas?

actually with a design proposal I did today, I think for x86-64 we'll be
able to reach something of the order of 1msec/100usec of precision in
nanosleep without the need of RT privilegies (note this has nothing to
do with the nanosleep patch in -aa, the nanosleep patch is about the
retval, not about "how time will pass"). However the whole timer
handling will have to be revisited by the time we start to code this.

Andrea
