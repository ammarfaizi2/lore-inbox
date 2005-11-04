Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVKDVj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKDVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKDVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:39:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750934AbVKDVj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:39:28 -0500
Date: Fri, 4 Nov 2005 13:39:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511041310130.28804@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0511041333560.28804@g5.osdl.org>
References: <20051104210418.BC56F184739@thermo.lanl.gov>
 <Pine.LNX.4.64.0511041310130.28804@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Linus Torvalds wrote:
> 
> But the hint can be pretty friendly. Especially if it's an option to just 
> load a lot of memory into the boxes, and none of the loads are expected to 
> want to really be excessively close to memory limits (ie you could just 
> buy an extra 16GB to allow for "slop").

One of the issues _will_ be how to allocate things on NUMA. Right now 
"hugetlb" only allows us to say "this much memory for hugetlb", and it 
probably needs to be per-zone. 

Some uses might want to allocate all of the local memory on one node to 
huge-page usage (and specialized programs would then also like to run 
pinned to that node), others migth want to spread it out. So the 
maintenance would need to decide that.

The good news is that you can boot up with almost all zones being "big 
page" zones, and you could turn them into "normal zones" dynamically. It's 
only going the other way that is hard.

So from a maintenance standpoint if you manage lots of machines, you could 
have them all uniformly boot up with lots of memory set aside for large 
pages, and then use user-space tools to individually turn the zones into 
regular allocation zones.

		Linus
