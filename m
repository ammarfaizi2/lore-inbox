Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUBFB5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUBFB5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:57:53 -0500
Received: from ns.suse.de ([195.135.220.2]:7610 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265325AbUBFB5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:57:51 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Feb 2004 02:54:54 +0100
In-Reply-To: <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73isilkm4x.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Ken, I remain unhappy with this patch.  If a big box has 500 million
> dentries or inodes in cache (is possible), those hash chains will be more
> than 200 entries long on average.  It will be very slow.

How about limiting the global size of the dcache in this case ? 

I cannot imagine a workload where it would make sense to ever cache 
500 million dentries. It just risks to keep the whole file system
after an updatedb in memory on a big box, which is not necessarily
good use of the memory.

Limiting the number of dentries would keep the hash chains at a 
reasonable length too and somewhat bound the worst case CPU 
use for cache misses and search time in cache lookups.

-Andi
