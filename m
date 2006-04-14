Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWDNQCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDNQCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDNQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:02:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62629 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751262AbWDNQCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:02:12 -0400
Date: Fri, 14 Apr 2006 09:01:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413222516.4cb5885c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604140856420.18298@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <20060413181716.152493b8.akpm@osdl.org>
 <Pine.LNX.4.64.0604131831150.16220@schroedinger.engr.sgi.com>
 <20060413222516.4cb5885c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Andrew Morton wrote:

> > We would have to take that for each task mapping the page. Very expensive 
> > operation.
> 
> So...  why does do_migrate_pages() take mmap_sem at all?

In order to scan for migratable pages through the page table and in order 
to guarantee the existence of the anon vma.

> And the code we're talking about here deals with anonymous pages, which are
> not shared betweem mm's.

COW f.e. results in sharing.

Hmmm.. But I see the point the "optimization" causes an inconsistency 
between anon and file backed pages. For anon pages we need to do this 
polling. I had prior unoptimized version that modified lookup_swap_cache 
to handle migration entries. Maybe we better undo the optimization.


