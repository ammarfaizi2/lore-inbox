Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTGCMDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTGCMDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:03:31 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:28355 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265145AbTGCMDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:03:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307021808 for interactivity
Date: Thu, 3 Jul 2003 22:21:55 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
References: <200307021823.56904.kernel@kolivas.org> <200307031346.04354.phillips@arcor.de>
In-Reply-To: <200307031346.04354.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307032221.55773.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003 21:46, Daniel Phillips wrote:
> On Wednesday 02 July 2003 10:23, Con Kolivas wrote:
> > This latest patch I'm formally announcing has the base O1int changes so
> > far but includes new semantics for freshly started applications so they
> > can become interactive very rapidly even during heavy load. This
> > addresses the "slow to start new apps" evident in O1int so far.
> >
> > Please test this one and note given just how rapidly things can become
> > interactive it may have regressions in other settings.
>
> Without this patch, audio skips horribly when I drag a large window.  With
> it, audio is skipless during window dragging, so I like this patch,
> whatever it does (maybe you'd like to do a victory lap and re-explain the

Lap complete :) Theory? uh erm it's rather involved but basically instead of 
working off the accumulated sleeping ticks gathered in ten seconds it works 
on the accumulated sleeping ticks gathered till it wakes up. It has non 
linear semantics to cope with the fact that you cant accumulate 10 seconds 
worth of ticks (for example) if only 10 seconds has passed (likewise for less 
time). Also idle tasks are no longer considered fully interactive but idle 
and receive no boost or penalty. Finally they all start with some sleep ticks 
inherited by their parent as though they have been running for 1 second at 
least.

> theory?).  It's not perfect: in Mozilla, scrolling through a long page with
> the mouse still causes skipping.

I have (at least) one more trick up my sleeve which might help this, but this 
time I really do want some time to pass and more people test it (in -mm) 
before making another change.

Con

