Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266007AbUEUS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUEUS7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUEUS7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:59:11 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:51849 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266007AbUEUS7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:59:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: brettspamacct@fastclick.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Date: Fri, 21 May 2004 14:58:14 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <40AD52A4.3060607@fastclick.com> <74030000.1085161614@flay> <40AE46F9.60600@fastclick.com>
In-Reply-To: <40AE46F9.60600@fastclick.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405211458.14304.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 21, 2004 2:14 pm, Brett E. wrote:
> So could process 0 run on processor 0, allocating local to processor 0,
> then run on processor 1, allocating local to processor 1, this way
> allocating to both processors?

Yep.

> So over time process 0's allocations 
> would be split up between both processors, defeating NUMA.

Well, I wouldn't put it that way, but it would give your app suboptimal 
performance.

> The homenode 
> concept + explicit CPU pinning seems useful in that they allow you to
> take advantage of NUMA better.

When you say homenode here, do you mean restricted memory allocation?  If so, 
then yes, that would be useful.  And we have it already with libnuma and 
sched_setaffinity.  If you mean some sort of preferred allocation node, then 
no, we don't have that, and it wouldn't be of much benefit I think (relative 
to what we already have).  The idea is to do "pretty good" by default, but 
still allow the user full control if they want to be sure.

> Without these two things the kernel will 
> just allocate on the currently running CPU whatever that may be when in
> fact a preference must be given to a CPU at some point, hopefully early
> on in the life of the process, in order to take advantage of NUMA.

The kernel does a pretty good job of keeping processes on the CPU they've been 
running on, and thus they'll probably stay close to their memory.  But 
without explicit pinning, there's no guarantee.

Jesse
