Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWAGJbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWAGJbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWAGJbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:31:39 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:4747 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932337AbWAGJbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:31:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client    =?iso-8859-1?q?on=09interactive?= response
Date: Sat, 7 Jan 2006 20:30:58 +1100
User-Agent: KMail/1.9
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601072030.59445.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 16:27, Mike Galbraith wrote:
> >   Personally, I think that all TASK_UNINTERRUPTIBLE sleeps should be
> > treated as non interactive rather than just be heavily discounted (and
> > that TASK_NONINTERACTIVE shouldn't be needed in conjunction with it) BUT
> > I may be wrong especially w.r.t. media streamers such as audio and video
> > players and the mechanisms they use to do sleeps between cpu bursts.
>
> Try it, you won't like it.  When I first examined sleep_avg woes, my
> reaction was to nuke uninterruptible sleep too... boy did that ever _suck_
> :)

Glad you've seen why I put the uninterruptible sleep logic in there. In 
essence this is why the NFS client interactive case is not as nice - the NFS 
code doesn't do "work on behalf of" a cpu hog with the TASK_UNINTERRUPTIBLE 
state. The uninterruptible sleep detection logic made a massive difference to 
interactivity when cpu bound tasks do disk I/O.

Cheers,
Con
