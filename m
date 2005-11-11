Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKKP03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKKP03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKKP03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:26:29 -0500
Received: from silver.veritas.com ([143.127.12.111]:24366 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750809AbVKKP02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:26:28 -0500
Date: Fri, 11 Nov 2005 15:25:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@engr.sgi.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
In-Reply-To: <20051110135336.24d04b86.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511111502560.16832@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
 <20051109181641.4b627eee.akpm@osdl.org> <Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
 <20051109190135.45e59298.akpm@osdl.org> <Pine.LNX.4.62.0511101342340.16283@schroedinger.engr.sgi.com>
 <20051110135336.24d04b86.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Nov 2005 15:26:28.0446 (UTC) FILETIME=[4923B7E0:01C5E6D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Andrew Morton wrote:
> Christoph Lameter <clameter@engr.sgi.com> wrote:
> > 
> > Frequent increments and decrements on the zero page count can cause a 
> > bouncing cacheline that may limit performance.
> 
> I think Hugh did some instrumentation on that and decided that problems
> were unlikely?

"Instrumentation" is rather too dignified a word for the counting I added
at one point, to see what proportion of faults were using the zero page,
before running some poor variety of workloads.

It came out, rather as I expected, as not so many as to cause immediate
concern, not so few that the issue could definitely be dismissed.  So I
persuaded Nick to separate out the zero page refcounting as a separate
patch, and when it came to submission he was happy enough with his patch
without it, that he didn't feel much like adding it at that stage.

I did try the two SGI tests I'd seen (memscale and pft, I think latter
my abbreviation for something with longer name that Christoph pointed
us to, page-fault-tsomething), and they both showed negligible use of
the zero page (i.e. the program startup did a few such faults, nothing
to compare with all the work that the actual testing then did).

I've nothing against zero page refcounting avoidance, just wanted
numbers to show it's more worth doing than not doing.  And I'm not
the only one to have wondered, if it is an issue, wouldn't big NUMA
benefit more from per-node zero pages anyway?  (Though of course
the pages themselves should stay clean, so won't be bouncing.)

Hugh
