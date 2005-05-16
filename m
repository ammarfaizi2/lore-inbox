Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVEPV0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVEPV0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEPVWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:22:36 -0400
Received: from dvhart.com ([64.146.134.43]:60065 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261887AbVEPVVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:21:06 -0400
Date: Mon, 16 May 2005 14:21:01 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
Message-ID: <740100000.1116278461@flay>
In-Reply-To: <200505161410.43382.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right, the SGI boxes have discontiguous memory within a node, but it's 
> not represented by pgdats (like you said, one 'virtual memmap' spans 
> the whole address space of a node).  Sparse can help simplify this 
> across platforms, but has the potential to be more expensive for 
> systems with dynamically sized holes, due to the additional calculation 
> and potential cache miss associated with indexing into the correct 
> memmap (Dave can probably correct me here, it's been awhile).  With a 
> virtual memmap, you only occasionally take a TLB miss on the struct 
> page access after indexing into the array.

That's exactly what was brilliant about Andy's code ... it fixed that,
there shouldn't be extra references ...
 
>> transition config options are a bit of a mess ... Andy, I presume
>> CONFIG_NEED_MULTIPLE_NODES is really CONFIG_NEED_MULTIPLE_PGDATS ?
> 
> Yeah, makes sense for the NUMA aware slab allocator to depend on 
> CONFIG_NUMA.

Andy confirmed offline that this is really CONFIG_NEED_MULTIPLE_PGDATS,
and is just named wrong.

M.

