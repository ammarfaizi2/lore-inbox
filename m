Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUL3VNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUL3VNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUL3VM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:12:59 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:27528 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261719AbUL3VM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:12:57 -0500
Message-ID: <41D46F4A.5080505@yahoo.com.au>
Date: Fri, 31 Dec 2004 08:12:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [2/4]
References: <20041224173558.GC13747@dualathlon.random>
In-Reply-To: <20041224173558.GC13747@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> This is the forward port to 2.6 of the lowmem_reserved algorithm I
> invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
> like google (especially without swap) on x86 with >1G of ram, but it's
> needed in all sort of workloads with lots of ram on x86, it's also
> needed on x86-64 for dma allocations. This brings 2.6 in sync with
> latest 2.4.2x.
> 

This looks OK to me. It really simplifies the code there a lot too.

The only questions I have are: should it be on by default? I don't think
we ever reached an agreement. I'd say yes, after a run in -mm because it
does potentially fix corner cases where lower zones get filled with un-
freeable memory which could have been satisfied with higher zones.

And second, any chance you could you port it to the mm patches already in
-mm? Won't be a big job, just some clashes in __alloc_pages...

mm-keep-count-of-free-areas.patch
mm-higher-order-watermarks.patch
mm-higher-order-watermarks-fix.patch
mm-teach-kswapd-about-higher-order-areas.patch

Thanks,
Nick
