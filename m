Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293436AbSBYUCu>; Mon, 25 Feb 2002 15:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSBYUCk>; Mon, 25 Feb 2002 15:02:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23569 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292323AbSBYUCX>; Mon, 25 Feb 2002 15:02:23 -0500
Date: Mon, 25 Feb 2002 15:01:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Paul Jackson <pj@engr.sgi.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.SGI.4.21.0202201220180.557863-100000@sam.engr.sgi.com>
Message-ID: <Pine.LNX.3.96.1020225145745.17391E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Paul Jackson wrote:

> I see three levels of synchonization possible here:
> 
> 1) As Erich did, use IPI to get immediate application
> 
> 2) Wakeup the target task, so that it will "soon" see the
>    cpus_allowed change, but don't bother with the IPI, or
> 
> 3) Make no effort to expedite notifcation, and let the
>    target notice its changed cpus_allowed when (and if)
>    it ever happens to be scheduled active again.

(3) looks good, if the process isn't running it makes little difference on
which CPU it doesn't run. Would probably be enough to ensure that if it is
scheduled active the change is noted at that time. "Eventually" is a good
time to do this, when going through schedule code anyway.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

