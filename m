Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268527AbTBWTPR>; Sun, 23 Feb 2003 14:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268528AbTBWTPR>; Sun, 23 Feb 2003 14:15:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18192 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268527AbTBWTPQ>; Sun, 23 Feb 2003 14:15:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: object-based rmap and pte-highmem
Date: Sun, 23 Feb 2003 19:20:36 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3b6u4$bt2$1@penguin.transmeta.com>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <11090000.1046016895@[10.10.2.4]>
X-Trace: palladium.transmeta.com 1046028294 27760 127.0.0.1 (23 Feb 2003 19:24:54 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 23 Feb 2003 19:24:54 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <11090000.1046016895@[10.10.2.4]>,
Martin J. Bligh <mbligh@aracnet.com> wrote:
>> So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.
>
>I have a plan for that (UKVA) ... we reserve a per-process area with 
>kernel type protections (either at the top of user space, changing
>permissions appropriately, or inside kernel space, changing per-process
>vs global appropriately). 

Nobody ever seems to have solved the threading impact of UKVA's. I told
Andrea about it almost a year ago, and his reaction was "oh, duh!" and
couldn't come up with a solution either.

The thing is, you _cannot_ have a per-thread area, since all threads
share the same TLB.  And if it isn't per-thread, you still need all the
locking and all the scalability stuff that the _current_ pte_highmem
code needs, since there are people with thousands of threads in the same
process. 

Until somebody _addresses_ this issue with UKVA, I consider UKVA to be a
pipe-dream of people who haven't thought it through.

		Linus
