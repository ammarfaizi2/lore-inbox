Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVIOJkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVIOJkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIOJkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:40:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65416 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932387AbVIOJkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:40:06 -0400
Date: Thu, 15 Sep 2005 15:09:45 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050915093945.GD3869@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914230843.GA11748@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 08:08:43PM -0300, Marcelo Tosatti wrote:
> On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > 
<snip>
> > First is dentry_stats patch which collects some dcache statistics
> > and puts it into /proc/meminfo. This patch provides information 
> > about how dentries are distributed in dcache slab pages, how many
> > free and in use dentries are present in dentry_unused lru list and
> > how prune_dcache() performs with respect to freeing the requested
> > number of dentries.
> 
> Bharata, 
> 
> Ideally one should move the "nr_requested/nr_freed" counters from your
> stats patch into "struct shrinker" (or somewhere else more appropriate
> in which per-shrinkable-cache stats are maintained), and use the
> "mod_page_state" infrastructure to do lockless per-CPU accounting. ie.
> break /proc/vmstats's "slabs_scanned" apart in meaningful pieces.

Yes, I agree that we should have the nr_requested and nr_freed type of
counters in appropriate place. And "struct shrinker" is probably right
place for it.

Essentially you are suggesting that we maintain per cpu statistics
of 'requested to free'(scanned) slab objects and actual freed objects.
And this should be on per shrinkable cache basis.

Is it ok to maintain this requested/freed counters as growing counters
or would it make more sense to have them reflect the statistics from
the latest/last attempt of cache shrink ? And where would be right
place to export this information ? (/proc/slabinfo ?,  since it already
gives details of all caches)

If I understand correctly, "slabs_scanned" is the sum total number
of objects from all shrinkable caches scanned for possible freeeing.
I didn't get why this is part of page_state which mostly includes
page related statistics.

Regards,
Bharata.
