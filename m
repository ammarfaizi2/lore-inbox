Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTJBCZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTJBCZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:25:56 -0400
Received: from dp.samba.org ([66.70.73.150]:10458 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263188AbTJBCZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:25:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, braam@clusterfs.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch. 
In-reply-to: Your message of "Wed, 01 Oct 2003 11:46:11 MST."
             <20031001184610.GA25716@hockin.org> 
Date: Thu, 02 Oct 2003 12:25:10 +1000
Message-Id: <20031002022545.7D49D2C14D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031001184610.GA25716@hockin.org> you write:
> Because groups are stored in a 2-D array, the GRP_AT()
> macro was added to allow simple 1-D style indexing.

I respectfully disagree with this approach.  I don't understand why
Linus would think that 4 lines of code to fallback to vmalloc is
"ugly", when doing your own array of pages means you have to change
all the iterators and do magic when copying to and from userspace,
since it's no longer a simple array.

Tim and I have had this discussion, but I would benifit from Linus'
wisdom here.

> Groups are sorted and b-searched for efficiency.

That's where I feel Linus' comment about catering to stupidity comes
in 8)

> This patch modifies /proc/pid/status to only display the first 32 groups.

Ouch, good catch, but this is broken in both our patches 8( I think we
should bump the refcount before reading it to avoid accessing freed
memory.  Now, they have to be root to access that anyway, but it just
makes me uncomfortable.

> This patch removes the NGROUPS define from all architectures as well as
> NGROUPS_MAX.

This will break glibc build (trivial to fix), but I agree: leaving
NGROUPS_MAX is too likely to cause people to use it inside the kernel
like intermezzo does.

> This patch changes the security API to check a struct group_info, rather
> than an array of gid_t.

This is why I prefer the "fall back to vmalloc" approach.

> This patch totally horks Intermezzo.

That's a feature 8)

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
