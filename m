Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWEFKwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWEFKwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 06:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWEFKwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 06:52:20 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:679 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750723AbWEFKwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 06:52:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K7lmSo6deeQooSLxfmL+BJqqVTtDxWxf8ssSOOsUIVh3mVrsvKjA2CRNksLeAgruMdEYsxNh88fNxCo9rTDrA4oM9fJbjZxrC2D13lEKxqcoUFSzBzsIBNuLp/3vSD3xVC5G2x1/F1UJE8Yk0WddWev9m8NaeyuFFDGEyvv2twA=  ;
Message-ID: <445C5F36.3030207@yahoo.com.au>
Date: Sat, 06 May 2006 18:32:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Bob Picco <bob.picco@hp.com>, Andy Whitcroft <apw@shadowen.org>,
       Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>	 <20060504013239.GG19859@localhost>	 <1146756066.22503.17.camel@localhost.localdomain>	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>	 <20060505135503.GA5708@localhost>	 <1146839590.22503.48.camel@localhost.localdomain>	 <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain>
In-Reply-To: <1146841064.22503.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

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

Yes.

I don't like the patch much, because all that logic should be moved
into page_is_buddy where I put it (surely it is more readable not to
have the checks spilling out -- a page which is not in the correct
zone or is a "hole" is by definition not a buddy, right?)

So, I agree with adding the zone check if any architecture needs it.
But it would be something under CONFIG_HOLES_IN_ZONE, and the arch
needs to *either* align zones correctly (as they've always had to),
or turn this option on.

Thanks for working at this, everyone.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
