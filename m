Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271387AbUJVPfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271387AbUJVPfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271364AbUJVPe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:34:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14504 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271372AbUJVPdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:33:04 -0400
Date: Fri, 22 Oct 2004 08:32:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
In-Reply-To: <20041022103708.GK17038@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0410220829200.7868@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
 <20041022103708.GK17038@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, William Lee Irwin III wrote:

> On Thu, Oct 21, 2004 at 09:57:23PM -0700, Christoph Lameter wrote:
> > Changelog
> > 	* Update set_huge_pte throughout all arches
> > 	* set_huge_pte has an additional address argument
> > 	* set_huge_pte must also do what update_mmu_cache typically does
> > 	  for PAGESIZE ptes.
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
>
> What's described above is not what the patch implements. The patch is
> calling update_mmu_cache() in a loop on all the virtual base pages of a
> virtual hugepage, which won't help at all, as it doesn't understand how
> to find the hugepages regardless of virtual address. AFAICT code to
> actually do the equivalent of update_mmu_cache() on hugepages most
> likely involves privileged instructions and perhaps digging around some
> cpu-specific data structures (e.g. the natively architected pagetables
> bearing no resemblance to Linux') for almost every non-x86 architecture.

The looping is architecture specific. But you are right for the
architectures where I simply did the loop that is wrong. The address given
needs to be correctly calculated which it is not.

Again this is arch specific stuff and can be done as needed for any
architecture. There is no intend to generalize this.

