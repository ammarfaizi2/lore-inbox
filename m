Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWBWCHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWBWCHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWBWCHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:07:48 -0500
Received: from ns1.siteground.net ([207.218.208.2]:22204 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750814AbWBWCHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:07:47 -0500
Date: Wed, 22 Feb 2006 18:08:18 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, shai@scalex86.org,
       Nippun Goel <nippun.goel@calsoftinc.com>
Subject: Re: [patch] Cache align futex hash buckets
Message-ID: <20060223020818.GD3663@localhost.localdomain>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au> <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com> <43FBB2E8.2020300@yahoo.com.au> <20060221180845.79a44449.akpm@osdl.org> <43FBCE56.9020001@yahoo.com.au> <20060222201713.GA3663@localhost.localdomain> <20060222125049.6386c9e1.akpm@osdl.org> <20060223015144.GC3663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223015144.GC3663@localhost.localdomain>
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

On Wed, Feb 22, 2006 at 05:51:44PM -0800, Ravikiran G Thirumalai wrote:
> On Wed, Feb 22, 2006 at 12:50:49PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > We also collected hash collision statistics for 1024 slots.  We found that
> > >  50% of the slots did not take any hit!!  So maybe we should revisit the
> > >  hashing function before settling on the optimal number of hash slots. 
> > 
> > You could try switching from jhash2() to hash_long().
> 
> OK, I will try that.
> 
> > 
> > Was there any particular pattern to the unused slots?  Not something silly
> > like every second one?
> 
> The distribution seems OK with 256 buckets, but with 1024 buckets, it goes
> bad.  We see high hits every 4-6 buckets.  Attaching the distribution

This pattern might not be bad as it avoids bouncing of spinlocks on the adjacent
hash buckets...but then there are high hits on adjacent buckets too.

(instrumentation done by Nippun)

Thanks,
Kiran
