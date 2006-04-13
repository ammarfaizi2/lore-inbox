Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWDMTBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWDMTBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWDMTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:01:21 -0400
Received: from ns1.siteground.net ([207.218.208.2]:61130 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932390AbWDMTBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:01:20 -0400
Date: Thu, 13 Apr 2006 12:02:14 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3 unsigned long type free blocks counter
Message-ID: <20060413190214.GA4172@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com> <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com> <20060411222012.GA5007@localhost.localdomain> <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144877315.3722.26.camel@dyn9047017067.beaverton.ibm.com>
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

On Wed, Apr 12, 2006 at 02:28:35PM -0700, Mingming Cao wrote:
> On Tue, 2006-04-11 at 15:20 -0700, Ravikiran G Thirumalai wrote:
> > On Tue, Apr 11, 2006 at 12:01:13PM -0700, Mingming Cao wrote:
> > > On Tue, 2006-04-11 at 10:09 -0700, Christoph Lameter wrote:
> 
> 
> where the check for unsigned long overflow is only turned on 32 bit
> platforms.
> 
> > Or make the counter s64? so that it stays 64 bit on all arches? 
> > 
> 
> Well, don't we have the problem : 64 bit counter add/dec/update is not
> always atomic on all 32 bit platforms? There are risk that we will get
> bogus global value. 

Yes, but the global counter is modified with a lock in the SMP case, and the
local counters are modified by their respective cpus only,  Although there 
might be more subtle issues ..... 

> 
> > OR
> > why not change the global per-cpu counter type to unsigned long (as we
> > discussed earlier), so we don't need the extra "ul" flags and interfaces, 
> > and all arches get a standard unsigned long return type? 
> >  We could also 
> > do away with percpu_read_positive then no?  The applications for per-cpu 
> > counters is going to be upcounters always methinks...
> > 
> 
> yeah...I am not so happy with the extra "ul" checking flags either. But
> as you have mentioned before, the signed global counter type is there
> for some cases when the global counter becomes temporally negative
> ( although the counter in real life should always positive). What should
> we do if the global counter is a unsigned value, was initialized to 0,
> and now we add -5 to it(-5 is from one local counter, then we will get a
> bogus big value)?

I thought the solution to this was to have a global unsigned counter, and
signed local counter, and defer updates to the global if it is going to be a 
large value due to the case above. This way the global counter remains an up 
counter no?

Thanks,
Kiran
