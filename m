Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJMWRk>; Sun, 13 Oct 2002 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJMWRk>; Sun, 13 Oct 2002 18:17:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10615 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261668AbSJMWRj>; Sun, 13 Oct 2002 18:17:39 -0400
To: colpatch@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 16:22:02 -0600
In-Reply-To: <3DA4D3E4.6080401@us.ibm.com>
Message-ID: <m165w6m12t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> writes:

> Greetings & Salutations,
> 	Here's a wonderful patch that I know you're all dying for...  Memory
> Binding!  It works just like CPU Affinity (binding) except that it binds a
> processes memory allocations (just buddy allocator for now) to specific memory
> blocks.
> 	I've sent this out in the past, but haven't touched it in months.  Since
> 
> the feature freeze is rapidly approaching, I want to get this out there again
> and see if anyone has any interest in it.
> 	It's a fairly large patch, mostly because it includes a few odds and
> ends that are topology related, and don't strictly belong in this patch, but are
> 
> pre-requisites for it (ie: the [memblk|node]_online_map stuff, and some of the
> cleanups to page_alloc).  I'll probably try and break it up into more discrete
> parts very soon.

Due we want this per numa area or simply per zone?  My suspicion is that
internally at least we want this per zone.
 
> Questions, comments, flames, and indifferent shrugs are all welcome.
> 
> btw, It applies (mostly) cleanly to mm1 as well.  The mm/page_alloc.c changes
> fail, but if anyone is interested, they'll clean up easily, and I'll send you a
> patch.

The API doesn't make much sense at the moment.

1) You are operating on tasks and not mm's, or preferably vmas.
2) sys_mem_setbinding does not move the mm to the new binding.
3) You specify a pid and then change current task instead of
   the specified one.

4) An ordered zone list is probably the more natural mapping.
5) mprotect is the more natural model rather than set_cpu_affinity.
6) The code belongs in mm/* not kernel/*

Eric
