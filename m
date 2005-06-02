Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFBUKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFBUKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFBUJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:09:42 -0400
Received: from fsmlabs.com ([168.103.115.128]:7091 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261302AbVFBT4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:56:47 -0400
Date: Thu, 2 Jun 2005 13:59:26 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
In-Reply-To: <20050602144004.GA31807@elte.hu>
Message-ID: <Pine.LNX.4.61.0506021354190.3157@montezuma.fsmlabs.com>
References: <20050602144004.GA31807@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

On Thu, 2 Jun 2005, Ingo Molnar wrote:

> the attached patch (written by me and also containing many suggestions 
> of Arjan van de Ven) does a major cleanup of the spinlock code. It does 
> the following things:
> 
>  - consolidates and enhances the spinlock/rwlock debugging code
> 
>  - simplifies the asm/spinlock.h files
> 
>  - encapsulates the raw spinlock types and moves generic spinlock
>    features (such as ->break_lock) into the generic code.
> 
>  - cleans up the spinlock code hierarchy to get rid of spaghetti.
> 
> most notably there's now only a single variant of the debugging code, 
> located in lib/spinlock_debug.c. (previously we had one SMP debugging 
> variant per architecture, plus a separate generic one for UP builds)
> 
> also, i've enhanced the rwlock debugging facility, it will now track 
> write-owners. There is new spinlock-owner/CPU-tracking on SMP builds 
> too.
> 
> the arch-level include files now only contain the minimally necessary 
> subset of the spinlock code - all the rest that can be generalized now 
> lives in the generic headers:
> 
>  include/asm-i386/spinlock.h             |  116 +----
>  include/asm-i386/spinlock_types.h       |   16
>  include/asm-x86_64/spinlock.h           |  146 +------
>  include/asm-x86_64/spinlock_types.h     |   16
> 
> i've also split up the various spinlock variants into separate files, 
> making it easier to see which does what. The new layout is:

I like the cleanup/consolidation of the debug variants, 
that was pretty much overdue. My only qualm is in the increase of header 
files (some of them could have remained 1 file), unless of course this new 
structure makes work on a followup/dependent patch (is there one?) easier.

Thanks,
	Zwane

