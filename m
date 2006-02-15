Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWBOSKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWBOSKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWBOSKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:10:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28298 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751193AbWBOSKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:10:48 -0500
Date: Wed, 15 Feb 2006 10:10:17 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Bharata B Rao <bharata@in.ibm.com>
cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <20060215103813.GD2966@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0602151004370.6920@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de>
 <20060209043933.GA2986@in.ibm.com> <200602091058.26811.ak@suse.de>
 <Pine.LNX.4.64.0602141131280.14488@schroedinger.engr.sgi.com>
 <20060215054620.GA2966@in.ibm.com> <20060215103813.GD2966@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Bharata B Rao wrote:

> We don't initialize the free_area list for all zones. Instead,
> free_area_init_core() does that only for zones which are non-empty.

Right.

> But in __rmqueue(), we depend on these free_area lists to be intialized
> correctly for all zones, which is not true in the present case we
> are discussing.

> I think we either need to initialize free_area lists for all zones
> or check for !zone->free_area->nr_free in __rmqueue().

Or we can initialize all pcp to contain empty lists for zones without 
pages.

> Even with this, mbind still needs to be fixed. Even though it
> can't get a conforming zone in the node (MPOL_BIND case), right now,
> it goes ahead with the "bind"ing of the memory area. This causes the
> application to crash (assuming we have fixed the __rmqueue kernel crash)
> (Haven't yet figured our why exactly the application dies)

The application crashes because of an OOM.

