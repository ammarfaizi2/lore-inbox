Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbTJAEgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJAEgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:36:03 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:477 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261908AbTJAEf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:35:58 -0400
Date: Wed, 1 Oct 2003 00:35:50 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031001043550.GC1416@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031001032238.GB1416@Master> <3F7A534B.3020401@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7A534B.3020401@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:08:43PM +1000, Nick Piggin wrote:
> 
> 
> Murray J. Root wrote:
> 
> >P4 2G
> >1G PC2700 RAM
> >ASUS P4S533 
> >
> >Large tasks (like raytrace rendering) take double the amount of time they 
> >used
> >to take, although the system is nicer to the user while they run. In 
> >2.6.0-test5 had a little trouble with it and Piggin pointed me to a patch 
> >that
> >fixed it and is now in -test6, however the patch didn't slow the rendering 
> >as
> >much as it does in test6. (Con Koliva's patch, I believe it was).
> >For example - rendering an image that took 15 minutes in 2.5.65 takes 20 
> >minutes in 2.6.0-test5 (with patch) and 30 minutes in 2.6.0-test6 (raw from
> >kernel.org). Same config options (everything I use builtin - no modules).
> >
> >A new issue (which also doesn't happen in -test5 with the patch):
> >When running cpu intense tasks, new (large) tasks will not start till the 
> >first
> >one finishes.
> >For example, using POV-Ray 3.5 to render an image that takes 30 minutes 
> >when it
> >is the only program running, start oowriter.
> >The render finishes in the same 30 minutes, then oowriter starts.
> >oowriter takes about 3 seconds to load if no rendering is going on.
> >I can use apps that are already open but can't start new ones while 
> >rendering.
> >In 2.6.0-test5 (with patch) opening oowriter while rendering takes about 1 
> >minute.
> >In 2.5.65 opening oowriter while rendering takes about 2 minutes (and X 
> >gets
> >very hard to use till oowriter is completely done opening).
> >
> 
> Hi Murray!
> Con Kolivas' patch has been included in test6. You might have tried that
> or maybe my patch?

It was Con Kolivas' patch - I never got to yours since his fixed my -test5
issue.

> Anyway, lets just clarify your report:
> 1 CPU, hyperthreading on or off?

1 CPU, no ht

> test5 interactivity under load isn't as good as test6.

Hard to measure - they're both good from the user's point of view.

> povray takes 150% more time in test6 vs tset5. How many compute threads
> does povray use? Is anything else running?

povray uses 1 process to compute. As far as I can tell it's not threading
at all.
as for other things running - X with fluxbox 0.1.14 is the only constant.
I vary other apps to test but there seems to be no influence unless the
other app is also a cpu/memory hog.

> oowriter takes 3 seconds to load when nothing is running

correct

> oowriter takes 30(or more) minutes to load when povray is runnnig, takes
> 1 minute in test5 plus patch (could you tell us exactly what the patch
> is)

that 1 minute in test5 is *while rendering* the same image I'm rendering in
this test.
with no load in test5 oowriter takes about 3 seconds to load.

oowriter doesn't load at all until the render is finished. 30 minutes was
the image I was working with. tried it with a 1 hour render, and oowriter
didn't start till the render finished.

-- 
Murray J. Root

