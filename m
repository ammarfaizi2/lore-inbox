Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUAEV2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUAEV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:28:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:53936 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265851AbUAEV2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:28:13 -0500
Message-ID: <3FF9D5B1.3080609@us.ibm.com>
Date: Mon, 05 Jan 2004 13:22:57 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jbarnes@sgi.com
Subject: Re: [PATCH] Simplify node/zone field in page->flags
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>Currently we keep track of a pages node & zone in the top 8 bits (on 
>>32-bit arches, 10 bits on 64-bit arches) of page->flags.  We typically 
>>compute the field as follows:
>>	node_num * MAX_NR_ZONES + zone_num = 'nodezone'
>>
>>It's non-trivial to break this 'nodezone' back into node and zone 
>>numbers.  This patch modifies the way we compute the index to be:
>>	(node_num << ZONE_SHIFT) | zone_num
>>
>>This makes it trivial to recover either the node or zone number with a 
>>simple bitshift.  There are many places in the kernel where we do things 
>>like: page_zone(page)->zone_pgdat->node_id to determine the node a page 
>>belongs to.  With this patch we save several pointer dereferences, and 
>>it all boils down to shifting some bits.
> 
> 
> This conflicts with (is a superset of) 
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm5/broken-out/ZONE_SHIFT-from-NODES_SHIFT.patch
> 
> I suspect you've sent a replacement patch, yes?  If Jesse is OK with the
> new patch I'll do the swap, thanks.

Jesse had acked the patch in an earlier itteration.  The only thing 
that's changed is some line offsets whilst porting the patch forward.

Jesse (or anyone else?), any objections to this patch as a superset of 
yours?

Cheers!

-Matt

