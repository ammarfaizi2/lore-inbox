Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUBNABn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267192AbUBNABn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:01:43 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:18386 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264410AbUBNABm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:01:42 -0500
Message-ID: <402D6544.2080300@cyberone.com.au>
Date: Sat, 14 Feb 2004 11:01:08 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Hicks <mort@wildopensource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __alloc_pages - NUMA and lower zone protection
References: <20040213183243.GH12142@localhost>
In-Reply-To: <20040213183243.GH12142@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Hicks wrote:

>Hi,
>
>There is a problem with the current __alloc pages on a machine with many
>nodes.  As we go down the zones[] list, we may move onto other nodes.
>Each time we go to the next zone we protect these zones by doing
>"min += local_low".
>
>This is quite appropriate on a machine with one node, but wrong on
>machines with other nodes.  To illustrate, here is an example.  On a
>256 node Altix machine, a request on node 0 for 2MB requires just over
>600MB of free memory on the 256th node in order to fullfil the "min"
>requirements if all other nodes are low on memory.  This could leave
>73GB of memory unallocated across all nodes.
>
>This patch keeps the same semantics for lower_zone_protection, but only
>provides protection for higher priority zones in the same node.
>
>The patch seems to do the right thing on my non-NUMA zx1 ia64 machine
>(which has ZONE_DMA and ZONE_NORMAL) as well as the multi-node Altix.
>
>

Could you add a comment or two, please?

