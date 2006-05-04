Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWEDVvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWEDVvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWEDVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:51:12 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:63501 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030274AbWEDVvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:51:12 -0400
Message-ID: <445A7725.8030401@shadowen.org>
Date: Thu, 04 May 2006 22:50:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Picco <bob.picco@hp.com>
CC: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost>
In-Reply-To: <20060504194334.GH19859@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Picco wrote:
> Ingo Molnar wrote:	[Thu May 04 2006, 03:25:28PM EDT]
> 
>>* Bob Picco <bob.picco@hp.com> wrote:
>>
>>
>>>Dave Hansen wrote:	[Thu May 04 2006, 11:21:06AM EDT]
>>>
>>>>I haven't thought through it completely, but these two lines worry me:
>>>>
>>>>
>>>>>+ start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
>>>>>+ end = start + pgdat->node_spanned_pages;
>>>>
>>>>Should the "end" be based off of the original "start", or the aligned
>>>>"start"?
>>>
>>>Yes. I failed to quilt refresh before sending. You mean end should be 
>>>end = pgdat->node_start_pfn + pgdat->node_spanned_pages before 
>>>rounding up.
>>
>>do you have an updated patch i should try?
>>
>>	Ingo
> 
> You can try this but don't believe it will change your outcome. I've
> booted this on ia64 with slight modification to eliminate
> VIRTUAL_MEM_MAP and have only DISCONTIGMEM. Your case is failing at the
> front edge of of the zone and not the ending edge which had a flaw in my
> first post of the patch. I would have expected the first patch to handle
> the front edge correctly.
> 
> I don't remember seeing your .config in the thread (or blind and unable
> to see it). Would you please send it my way.
> 
> I'm also hoping Andy has time to look into this.
> 
> bob

Yeah will have a look tommorrow my time.  Could you drop me the .config
too.  There is definatly some unstated requirements on alignment, which
I was testing today.  I presume its one of those thats being violated.

-apw
