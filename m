Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWIGRYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWIGRYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWIGRYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:24:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5090 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422651AbWIGRYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:24:42 -0400
Date: Thu, 7 Sep 2006 10:24:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060907105801.GC3077@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060907105801.GC3077@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Some more comments

On Thu, 7 Sep 2006, Nick Piggin wrote:

> So what I worry about with this approach is that it can really blow
> out the latency of a balancing operation. Say you have N-1 CPUs with
> lots of stuff locked on their runqueues.

Right but that situation is rare and the performance is certainly
better if the unpinned processes are not all running on the same 
processor.

> The solution I envisage is to do a "rotor" approach. For example
> the last attempted CPU could be stored in the starving CPU's sd...
> and it will subsequently try another one.

That wont work since the notion of "pinned" is relative to a cpu.
A process may be pinned to a group of processors. It will only appear to 
be pinned for cpus outside that set of processors!

What good does storing a processor number do if the processes can change 
dynamically and so may the pinning of processors. We are dealing with
a set of processes. Each of those may be pinned to a set of processors.

> I've been hot and cold on such an implementation for a while: on one
> hand it is a real problem we have; OTOH I was hoping that the domain
> balancing might be better generalised. But I increasingly don't
> think we should let perfect stand in the way of good... ;)

I think we should fix the problem ASAP. Lets do this fix and then we can 
think about other solutions. You already had lots of time to think about
the rotor.

This looks to me as a design flaw that would require either a major rework 
of the scheduler or (my favorite) a delegation of difficult (and 
computational complex and expensive) scheduler decisions to user space.
