Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTLKB2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTLKB2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:28:48 -0500
Received: from holomorphy.com ([199.26.172.102]:1764 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264315AbTLKB2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:28:47 -0500
Date: Wed, 10 Dec 2003 17:28:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031211012817.GQ14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, rl@hellgate.ch,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random> <20031210220525.GA28912@k3.hellgate.ch> <20031210224445.GE11193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210224445.GE11193@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:05:25PM +0100, Roger Luethi wrote:
>> Also, the 2.6 core VM doesn't seem all that bad since it was introduced in
>> 2.5.27 but most of the problems I measured were introduced after 2.5.40.
>> Check out the graph I posted.

On Wed, Dec 10, 2003 at 11:44:46PM +0100, Andrea Arcangeli wrote:
> you're confusing rmap with core vm. rmap in no way can be defined as the
> core vm, rmap is just a method used by the core vm to find some
> information more efficiently at the expenses of all the fast paths
> that now have to do the rmap bookkeeping.

I've been maintaining one of the answers to this (anobjrmap, originally
from hugh). I still haven't removed page->mapcount because keeping
nr_mapped straight requires some care, though doing so should be feasible.

I could probably use some helpers to untangle it from the highpmd,
compile-time mapping->page_lock rwlock/spinlock switching, RCU
mapping->i_shared_lock, and O(1) proc_pid_statm() bits.


-- wli
