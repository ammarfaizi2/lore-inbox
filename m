Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTLVVKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTLVVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:10:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:7644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264467AbTLVVK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:10:28 -0500
Date: Mon, 22 Dec 2003 13:11:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jbarnes@sgi.com
Subject: Re: [PATCH] Simplify node/zone field in page->flags
Message-Id: <20031222131126.66bef9a2.akpm@osdl.org>
In-Reply-To: <3FE74B43.7010407@us.ibm.com>
References: <3FE74B43.7010407@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Currently we keep track of a pages node & zone in the top 8 bits (on 
> 32-bit arches, 10 bits on 64-bit arches) of page->flags.  We typically 
> compute the field as follows:
> 	node_num * MAX_NR_ZONES + zone_num = 'nodezone'
> 
> It's non-trivial to break this 'nodezone' back into node and zone 
> numbers.  This patch modifies the way we compute the index to be:
> 	(node_num << ZONE_SHIFT) | zone_num
> 
> This makes it trivial to recover either the node or zone number with a 
> simple bitshift.  There are many places in the kernel where we do things 
> like: page_zone(page)->zone_pgdat->node_id to determine the node a page 
> belongs to.  With this patch we save several pointer dereferences, and 
> it all boils down to shifting some bits.

This conflicts with (is a superset of) 

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm5/broken-out/ZONE_SHIFT-from-NODES_SHIFT.patch

I suspect you've sent a replacement patch, yes?  If Jesse is OK with the
new patch I'll do the swap, thanks.

