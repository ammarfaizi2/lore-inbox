Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSLHTtK>; Sun, 8 Dec 2002 14:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSLHTtK>; Sun, 8 Dec 2002 14:49:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:19693 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261530AbSLHTtJ>;
	Sun, 8 Dec 2002 14:49:09 -0500
Message-ID: <3DF3A3FA.D1571CCD@digeo.com>
Date: Sun, 08 Dec 2002 11:56:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <3DEBB4BD.F64B6ADC@digeo.com> <Pine.LNX.4.44.0212081406270.2547-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2002 19:56:42.0837 (UTC) FILETIME=[EE14B050:01C29EF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 2 Dec 2002, Andrew Morton wrote:
> 
> > I have observed two problems with the new scheduler, both serious IMO:
> >
> > 1) Changed sched_yield() semantics.  [...]
> 
> we noticed this OpenOffice/StarOffice problem in July, while beta-testing
> RH 8.0. In July Andrea already had another yield implementation in his
> tree, which was addressing an unrelated yield()-related regression. I'd
> like to note here that StarOffice/OpenOffice sucked just as much under
> Andrea's yield() variant as the original (and 2.5) O(1) scheduler variant
> did.
> 
> So i talked to Andrea, and we agreed in a rough solution that worked
> sufficiently well for OpenOffice and the other regression as well. I
> implemented it and tested it for OpenOffice. You can see (an i suspect
> later incarnation) of that implementation in Andrea's current tree. My
> position back then was that we should not try to move the arguably broken
> 2.4 yield() implementation to 2.5.
> 
> So this is the history of O(1) yield().
> 
> fortunately, things have changed since July, since due to NPTL threading
> the architectural need for user-space yield() has decreased significantly
> (NPTL uses futexes, no yielding anywhere), so the only worry is behavioral
> compatibility with LinuxThreads (and other yield() users). I'll forward
> port the new (well, old) yield() semantics to 2.5 as well, which will be
> quite similar to the yield() implementation in Andrea's tree.
> 
> there's another (this time unique) bit implemented by Andrea, a variant of
> giving newly forked children priority in a more subtle way - i'm testing
> this change currently, to see whether it has any positive effect on
> compilation workloads.
> 
> does this clarify things?
> 

Yes, thanks.  Will we also be seeing the "interactivity estimator" fixes
in 2.5?
