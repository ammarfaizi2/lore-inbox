Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSAHNW3>; Tue, 8 Jan 2002 08:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288013AbSAHNWU>; Tue, 8 Jan 2002 08:22:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29452 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288012AbSAHNWL>; Tue, 8 Jan 2002 08:22:11 -0500
Date: Tue, 8 Jan 2002 14:21:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108142117.F3221@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <Pine.LNX.4.33.0201081153310.29480-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201081153310.29480-100000@Expansa.sns.it>; from kernel@Expansa.sns.it on Tue, Jan 08, 2002 at 11:55:59AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:55:59AM +0100, Luigi Genoni wrote:
> 
> 
> On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote (passim):
> 
> > Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or
> > -rmap?
> [...]
> > Maybe preemption? It is disengageable so nobody should be harmed but we get
> > the chance for wider testing.
> >
> > Any comments?
> preemption?? this is eventually 2.5 stuff, and should not be integrated

indeed ("eventually" in the italian sense btw, obvious to me, but not
for l-k).

I'm not against preemption (I can see the benefits about the mean
latency for real time DSP) but the claims about preemption making the
kernel faster doesn't make sense to me. more frequent scheduling,
overhead of branches in the locks (you've to conditional_schedule after
the last preemption lock is released and the cachelines for the per-cpu
preemption locks) and the other preemption stuff can only make the
kernel slower.  Furthmore for multimedia playback any sane kernel out
there with lowlatency fixes applied will work as well as a preemption
kernel that pays for all the preemption overhead.

About the other claim that as the kernel becomes more granular
performance will increase with preemption in kernel, that's obviously
wrong as well, it's clearly the other way around. Maybe it was meant
"latency will decrease further", that's right, but also performance will
decrease if something.

So yes, mean latency will decrease with preemptive kernel, but your CPU
is definitely paying something for it.

> into 2.4 stable tree. Of course a backport is possible, when/if it will be
> quite well tested and well working on 2.5
> 
> 
> 
> 


Andrea
