Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWFVU0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWFVU0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWFVU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:26:14 -0400
Received: from silver.veritas.com ([143.127.12.111]:54800 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1161324AbWFVU0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:26:12 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="39478665:sNHT1187321172"
Date: Thu, 22 Jun 2006 21:25:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Pavel Machek <pavel@suse.cz>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <449AF61C.9040807@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0606222117530.26444@blonde.wat.veritas.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
 <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
 <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz>
 <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com>
 <449AEF29.9070300@yahoo.com.au> <Pine.LNX.4.64.0606222030290.23611@blonde.wat.veritas.com>
 <449AF61C.9040807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 20:26:10.0786 (UTC) FILETIME=[19914C20:01C6963A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006, Nick Piggin wrote:
> > >Hugh Dickins wrote:
> > >
> > > >I'd expect tasks bound to the unplugged cpu simply not to be run
> > > >until "that" cpu is plugged back in.
> > 
> > I wasn't meaning "kill -9" for the swsusp case, but for the general
> > unplug cpu case.  We have a number of homeless tasks, which the admin
> > might want to run again when "the" cpu is plugged back in; or might
> > want to kill off without having to plug a cpu back in.
> 
> Possible maybe... I presumed that would lead to a nightmare of
> resource deadlocks (think mutexes).

Yes, that's what I've naively overlooked - thanks.

But _maybe_ there's still a case for allowing such tasks to run
_in_kernel_ on a wrong cpu, to release resources, and to be killed.

Hugh
