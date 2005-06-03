Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFCN5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFCN5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFCN5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:57:43 -0400
Received: from dvhart.com ([64.146.134.43]:23207 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261270AbVFCN5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:57:41 -0400
Date: Fri, 03 Jun 2005 06:57:42 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, jschopp@austin.ibm.com,
       mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <369850000.1117807062@[10.10.2.4]>
In-Reply-To: <429FFC21.1020108@yahoo.com.au>
References: <429E50B8.1060405@yahoo.com.au><429F2B26.9070509@austin.ibm.com><1117770488.5084.25.camel@npiggin-nld.site> <20050602.214927.59657656.davem@davemloft.net> <357240000.1117776882@[10.10.2.4]> <429FFC21.1020108@yahoo.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>> Actually, even with TSO enabled, you'll get large order
>>> allocations, but for receive packets, and these allocations
>>> happen in software interrupt context.
>> 
>> Sounds like we still need to cope then ... ?
> 
> Sure. Although we should try to not use higher order allocs if
> possible of course. Even with a fallback mode, you will still be
> putting more pressure on higher order areas and thus degrading
> the service for *other* allocators, so such schemes should
> obviously be justified by performance improvements.

My point is that outside of a benchmark situation (where we just
rebooted the machine to run a test) you will NEVER get an order 4
block free anyway, so it's pointless. Moreover, if we use non-contig
order 0 blocks, we can use cache hot pages ;-)

M.

