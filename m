Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTKZF2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 00:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKZF2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 00:28:14 -0500
Received: from waste.org ([209.173.204.2]:915 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262123AbTKZF2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 00:28:11 -0500
Date: Tue, 25 Nov 2003 23:27:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, steiner@sgi.com, jes@trained-monkey.org,
       viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-ID: <20031126052750.GW22139@waste.org>
References: <16323.23221.835676.999857@gargle.gargle.HOWL> <20031125204814.GA19397@sgi.com> <20031125130741.108bf57c.akpm@osdl.org> <20031125211424.GA32636@sgi.com> <20031125132439.3c3254ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125132439.3c3254ff.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 01:24:39PM -0800, Andrew Morton wrote:
> jbarnes@sgi.com (Jesse Barnes) wrote:
> >
> > On Tue, Nov 25, 2003 at 01:07:41PM -0800, Andrew Morton wrote:
> > > the size of these tables dependent upon the number of dentries/inodes/etc
> > > which the system is likely to support.  And that does depend upon the
> > > amount of direct-addressible memory.
> > > 
> > > 
> > > So hum.  As a starting point, what happens if we do:
> > > 
> > > -	vfs_caches_init(num_physpages);
> > > +	vfs_caches_init(min(num_physpages, pages_in_ZONE_NORMAL));
> > > 
> > > ?
> > 
> > Something like that might be ok, but on our system, all memory is in
> > ZONE_DMA...
> > 
> 
> Well yes, we'd want
> 
> 	vfs_caches_init(min(num_physpages, some_platform_limit()));
> 
> which on ia32 would evaluate to nr_free_buffer_pages() and on ia64 would
> evaluate to the size of one of those zones.

I actually just added this to the tree I'm working on:

+       vfs_caches_init(min(1000, num_physpages-16000));

Caches are too expensive on the low end of the scale as well, when the
kernel is taking up most of RAM.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
