Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbSJVUwf>; Tue, 22 Oct 2002 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbSJVUwf>; Tue, 22 Oct 2002 16:52:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:17094 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264825AbSJVUwe>;
	Tue, 22 Oct 2002 16:52:34 -0400
Message-ID: <3DB5BBFC.479BE5DD@digeo.com>
Date: Tue, 22 Oct 2002 13:58:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: vm scenario tool / mincore(2) functionality for regular pages?
References: <20021022184313.GA12081@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 20:58:36.0832 (UTC) FILETIME=[CA611A00:01C27A0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> 
> I'm building a tool to subject the VM to different scenarios and I'd like to
> be able to determine if a page is swapped out or not. For a file I can
> easily determine if a page is in memory (in the page cache) or not using the
> mincore(2) system call.
> 
> I want to expand my tool so it can investigate which of its pages are
> swapped out under cache pressure or real memory pressure.
> 
> However, to do this, I need a way to determine if a page is there or if it
> is swapped out. My two questions are:
> 
>         1) is there an existing way to do this
>            (the kernel obviously knows)
> 
>         2) would it be correct to expand mincore to also work on
>            non-filebacked memory so it works for 'swap-backed' memory too?
> 

mincore needs to be taught to walk pagetables and to look up
stuff in swapcache.

Also it currently assumes that vma->vm_file is mapped linearly,
so it will return incorrect results with Ingo's nonlinear mapping
extensions.

But if we were to use Ingo's "file pte's" for all mmappings, mincore
only needs to do the pte->pagecache lookup, so it can lose the
"vma is linear" arithmetic.
