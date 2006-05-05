Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWEEPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWEEPDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWEEPDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:03:13 -0400
Received: from dvhart.com ([64.146.134.43]:46815 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751121AbWEEPDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:03:13 -0400
Message-ID: <445B6926.20109@mbligh.org>
Date: Fri, 05 May 2006 08:03:02 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Bob Picco <bob.picco@hp.com>, Andy Whitcroft <apw@shadowen.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>	 <20060504013239.GG19859@localhost>	 <1146756066.22503.17.camel@localhost.localdomain>	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>	 <20060505135503.GA5708@localhost>	 <1146839590.22503.48.camel@localhost.localdomain>	 <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain>
In-Reply-To: <1146841064.22503.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahhh.  I hadn't made the ia64 connection.  I wonder if it is worth
> making CONFIG_HOLES_IN_ZONE say ia64 or something about vmem_map in it
> somewhere.  Might be worth at least a comment like this:
> 
> +               if (page_in_zone_hole(buddy)) /* noop on all but ia64 */
> +                       break;
> +               else if (page_zonenum(buddy) != page_zonenum(page))
> +                       break;
> +               else if (!page_is_buddy(buddy, order))
>                         break;          /* Move the buddy up one level. */
> 
> BTW, wasn't the whole idea of discontig to have holes in zones (before
> NUMA) without tricks like this? ;)

Sparsemem should fix this - that was one of the things Andy designed it
for. Then we can remove the virtual memmap stuff (and discontig).
Indeed, I'd hope we're ready to do that real soon now ... has anyone
got an ia64 box that needed virtual memmap that they could test this
on?

M.
