Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbUJ0DqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUJ0DqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUJ0DqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:46:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:25049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbUJ0DqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:46:05 -0400
Date: Tue, 26 Oct 2004 20:43:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@novell.com, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-Id: <20041026204308.73ee438b.akpm@osdl.org>
In-Reply-To: <417F1746.2080607@yahoo.com.au>
References: <417DCFDD.50606@yahoo.com.au>
	<Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
	<20041027005425.GO14325@dualathlon.random>
	<417F025F.5080001@yahoo.com.au>
	<20041027022920.GS14325@dualathlon.random>
	<417F0FA2.4090800@yahoo.com.au>
	<20041027032338.GU14325@dualathlon.random>
	<417F1746.2080607@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> It actually can overscan lower zones a little bit, because
>  whenever any higher zone in the pgdat is low on memory, then
>  it and all zones below it get scanned too.

Because we know that all of the eligible zones are below pages_low.  kswapd
will then work to bring all the relevant zones back to pages_high.

When working on this code it is very very easy to break the zone levelling:
you *have* to run a workload mix and monitor the numbers in /proc/vmstat to
ensure that all zones are undergoing page scanning at frequencies which are
proportional to their sizes.  It's easy to screw up the zone levelling so
all allocations end up coming from ZONE_NORMAL and pagecache pages in, say,
ZONE_DMA end up just sitting there.

