Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUEUTIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUEUTIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 15:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUEUTIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 15:08:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16296 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264788AbUEUTIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 15:08:43 -0400
Date: Fri, 21 May 2004 12:08:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, brettspamacct@fastclick.com
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <86690000.1085166496@flay>
In-Reply-To: <200405211458.14304.jbarnes@engr.sgi.com>
References: <40AD52A4.3060607@fastclick.com> <74030000.1085161614@flay> <40AE46F9.60600@fastclick.com> <200405211458.14304.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Without these two things the kernel will 
>> just allocate on the currently running CPU whatever that may be when in
>> fact a preference must be given to a CPU at some point, hopefully early
>> on in the life of the process, in order to take advantage of NUMA.
> 
> The kernel does a pretty good job of keeping processes on the CPU they've been 
> running on, and thus they'll probably stay close to their memory.  But 
> without explicit pinning, there's no guarantee.

One thing I *do* want to do, is instead of explicit homenodes, is to take
into account the per-node RSS of processes when doing my migration decisions.
That gives us a kind of dynamic homenode. I have the per-node RSS code in
my tree already from someone (Matt?), but we haven't used it.  Of course,
this throws off the O(1)-ness of balancing decisions, but as long as we
cap the number we look at, and only do it for cross-node rebalance migrates
(we don't need it for exec), I really don't care ;-)

M.

