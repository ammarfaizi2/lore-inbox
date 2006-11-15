Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966619AbWKOBqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966619AbWKOBqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966620AbWKOBqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:46:36 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:8654 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S966619AbWKOBqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:46:35 -0500
Date: Wed, 15 Nov 2006 02:46:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Marty Leisner <leisner@rochester.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC  -- /proc/patches to track development 
In-Reply-To: <200611150117.kAF1H3CD012244@dell2.home>
Message-ID: <Pine.LNX.4.61.0611150238570.1046@yvahk01.tjqt.qr>
References: <200611150117.kAF1H3CD012244@dell2.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Marty Leisner <leisner@rochester.rr.com>
>Subject: RFC  -- /proc/patches to track development 
                  ^^^^^

Wrong place. Really. (And I do not think /sys is a better one either. 
But let others speak up.)

>I always want to know WHAT I'm running (or people I'm working with

`uname -a`?

>are running) rather than  "guessing" ("do you have the most current 
>patch" "I think so")
>
>I've been a proponent of capturing .config information SOMEPLACE where
>you can look at it at runtime...(it took a while but its there now).

/proc/config,gz?

>In /proc/patches there would be a series of comments (perhaps including
>file, date and time) of various patches you want to monitor.  

Wastes nonswappable memory.

>It would be enabled by something like
>
>in file foo.c:
>PATCH_COMMENT("this enables the foo feature");
>
>
>In membar.c:
>PATCH_COMMENT("go to the bar on saturday");
>...
>PATCH_COMMENT("watch how much you drink");
>
>
>and in /proc/patches:
>
>foo.c: compiled <date> <time>:this enables the foo feature
>membar.c: compiled <date> <time>:go to the bar on saturday
>member.c: compiled <date> <time>:watch how much you drink
>
>There would be a Kconfig flag whether or not to enable this (i.e.
>production kernels would not need it,
>hacked kernels would, it could always be there if you're willing to
>increase the footprint).

Reasonable. However, I would prefer that PATCH_COMMENT() evaluates to a 
string that is included in the module only (think MODULE_DESCRIPTION) 
and is not loaded during modprobe. Instead, modinfo your 
/lib/modules/`uname -r` tree and grep for your PATCH_COMMENT lines. Hey, 
that's even in userspace - no memory wasted.

>Instead of looking for aberrant behavior to identify patches, you could easily
>see things with cat.

Can you define patch? IMO, if you run a normal, mm, or git kernel, you 
usually find -mm or -git in the `uname -r` output. Of course there is 
also some development going on between -gitA and -gitB, but most people 
seem to keep together what they have patched.

>Seems very easy and has high ROI if you need to track patched kernels locally.

Patched by whom? (Tier-1 kernel developers (mainline, mm and those who 
run a tree on git.kernel.org), or Tier-2+ (Distro vendors))



	-`J'
-- 
