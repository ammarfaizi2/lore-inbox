Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131521AbRCWXuG>; Fri, 23 Mar 2001 18:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRCWXt5>; Fri, 23 Mar 2001 18:49:57 -0500
Received: from ash.lnxi.com ([207.88.130.242]:251 "EHLO DLT.linuxnetworx.com")
	by vger.kernel.org with ESMTP id <S131521AbRCWXtk>;
	Fri, 23 Mar 2001 18:49:40 -0500
To: Guest section DW <dwguest@win.tue.nl>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Michael Peddemors <michael@linuxmagic.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org> <20010323182105.C6487@win.tue.nl>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 23 Mar 2001 16:48:52 -0700
In-Reply-To: Guest section DW's message of "Fri, 23 Mar 2001 18:21:05 +0100"
Message-ID: <m3ofusgi6z.fsf@DLT.linuxnetworx.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW <dwguest@win.tue.nl> writes:

> On Fri, Mar 23, 2001 at 07:50:25AM -0700, Eric W. Biederman wrote:
> 
> > > Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 2019 (emacs).
> > > Mar 23 11:48:49 mette kernel: Out of Memory: Killed process 1407 (emacs).
> > > Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 1495 (emacs).
> > > Mar 23 11:48:50 mette kernel: Out of Memory: Killed process 2800 (rpm).
> > > 
> > > [yes, that was rpm growing too large, taking a few emacs sessions]
> > > [2.4.2]
> > 
> > Let me get this straight you don't have enough swap for your workload?
> > And you don't have per process limits on root by default?
> > 
> > So you are complaining about the OOM killer?  
> 
> I should not react - your questions are phrased rhetorically.

To some extent I was also very puzzled by your complaint.

You have setup a system that by your definition unreliably and then
you complain it is unreliable.

> 
> But yes, I am complaining because Linux by default is unreliable.
> I strongly prefer a system that is reliable by default,
> and I'll leave it to others to run it in an unreliable mode.

Now all I know the system didn't have enough resources to do what
you asked to it do and it failed.  That sounds reliable to me.  

Obviously you were suprised at how the system failed.  Given
that unix has been doing this kind of thing for decades, you obviously
missed how the unix malloc overcommited memory.

Does you application trap sigsegv on a different stack so you can
catch stack growth failure?  And how does your app handle this case?

Having a no over commit kernel option would help.  

A cheap workaround is to call mlock_all(MCL_FUTRE...).  Then you are
garantteed you will always have ram locked into memory for your
program.   This assumes you have enough ram for your program.

Eric

