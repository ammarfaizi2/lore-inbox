Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCCQzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCCQzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCCQzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:55:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34760 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262031AbVCCQzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:55:24 -0500
Date: Thu, 3 Mar 2005 08:54:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Drop first acquisition of ptl
In-Reply-To: <20050302222008.4910eb7b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503030852490.8941@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0503011951100.25441@schroedinger.engr.sgi.com>
 <20050302174507.7991af94.akpm@osdl.org> <Pine.LNX.4.58.0503021803510.3080@schroedinger.engr.sgi.com>
 <20050302185508.4cd2f618.akpm@osdl.org> <Pine.LNX.4.58.0503021856380.3365@schroedinger.engr.sgi.com>
 <20050302201425.2b994195.akpm@osdl.org> <Pine.LNX.4.58.0503022021150.3816@schroedinger.engr.sgi.com>
 <20050302205612.451d220b.akpm@osdl.org> <Pine.LNX.4.58.0503022206001.4389@schroedinger.engr.sgi.com>
 <20050302222008.4910eb7b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Andrew Morton wrote:

> >  This is not relevant since it only deals with file pages.
>
> OK.   And CONFIG_DEBUG_PAGEALLOC?

Its a debug feature that can be fixed if its broken.

> > ptes are only
> >  installed atomically for anonymous memory (if CONFIG_ATOMIC_OPS
> >  is defined).
>
> It's a shame.  A *nice* solution to this problem would address all pte ops
> and wouldn't have such special cases...

Yeah. See my mmu abstraction proposal. This is a solution until we can
address the bigger issues. After that has been worked out the
start/stop become begin/end transaction and the pte_cmpxchg are converted
into  mmu_add/mmu_change/mmu_commit
