Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWCIAR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWCIAR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCIARZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:17:25 -0500
Received: from ns1.siteground.net ([207.218.208.2]:11731 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932308AbWCIARZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:17:25 -0500
Date: Wed, 8 Mar 2006 16:18:03 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, netdev@vger.kernel.org, shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060309001803.GF4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org> <20060308202656.GA4493@localhost.localdomain> <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain> <20060308224140.GC5410@kvack.org> <20060308154321.0e779111.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308154321.0e779111.akpm@osdl.org>
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

On Wed, Mar 08, 2006 at 03:43:21PM -0800, Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > I think it may make more sense to simply convert local_t into a long, given 
> > that most of the users will be things like stats counters.
> > 
> 
> Yes, I agree that making local_t signed would be better.  It's consistent
> with atomic_t, atomic64_t and atomic_long_t and it's a bit more flexible.
> 
> Perhaps.  A lot of applications would just be upcounters for statistics,
> where unsigned is desired.  But I think the consistency argument wins out.

It already is... for most of the arches except x86_64.
And on -mm, the asm-generic version uses atomic_long_t for local_t (signed
long) which seems right.

Although, I wonder why we use:

#define local_read(l) ((unsigned long)atomic_long_read(&(l)->a))

It would return a huge value if the local counter was even -1 no?

