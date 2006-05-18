Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWERLN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWERLN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWERLNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:13:55 -0400
Received: from gold.veritas.com ([143.127.12.110]:38980 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751336AbWERLNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:13:55 -0400
X-IronPort-AV: i="4.05,140,1146466800"; 
   d="scan'208"; a="59631556:sNHT28705828"
Date: Thu, 18 May 2006 12:13:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, discuss@x86-64.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
 when needed
In-Reply-To: <1147895964.26468.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605181151120.6559@blonde.wat.veritas.com>
References: <1147885316.26468.15.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0605171840310.14529@blonde.wat.veritas.com>
 <1147895964.26468.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 May 2006 11:13:55.0061 (UTC) FILETIME=[26ADAA50:01C67A6C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Eric Paris wrote:
> 
> This patch still solves the problem of the kernel currently being more
> restrictive on what we accept from userspace for the length of the mlock
> if it is a hugepage rather than a regular page.  With a regular page we
> will round the value from userspace and happily go about our business of
> mlocking.  For a hugepage it just rejects it if userspace doesn't align
> it themselves.  This allows the kernel to do the same work for hugepages
> that it does for normal pages.

You do have a point that there's an inconsistency there.  But we could
argue a long time what's inconsistent with what - I'd say it's mlock
being inconsistent with mprotect, munmap, msync, madvise, etc.  I
don't see an outright reason to change from the current behaviour.

You do realize that there's almost no point in mlocking a hugepage area
anyway?  (I wrote that first without the "almost", but now with hugepage
faulting, it does provide another way to fault in all the pages at once.)

Hugh
