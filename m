Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSEAWpd>; Wed, 1 May 2002 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSEAWpc>; Wed, 1 May 2002 18:45:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46098 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314079AbSEAWpb>;
	Wed, 1 May 2002 18:45:31 -0400
Message-ID: <3CD06FD1.2E75F5F2@zip.com.au>
Date: Wed, 01 May 2002 15:44:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu updates
In-Reply-To: <3CD06ACE.1090402@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> These patches convert some of the existing arrays based on NR_CPUS to
> use the new per cpu code.
> 
> ...
> -extern struct page_state {
> +struct page_state {
>         unsigned long nr_dirty;
>         unsigned long nr_locked;
>         unsigned long nr_pagecache;
> -} ____cacheline_aligned_in_smp page_states[NR_CPUS];
> +};
> +
> +extern struct page_state __per_cpu_data page_states;

When I did this a couple of weeks back it failed in
mysterious ways and I ended up parking it.  Failure
symptoms included negative numbers being reported in
/proc/meminfo for "Locked" and "Dirty".

How well has this been tested?  (If the answer
is "not very" then please wait until I've tested
it out...)

-
