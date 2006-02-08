Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbWBHTDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbWBHTDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbWBHTDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:03:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15008 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030520AbWBHTC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:02:59 -0500
Date: Wed, 8 Feb 2006 11:02:45 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208105714.15bb4bb2.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602081058380.3721@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <20060208103323.7ba3709e.pj@sgi.com> <Pine.LNX.4.62.0602081037240.3590@schroedinger.engr.sgi.com>
 <20060208105714.15bb4bb2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Paul Jackson wrote:

> > F.e. a sysadmin may mistakenly start a process allocating too much memory
> > in a cpuset. The OOM killer will then start randomly shooting other 
> > processes one of which may be a critical process.. Ouch.
> 
> That same exact claim could be made to justify a patch that
> removed mm/oom_kill.c entirely.  And the same exact claim
> could be made, dropping the "in a cpuset" phrase, on an UMA
> desktop PC.

Well the justification for the OOM Killer was that it keeps the system 
as a whole alive ..... cpusets are not vital to the system. Usually the 
folks using cpusets are very aware of the memory usage of their processes 
and I think they would hate that a random process be killed.

The obvious case is that someone starts a process that allocates 
large amount of memory while other processes are already running.

> The basic premise of the oom killer is that, instead of blowing
> off the caller, who might innocently have asked for one page
> too many after some other hog used up all the available memory,
> we try to pick the worst offender.
> 
> Get the worst offender, not just who ever finally hit the limit.

Typically the worst offender is who just asked for the page.

> I've yet to be convinced that the oom killer is our friend,
> and half of me (not seriously) is almost wishing it were
> gone.

I definitely agree with you. Lets at least keep it from doing harm as much 
as possible.
 
> Would another option be to continue to fine tune the heuristics
> that the oom killer uses to pick its next victim?
> 
> What situation did you hit that motivated this change?

mbind to one node. Allocate on that node until you trigger the OOM killer.
