Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWAYT7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWAYT7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWAYT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:59:45 -0500
Received: from ns1.siteground.net ([207.218.208.2]:62425 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751178AbWAYT7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:59:44 -0500
Date: Wed, 25 Jan 2006 11:59:46 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>, pravin shelar <pravins@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Message-ID: <20060125195946.GC3573@localhost.localdomain>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <43D50445.1080208@cosmosbay.com> <43D50880.605@cosmosbay.com> <200601251431.16513.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601251431.16513.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 02:31:15PM +0100, Andi Kleen wrote:
> On Monday 23 January 2006 17:46, Eric Dumazet wrote:
> 
> I think the best course of action for this now for 2.6.16 is:
> 
> - mark percpu init data not __init
> (this way it will still reference valid memory, although shared between
> all impossible CPUs)
> - keep the impossible CPUs per cpu data to point to the original reference  
> version (== offset 0)
> 

How about doing the above using a debug config option? So that when the
config option is turned on, all per-cpu area references to not possible 
cpus crash? and leave that option default on on -mm :).  That way we can 
quickly catch all references.  We can probably change the arch independent 
setup_per_cpu_areas also to do allocations for cpu_possible cpus only while 
we are at it?

Kiran
