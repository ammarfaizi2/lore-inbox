Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTBTDGO>; Wed, 19 Feb 2003 22:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTBTDGO>; Wed, 19 Feb 2003 22:06:14 -0500
Received: from holomorphy.com ([66.224.33.161]:59804 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264745AbTBTDGN>;
	Wed, 19 Feb 2003 22:06:13 -0500
Date: Wed, 19 Feb 2003 19:15:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220031514.GX29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Chris Wedgwood <cw@f00f.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com> <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com> <20030220022627.GW29983@holomorphy.com> <Pine.LNX.4.50.0302192146580.10247-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302192146580.10247-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, William Lee Irwin III wrote:
>> Looks like either a pagetable or physmap/vmalloc/fixmap screwup.
>> What do the bootlogs have for those things?

On Wed, Feb 19, 2003 at 09:55:47PM -0500, Zwane Mwaikambo wrote:
> Verified there were no overlapping regions. If you really really really 
> want them i can put in some printks

The printk's should have come in with the pgcl patch. Did you keep the
bootlogs? I'm looking for rounding errors in my pagetable init stuff
to see if we're trying to use memory beyond the edge of a 2MB region
we didn't bother mapping or something but that only matters for phys
mappings and so on. If you hit vmallocspace or fixmapspace it's an
entirely different question. There are also small "holes"...

So it'd be very handy to figure out which of the three spaces the
address that turned up in %cr2 was supposed to be in. I can probably
guess a little better if you told me your PAGE_MMUSHIFT value also.


-- wli
