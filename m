Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWHDF7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWHDF7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWHDF7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:59:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24224 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161055AbWHDF7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:59:01 -0400
Date: Thu, 3 Aug 2006 22:58:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803225842.cdc457b1.pj@sgi.com>
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> And now we've dumped the good infrastructure and instead we've contentrated
> on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> layer.

Odd ... I'm usually fairly keen to notice any use or abuse of cpuset stuff.

I didn't see any mention of 'cpuset' in:
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0607.3/0896.html

I -do- see there:
 * non-hierarchical,
 * can't move tasks and
 * syscall rather than file system API.

This all sounds like the polar antithesis of cpusets to me.

What did I miss, Andrew?


Before seeing your response, I was inclined to suggest that:
 1) containers should have a good infrastructure, from the get go
    (you just said the same thing of CKRM, as I read it), and
 2) containers -should- look at a hierarchical pseudo file system
    for this, as that seems like the 'natural' shape for
    containers to take.
 3) the syscall API, no hierarchy, 'simple' interface style
    suggested for containers in the above notes sounded like
    a really bad idea to me.

However, I was thinking of 'containers' when I thought this,
not of CKRM.  And I haven't considered CKRM's infrastructure
in recent times.  From what you say, it's worthy of serious
consideration now - good.

Perhaps (wild idea here) if 'containers' did lead us to looking
for a hierarchical pseudo file system interface, we could make
this common technology that both containers and the existing
cpusets could use, avoiding duplicating a chunk of vfs-aware
generic code that's now in kernel/cpuset.c to provide the file
system style interface.  Cpusets would keep their existing API,
just share some generic vfs-aware code with these new containers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
