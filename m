Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUKBQI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUKBQI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbUKBQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:03:24 -0500
Received: from cantor.suse.de ([195.135.220.2]:13997 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262397AbUKBP7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:59:50 -0500
Date: Tue, 2 Nov 2004 16:55:07 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, hugh@veritas.com, ak@suse.de
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <20041102155507.GA323@wotan.suse.de>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com> <14340000.1099410418@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14340000.1099410418@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 07:46:59AM -0800, Martin J. Bligh wrote:
> > This patch causes memory allocation for tmpfs files to be distributed
> > evenly across NUMA machines.  In most circumstances today, tmpfs files
> > will be allocated on the same node as the task writing to the file.
> > In many cases, particularly when large files are created, or a large
> > number of files are created by a single task, this leads to a severe
> > imbalance in free memory amongst nodes.  This patch corrects that
> > situation.
> 
> Yeah, but it also ruins your locality of reference (in a NUMA sense). 
> Not convinced that's a good idea. You're guaranteeing universally consistent
> worse-case performance for everyone. And you're only looking at a situation
> where there's one allocator on the system, and that's imbalanced.
> 
> You WANT your data to be local. That's the whole idea.

I think it depends on how you use tmpfs. When you use it for read/write
it's a good idea because you likely don't care about a bit of additional
latency and it's better to not fill up your local nodes with temporary
files.

If you use it with mmap then you likely want local policy.

But that's a big ugly to distingush, that is why I suggested the sysctl.

-Andi
