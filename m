Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTGCMwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTGCMwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:52:17 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:36198 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262116AbTGCMwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:52:16 -0400
Date: Thu, 3 Jul 2003 09:06:32 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030703125839.GZ23578@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Andrea Arcangeli wrote:

> even if you don't use largepages as you should, the ram cost of the pte
> is nothing on 64bit archs, all you care about is to use all the mhz and
> tlb entries of the cpu.

That depends on the number of Oracle processes you have.
Say that page tables need 0.1% of the space of the virtual
space they map.  With 1000 Oracle users you'd end up needing
as much memory in page tables as your shm segment is large.

Of course, in this situation either the application should
use large pages or the kernel should simply reclaim the
page tables (possible while holding the mmap_sem for write).

> remap_file_pages is useful only for VLM in 32bit

Agreed on that.  Please let the monstrosity die together
with 32 bit machines ;)

