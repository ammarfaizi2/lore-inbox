Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVJGDEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVJGDEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 23:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVJGDEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 23:04:11 -0400
Received: from silver.veritas.com ([143.127.12.111]:53422 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751288AbVJGDEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 23:04:09 -0400
Date: Fri, 7 Oct 2005 04:03:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: David Wright <daw@sgi.com>, Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4345D8DB.7070901@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0510070354590.16857@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <4339AED4.8030108@engr.sgi.com> <Pine.LNX.4.61.0509281337420.6830@goblin.wat.veritas.com>
 <433AD359.8070509@engr.sgi.com> <Pine.LNX.4.61.0510032030320.13179@goblin.wat.veritas.com>
 <4342F8BA.8050002@engr.sgi.com> <4345D8DB.7070901@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Oct 2005 03:04:05.0570 (UTC) FILETIME=[C70EFA20:01C5CAEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Jay Lan wrote:
> Jay Lan wrote:
> > Hugh Dickins wrote:
> > > 
> > > See comment in fs/proc/task_mmu.c for the principle.  Could maintain
> > > hiwater_vm straightforwardly, but I think it's easier to remember if
> > > we handle them both in the same way.
> > 
> > I am building a kernel with your patch and am going to run some test
> > to compare the statistics.
> 
> My testing showed the same number on hiwater_vm, but hiwater_rss from
> Hugh's version was consistently ~1.5% lower. Where was the loss?

Thanks for trying it out.  Please check if you adjusted the way in which
you collect hiwater_rss: as in the example in task_mmu.c, it's no longer
any good just reading hiwater_rss, you need the max of get_mm_rss and
hiwater_rss each time.  Similarly for hiwater_vm.

Hugh
