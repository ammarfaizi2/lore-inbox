Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTKWWeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTKWWeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:34:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:12203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263500AbTKWWef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:34:35 -0500
Date: Sun, 23 Nov 2003 14:40:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com,
       jbarnes@sgi.com
Subject: Re: [RFC] Simplify node/zone portion of page->flags
Message-Id: <20031123144052.1f0d5071.akpm@osdl.org>
In-Reply-To: <3FBEB867.9080506@us.ibm.com>
References: <3FBEB867.9080506@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Currently we keep track of a pages node & zone in the top 8 bits (on 
>  32-bit arches, 10 bits on 64-bit arches) of page->flags.  We typically 
>  do: node_num * MAX_NR_ZONES + zone_num = 'nodezone'.  It's non-trivial 
>  to break this 'nodezone' back into node and zone numbers.  This patch 
>  modifies the way we compute the index to be: (node_num << ZONE_SHIFT) | 
>  zone_num.  This makes it trivial to recover either the node or zone 
>  number with a simple bitshift.  There are many places in the kernel 
>  where we do things like: page_zone(page)->zone_pgdat->node_id to 
>  determine the node a page belongs to.  With this patch we save several 
>  pointer dereferences, and it boils down to shifting some bits.

This rather conflicts with the patch from Jesse which I have.  Can you guys
work that out and let me know when you're done?

