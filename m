Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTKWWaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTKWWaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:30:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:45738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263506AbTKWWaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:30:10 -0500
Date: Sun, 23 Nov 2003 14:36:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com,
       akpm@digeo.com
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-Id: <20031123143627.1754a3f0.akpm@osdl.org>
In-Reply-To: <3FBEB27D.5010007@us.ibm.com>
References: <3FBEB27D.5010007@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Currently the VM decides to start doing background writeback of pages if 
>  10% of the systems pages are dirty, and starts doing synchronous 
>  writeback of pages if 40% are dirty.  This is great for smaller memory 
>  systems, but in larger memory systems (>2GB or so), a process can dirty 
>  ALL of lowmem (ZONE_NORMAL, 896MB) without hitting the 40% dirty page 
>  ratio needed to force the process to do writeback. 

Yes, it has been that way for a year or so.  I was wondering if anyone
would hit any problems in practice.  Have you hit any problem in practice?

I agree that the per-zonification of this part of the VM/VFS makes some
sense, although not _complete_ sense, because as you've seen, we need to
perform writeout against all zones' pages if _any_ zone exceeds dirty
limits.  This could do nasty things on a 1G highmem machine, due to the
tiny highmem zone.  So maybe that zone should not trigger writeback.

However the simplest fix is of course to decrease the default value of the
dirty thresholds - put them back to the 2.4 levels.  It all depends upon
the nature of the problems which you have been observing?

