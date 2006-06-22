Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWFVTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWFVTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWFVTrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:47:08 -0400
Received: from silver.veritas.com ([143.127.12.111]:50078 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1161224AbWFVTrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:47:05 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="39477421:sNHT22426268"
Date: Thu, 22 Jun 2006 20:46:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Pavel Machek <pavel@suse.cz>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <449AEF29.9070300@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0606222030290.23611@blonde.wat.veritas.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
 <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
 <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz>
 <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com>
 <449AEF29.9070300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 19:47:04.0924 (UTC) FILETIME=[A35329C0:01C69634]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Nick Piggin wrote:
> Hugh Dickins wrote:
> > 
> > I'd expect tasks bound to the unplugged cpu simply not to be run
> > until "that" cpu is plugged back in.
> 
> Yes, I don't see why swsusp tasks would need to be migrated and
> run. OTOH, this would require more swsusp special casing, but
> apparently that's encouraged ;)

No, I wasn't meaning any swsusp special casing at all.

I was just using Pavel's swsusp-related mail as the hook to raise
the point that had been haunting me with every earlier mail on
this subject, mails I'd already deleted.

Pavel seemed to imply overriding the requested affinity for tasks
(in preferring #1 migration), I doubted he really wanted that.

> > With proviso that it should be possible to "kill -9" such a task
> > i.e. it be allowed to run in kernel on a wrong cpu just to exit.
> > 
> > Presumably this is difficult, because unplugging a cpu will also
> > remove infrastructure which would, for example, allow "ps" to show
> > such tasks.  Perhaps such infrastructure should remain so long as
> > there are tasks there.
> 
> They'll be in the global tasklist, so there should be no reason why
> they couldn't be migrated over to an online CPU with taskset. Shouldn't
> require any rewrites, IIRC.

I was afraid that "for_each_online_cpu"-type scans would skip over
the unplugged cpus, in such a way that the homeless tasks might be
awkwardly invisible in some contexts.  If no such problem, fine.

> But after swsusp comes back up, it will be bringing up the same number
> of CPUs as went down, won't it? So you shouldn't get into that
> situation where you'd need to kill stuff, should you?

I wasn't meaning "kill -9" for the swsusp case, but for the general
unplug cpu case.  We have a number of homeless tasks, which the admin
might want to run again when "the" cpu is plugged back in; or might
want to kill off without having to plug a cpu back in.

Hugh
