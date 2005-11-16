Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVKPT63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVKPT63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVKPT63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:58:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18333 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030444AbVKPT62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:58:28 -0500
Date: Wed, 16 Nov 2005 11:58:13 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Robin Holt <holt@sgi.com>
cc: Mel Gorman <mel@csn.ul.ie>, Russ Anderson <rja@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to handle a hugepage with bad physical memory?
In-Reply-To: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.62.0511161155380.16434@schroedinger.engr.sgi.com>
References: <20051116131012.GE4573@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Robin Holt wrote:

> Russ Anderson recently introduced a patch into ia64 that changes MCA
> behavior.  When the MCA is caused by a user reference to a users memory,
> we put an extra reference on the page and kill the user.  This leaves
> the working memory available for other jobs while causing a leak of the
> bad page.
> 
> I don't know if Russ has done any testing with hugetlbfs pages.  I preface
> the remainder of my comments with a huge "I don't know anything"
> disclaimer.
> 
> With the new hugepages concept, would it be possible to only mark
> the default pagesize portion of a hugepage as bad and then return the
> remainder of the hugepage for normal use?  What would we basically need
> to do to accomplish this?  Are there patches in the community which we
> should wait to see how they progress before we do any work on this front?

On IA64 we have one PTE for a huge page in a different region, so we 
cannot unmap a page sized section. Other architectures may have PTEs for 
each page sized section of a huge page. For those it may make sense 
(but then the management of the page is done via the first page_struct, 
which likely results in some challenging VM issues).


