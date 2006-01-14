Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWANHDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWANHDv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWANHDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:03:51 -0500
Received: from gold.veritas.com ([143.127.12.110]:35622 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751702AbWANHDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:03:50 -0500
Date: Sat, 14 Jan 2006 07:04:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brent Casavant <bcasavan@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Add tmpfs options for memory placement policies (Resend
 with corrected addresses).
In-Reply-To: <20060113152228.W18980@chenjesu.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0601140648490.4260@goblin.wat.veritas.com>
References: <20060113160406.GE19156@lnx-holt.americas.sgi.com>
 <20060113162119.GF19156@lnx-holt.americas.sgi.com> <20060113122349.5c367e05.akpm@osdl.org>
 <20060113152228.W18980@chenjesu.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Jan 2006 07:03:50.0440 (UTC) FILETIME=[AC013280:01C618D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Brent Casavant wrote:
> On Fri, 13 Jan 2006, Andrew Morton wrote:
> 
> > Confused.  Is this for applications which cannot be taught to use the
> > mempolicy API?
> 
> In general yes.  Anything that writes into a tmpfs filesystem is liable
> to disproportionately decrease the available memory on a particular node.
> Since there's no telling what sort of application (e.g. dd/cp/cat) might be
> dropping large files there, this lets the admin choose the appropriate
> default behavior for their site's situation.

I look at it differently, and would answer Andrew's question with "no"
rather than "yes".  The mempolicy API applies only to userspace mappings:
so it covers shared memory fine, but cannot be applied to tmpfs files.
Whereas mount's mpol= applies to tmpfs files, and (unfortunately?) cannot
be applied to shm (since that's on an internal mount with no options).

The only overlap comes when a tmpfs file is mmap'ed: then it's possible
to apply the mempolicy API to it, and refine what mount's mpol= defined.
There's been talk in the past of mempolicy for pagecache, which would
also allow mount's mpol= to be refined per file; but that's not appeared.

Hugh
