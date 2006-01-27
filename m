Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWA0BNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWA0BNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWA0BNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:13:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:15518 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932413AbWA0BNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:13:22 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Date: Fri, 27 Jan 2006 02:07:39 +0100
User-Agent: KMail/1.8.2
Cc: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org,
       pj@sgi.com
References: <20060125161321.647368000@localhost.localdomain> <43D96D08.6050200@us.ibm.com> <Pine.LNX.4.62.0601261655120.19293@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601261655120.19293@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270207.40489.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 01:57, Christoph Lameter wrote:
> On Thu, 26 Jan 2006, Matthew Dobson wrote:
> 
> > > We need this for other issues as well. f.e. to establish memory allocation 
> > > policies for the page cache, tmpfs and various other needs. Look at 
> > > mempolicy.h which defines a subset of what we need. Currently there is no 
> > > way to specify a policy when invoking the page allocator or slab 
> > > allocator. The policy is implicily fetched from the current task structure 
> > > which is not optimal.
> > 
> > I agree that the current, task-based policies are subobtimal.  Having to
> > allocate and fill in even a small structure for each allocation is going to
> > be a tough sell, though.  I suppose most allocations could get by with a
> > small handfull of static generic "policy structures"...  This seems like it
> > will turn into a signifcant rework of all the kernel's allocation routines,
> > no small task.  Certainly not something that I'd even start without
> > response from some other major players in the VM area...  Anyone?
> 
> No you would have a set of policies and only pass a pointer to the 
> policies to the allocator. I.e. have one emergency policy allocated 
> somewhere in the IP stack and then pass that to the allocator.

What would that be needed for? 

My goal for mempolicies was always to keep it as simple as possible
and keep the fast paths fast  and there has to be a very good reason to add any 
new complexity.

-Andi
