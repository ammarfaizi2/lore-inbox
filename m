Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317773AbSFLTjt>; Wed, 12 Jun 2002 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSFLTjs>; Wed, 12 Jun 2002 15:39:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46576 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317773AbSFLTjr>; Wed, 12 Jun 2002 15:39:47 -0400
Subject: Re: [PATCH] scheduler hints
From: Robert Love <rml@tech9.net>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Pavel Machek <pavel@ucw.cz>, Helge Hafting <helgehaf@aitel.hist.no>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020612203703.F22429@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 12:39:40 -0700
Message-Id: <1023910780.1476.34.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-12 at 11:37, Ingo Oeser wrote:

> Good idea! 
> 
> And I would say SID instead of UID and give up, if no task in the
> same SID is runnable. 
> 
> One could provide different policies here, which the user can
> choose/combine.
> 
> That way we aren't at least unfair to other users on our remote
> machine.

The solution I am working on now is to just take the timeslice away
later.  I.e., now it is more beneficial to me than later, so give me
some of my future timeslice now.  This is per-process.

It is enforced right now only by a call to sched_hint() with a hint
saying "I am done".  The timeslice used is calculated and your timeslice
is adjusted and if applicable you are removed from the active runqueue.

Next I need to add a check to schedule() to check for processes who are
scheduling off and have not explicitly given the "I am done" hint.  I am
weary of what to do here as I do not want to adversely affect the
fastpath.

That is what I am playing with now, anyhow... but I have been a bit busy
of late and not put enough cycles into it.

	Robert Love

