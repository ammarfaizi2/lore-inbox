Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271056AbUJVKhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271056AbUJVKhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271058AbUJVKhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:37:14 -0400
Received: from holomorphy.com ([207.189.100.168]:44993 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271056AbUJVKhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:37:13 -0400
Date: Fri, 22 Oct 2004 03:37:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [2/4]: set_huge_pte() arch updates
Message-ID: <20041022103708.GK17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410212156300.3524@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:57:23PM -0700, Christoph Lameter wrote:
> Changelog
> 	* Update set_huge_pte throughout all arches
> 	* set_huge_pte has an additional address argument
> 	* set_huge_pte must also do what update_mmu_cache typically does
> 	  for PAGESIZE ptes.
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

What's described above is not what the patch implements. The patch is
calling update_mmu_cache() in a loop on all the virtual base pages of a
virtual hugepage, which won't help at all, as it doesn't understand how
to find the hugepages regardless of virtual address. AFAICT code to
actually do the equivalent of update_mmu_cache() on hugepages most
likely involves privileged instructions and perhaps digging around some
cpu-specific data structures (e.g. the natively architected pagetables
bearing no resemblance to Linux') for almost every non-x86 architecture.


-- wli
