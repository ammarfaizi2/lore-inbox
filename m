Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUBWDpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUBWDpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:45:24 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:65286
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261797AbUBWDpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:45:22 -0500
Message-ID: <4039774C.8080805@matchmail.com>
Date: Sun, 22 Feb 2004 19:45:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: Large slab cache in 2.6.1
References: <20040221221553.01b1b71c.akpm@osdl.org> <38800000.1077466122@[10.10.2.4]> <20040222175554.GD25664@mail.shareable.org>
In-Reply-To: <20040222175554.GD25664@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> It's not totally insane to free dcache entries from pages that won't
> be freed.  It encourages new entries to be allocated in those pages.
> 
> Ideally you'd simply mark those dcache entries as prime candidates for
> recycling when new entries are needed, without actually freeing them
> until new entries are needed - or until their whole pages can be
> released.

This doesn't do much when you want to actually free slab pages though...

I had a similair thought, where you'd mark slab pages where you should 
aggressively try to free the containing slab objects in future scans, 
but didn't send it since someone else had probably already thought of it.

> 
> Also, biasing new allocations to recycle those old dcache entries, but
> also biasing them to recently used pages, so that recently used
> entries tend to cluster in the same pages.
> 

Hmm, so if slab is on the LRU, then in some cases the page can't be 
freed because of locked slab objects and new objects get allocated to 
the new mostly free slab page, and you didn't free very many pages.

Though this might better utilize the slab pages...

Mike

