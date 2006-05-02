Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWEBB1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWEBB1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 21:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWEBB1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 21:27:43 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47824 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932337AbWEBB1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 21:27:42 -0400
Date: Tue, 2 May 2006 10:27:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [RFC][PATCH] hot add memory which is not aligned
 to section
Message-Id: <20060502102718.9b73f7e3.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1146495392.32079.12.camel@localhost.localdomain>
References: <20060427223705.e99bb194.kamezawa.hiroyu@jp.fujitsu.com>
	<1146495392.32079.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 May 2006 07:56:32 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> The 'struct resource' which gets passed into find_next_system_ram()
> isn't a real resource.  Why not just pass a normal start and end address
> in there, and let _it_ do the work?
> 
just I don't like return prural values by one function call, I needed start
and end.

> It looks like that whole loop is optimized for being able to online a
> really sparse area without diving into the iomem tables very often.
> This seems like a premature complicating optimization to me.  
> 
Hmm...complicating ?  

> Why not do something like this:
> 
> 	for (i = 0; i < nr_pages; i++) {
> 		struct page *page = pfn_to_page(pfn + i);
> 
> 		if (page_is_in_io_resource(page))
> 			continue;
> 
> 		online_page(page);
> 		onlined_pages++;
> 	}
> 
> That way, you keep the memory_hotplug.c file nice and neat.
> 
I'll clean up this later (if I can). maybe adding function like this will work.
-
	ioresouce_walk(scan_start, scan_end, callback_func);
-
I don't want to modify structures of resource just for memory hotplug.
Then, I want to avoid list-waliking as much as possible.


> Also, remind me again why you can't just make the SECTION_SIZE match
> your 64MB I/O hole sizes.  I forget a lot/ :)
> 
ia64 has 1GB SECTION_SIZE as default ;). I don't think our (fujitsu's)
customers can configure and recompile the kernel.


-Kame
P.S. I'm away from network until this week end.

