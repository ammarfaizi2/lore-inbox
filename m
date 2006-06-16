Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWFPKJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWFPKJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWFPKJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:09:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:16036 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751182AbWFPKJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:09:30 -0400
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 12:09:25 +0200
User-Agent: KMail/1.9.3
Cc: "Tony Luck" <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606160822.23898.ak@suse.de> <yq0ejxp2zzg.fsf@jaguar.mkp.net>
In-Reply-To: <yq0ejxp2zzg.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161209.25266.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It all depends on your application and the type of system you are
> running on. What you say applies to smaller cpu counts. However once
> we see the upcoming larger count multi-core cpus become commonly
> available, this is likely to change and become more like what is seen
> today on larger NUMA systems.

Maybe. Maybe not. 

> 
> In the scientific application space, there are two very common
> groupings of jobs.

The scientific users just use pinned CPUs and seem to be happy with that.
They also have cheap slav^wgrade students to spend lots of time on
manual tuning.  I'm not concerned about them. 

If you already use CPU affinity you should already know where you are and don't 
need this call at all.

So this clearly isn't targetted for them. 

Interesting is getting the best performance from general purpose applications 
without any special tuning. For them I'm trying to improve things.

Number one applications currently are databases and JVMs. I hope with 
Wolfam's malloc work it will be useful for more applications too. 

> Andi> So by default filling the CPUs must be the highest priority and
> Andi> memory policy cannot interfere with that.
> 
> I really don't think this approach is going to solve the problem. As
> Tony also points out, tasks will eventually migrate.

Currently we don't solve this problem with the standard heuristics.
It can be solved with manual tuning (mempolicy, explicit CPU affinity)
but if you're doing that you're already out side the primary use 
case of vgetcpu().

vgetcpu() is only trying to be a incremental improvement of the current
simple default local policy.

> The user needs to 

Scientific users do that, but other users normally not. I doubt that
is going to change.

-Andi
