Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbULOAQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbULOAQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbULOAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:16:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43422 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261784AbULNX3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:29:47 -0500
Date: Tue, 14 Dec 2004 14:00:28 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brent Casavant <bcasavan@sgi.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <50260000.1103061628@flay>
In-Reply-To: <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com><9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de><19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I originally was a bit worried about the TLB usage, but it doesn't
>> > seem to be a too big issue (hopefully the benchmarks weren't too
>> > micro though)
>> 
>> Well, as long as we stripe on large page boundaries, it should be fine,
>> I'd think. On PPC64, it'll screw the SLB, but ... tough ;-) We can either
>> turn it off, or only do it on things larger than the segment size, and
>> just round-robin the rest, or allocate from node with most free.
> 
> Is there a reasonably easy-to-use existing infrastructure to do this?
> I didn't find anything in my examination of vmalloc itself, so I gave
> up on the idea.

Not that I know of. But (without looking at it), it wouldn't seem 
desperately hard to implement (some argument or flag to vmalloc, or vmalloc_largepage) or something.

> And just to clarify, are you saying you want to see this before inclusion
> in mainline kernels, or that it would be nice to have but not necessary?

I'd say it's a nice to have, rather than necessary, as long as it's not
forced upon people. Maybe a config option that's on by default on ia64
or something. Causing yourself TLB problems is much more acceptable than
causing it for others ;-)

M.

