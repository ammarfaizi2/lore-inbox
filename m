Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUCCTCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUCCTCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:02:25 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:7883 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262546AbUCCTCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:02:08 -0500
Date: Wed, 03 Mar 2004 13:01:21 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <14830000.1078340481@[10.1.1.4]>
In-Reply-To: <20040303185122.GV4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random>
 <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]>
 <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]>
 <20040303183901.GU4922@dualathlon.random> <14140000.1078339447@[10.1.1.4]>
 <20040303185122.GV4922@dualathlon.random>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, March 03, 2004 19:51:22 +0100 Andrea Arcangeli
<andrea@suse.de> wrote:

> ok, you used PG_locked that already exists for another purpose so it was
> not clear, another bitflag would be ok.

I forgot PG_locked already existed :)

> the main remaining issue to solve (and run at runtime) is the logic is
> to keep this flag consistent with all vmas pointing to the page having
> VM_LOCKED set. I'm not sure if it's worth it.

That's been the main stumbling block to anyone actually trying it.  It
involves per-page housekeeping at every mlock() and every time a locked vma
gets unmapped.

> what we do in 2.4 and that works pretty well, that is simply to refile
> pages into the active list if they're mlocked, so we don't waste too
> much cpu on them since we don't analyze them too often. this should work
> pretty well for everybody, or peraphs google may prefer to have a fully
> consistent PG_mlocked.

The point would be to have a way of finding and skipping the locked page
before we go look up the vmas for it.  2.4 doesn't have that problem
because it's working from the vma.

Dave McCracken

