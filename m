Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWFVSy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWFVSy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWFVSy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:54:28 -0400
Received: from gold.veritas.com ([143.127.12.110]:36472 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161191AbWFVSy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:54:26 -0400
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="60872680:sNHT32517340"
Date: Thu, 22 Jun 2006 19:54:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Pavel Machek <pavel@suse.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <20060622182231.GC4193@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
 <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
 <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 18:54:25.0928 (UTC) FILETIME=[486AA080:01C6962D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pavel Machek wrote:
> 
> > > Hm..
> > > Then, there is several ways to manage this sitation.
> > > 
> > > 1. migrate all even if it's not allowed by users
> 
> That's what I'd prefer... as swsusp uses cpu hotplug. All the other
> options are bad... admin will probably not realize suspend involves
> cpu unplugs..
> 
> > > 2. kill mis-configured tasks.
> > > 3. stop ...
> > > 4. cancel cpu-hot-removal.

I'm very reluctant to expose my ignorance by joining this thread;
but what I'd naively expect would, I think, suit swsusp also -
you don't really want tasks to be migrated when resuming?

I'd expect tasks bound to the unplugged cpu simply not to be run
until "that" cpu is plugged back in.

With proviso that it should be possible to "kill -9" such a task
i.e. it be allowed to run in kernel on a wrong cpu just to exit.

Presumably this is difficult, because unplugging a cpu will also
remove infrastructure which would, for example, allow "ps" to show
such tasks.  Perhaps such infrastructure should remain so long as
there are tasks there.

Ignore me if I'm talking nonsense.

Hugh
