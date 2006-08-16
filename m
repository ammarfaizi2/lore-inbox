Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWHPINY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWHPINY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWHPINY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:13:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4804 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750769AbWHPINX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:13:23 -0400
Date: Wed, 16 Aug 2006 18:12:08 +1000
From: David Chinner <dgc@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-ID: <20060816081208.GL51703024@melbourne.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:22:38PM -0700, Christoph Lameter wrote:
> Some of the other issues in the slab layer are also addressed here:
> 
> 1. shrink_slab takes a function to move object. Using that
>    function slabs can be defragmented to ease slab reclaim.
> 
> 2. Bootstrap occurs through dynamic slab creation.
> 
> 3. New slabs that are created can be merged into the kmalloc array
>    if it is detected that they match. This decreases the number of caches
>    and benefits cache use.

While this will be good for reducing fragmentation, one important
thing is needed here for tracking down leaks and slab corruptions -
the ability to split the caches back out into individual slabs.
Maybe a boot parameter would be useful here - that way it is easy to
determine which type of slab object is causing the problems without
needing the end user to run special kernels.

Also, some slab users probably want their own pool of objects that
nobody else can use - mempools are a good example of this - so there
needs to a way of indicating slabs should not be merged into the
kmalloc array.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
