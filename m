Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWAMPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWAMPSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161367AbWAMPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:18:37 -0500
Received: from mail01.fortunecookiestudios.com ([209.208.125.101]:3254 "EHLO
	mail01.fortunecookiestudios.com") by vger.kernel.org with ESMTP
	id S1161001AbWAMPSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:18:36 -0500
Message-ID: <43C7C4C7.8050409@cfl.rr.com>
Date: Fri, 13 Jan 2006 10:18:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
In-Reply-To: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't those kind of applications already be using threads to share 
page tables rather than forking hundreds of processes that all mmap() 
the same file?


Dave McCracken wrote:
> Here's a new version of my shared page tables patch.
>
> The primary purpose of sharing page tables is improved performance for
> large applications that share big memory areas between multiple processes.
> It eliminates the redundant page tables and significantly reduces the
> number of minor page faults.  Tests show significant performance
> improvement for large database applications, including those using large
> pages.  There is no measurable performance degradation for small processes.
>
> This version of the patch uses Hugh's new locking mechanism, extending it
> up the page table tree as far as necessary for proper concurrency control.
>
> The patch also includes the proper locking for following the vma chains.
>
> Hugh, I believe I have all the lock points nailed down.  I'd appreciate
> your input on any I might have missed.
>
> The architectures supported are i386 and x86_64.  I'm working on 64 bit
> ppc, but there are still some issues around proper segment handling that
> need more testing.  This will be available in a separate patch once it's
> solid.
>
> Dave McCracken
>   

