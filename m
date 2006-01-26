Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWAZAfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWAZAfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWAZAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:35:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:28641 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751275AbWAZAfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:35:30 -0500
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Date: Thu, 26 Jan 2006 01:32:11 +0100
User-Agent: KMail/1.8.2
Cc: Eric Dumazet <dada1@cosmosbay.com>, pravin shelar <pravins@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <200601251431.16513.ak@suse.de> <20060125195946.GC3573@localhost.localdomain>
In-Reply-To: <20060125195946.GC3573@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601260132.12611.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 20:59, Ravikiran G Thirumalai wrote:
> On Wed, Jan 25, 2006 at 02:31:15PM +0100, Andi Kleen wrote:
> > On Monday 23 January 2006 17:46, Eric Dumazet wrote:
> > 
> > I think the best course of action for this now for 2.6.16 is:
> > 
> > - mark percpu init data not __init
> > (this way it will still reference valid memory, although shared between
> > all impossible CPUs)
> > - keep the impossible CPUs per cpu data to point to the original reference  
> > version (== offset 0)
> > 
> 
> How about doing the above using a debug config option? So that when the
> config option is turned on, all per-cpu area references to not possible 
> cpus crash? and leave that option default on on -mm :)

In -mm* we could just apply Eric's patch and then someone should just
grep the tree for NR_CPUS and audit all users - that should
catch basically all occurrences. I can put it onto my todo list,
but I don't know when I'll get to it so it would be nice if someone
else could do this.

For 2.6.16 I think it's best to go forward with my hack.

> .  That way we can  
> quickly catch all references.  We can probably change the arch independent 
> setup_per_cpu_areas also to do allocations for cpu_possible cpus only while 
> we are at it?

Eric did that already.

-Andi

