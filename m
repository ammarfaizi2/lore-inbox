Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbUB0UtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUB0UtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:49:15 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48229 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263096AbUB0UtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:49:08 -0500
Date: Fri, 27 Feb 2004 15:49:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: andrea@suse.de, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040227122936.4c1be1fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Andrew Morton wrote:

> But first someone would need to demonstrate that pte_chains+4g/4g are
> for some reason unacceptable for some real-world setup.

Agreed.  The current 2.6 VM is well tuned already so
we should be extremely cautious not to upset it.

> > Same for Arjan's O(1) VM.  For machines in the single and low
> > double digit number of gigabytes of memory either would work
> > similarly well ...
> 
> I had previously found some workloads in which the 2.4 VM collapsed for
> similar reasons and those were fixed with the rotate_reclaimable_page()
> logic.  Without testcases we will not be able to verify that anything else
> needs doing.

Duh, I forgot all about the rotate_reclaimable_page() stuff.
That may well fix all problems 2.6 would have otherwise had
in this area.

I really hope we won't need anything like the O(1) VM stuff
in 2.6, since that would leave me more time to work on other
cool stuff (like resource management ;)).

> > Because of this, we should do some (limited) pre-cleaning
> > of inactive pages. The key word here is "limited" ;)
> 
> Current 2.6 will write out nr_inactive>>DEF_PRIORITY pages,

That may be a bit much on extremely huge systems, but that should
require no more than a little tweaking to fix.  Certainly no code
changes should be needed ...

> will then throttle behind I/O and then will start reclaiming clean pages
> from the tail of the LRU which were moved there at interrupt time.

That may well be much better than either the O(1) VM stuff or the
stuff Andrea proposed...

Forget about me proposing the O(1) VM stuff ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

