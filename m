Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJOQlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJOQlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUJOQka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:40:30 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:57566 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268169AbUJOQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:38:32 -0400
Subject: Re: per-process shared information
From: Albert Cahalan <albert@users.sf.net>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <20041015162000.GB17849@dualathlon.random>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
	 <1097846353.2674.13298.camel@cube>
	 <20041015162000.GB17849@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1097857912.2669.13548.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Oct 2004 12:31:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 12:20, Andrea Arcangeli wrote:

> the problem is that when ps xav wants to know the RSS it reads statm,
> so we just cannot hurt ps xav to show the "old shared" information that
> would be extremely slow to collect.

Currently, ps uses /proc/*/stat for that. The /proc/*/statm
file is read to determine TRS and DRS, which are broken now.
That it, unless you count "ps -o OL_m" format.

The top program uses /proc/*/statm for many more fields:

%MEM  Memory usage (RES)
VIRT  Virtual Image (kb)
SWAP  Swapped size (kb)
RES   Resident size (kb)
CODE  Code size (kb)
DATA  Data+Stack size (kb)
SHR   Shared Mem size (kb)
nDRT  Dirty Pages count

> I was only not happy about dropping the old feature completely instead
> of providing it with a different new API. Now I think the solution Hugh
> just proposed with the anon_rss should mimic the old behaviour well
> enough and it's probably the right way to go, it's still not literally
> the same, but I doubt most people from userspace could notice the
> difference, and most important it provides useful information, which is
> the number of _physical_ pages mapped that aren't anonymous memory, this
> is very valuable info and it's basically the same info that people was
> getting from the old "shared". So I like it.

What exactly would be the difference, and when might users see it?


