Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUKJK3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUKJK3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 05:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbUKJK3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 05:29:32 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:44745 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261663AbUKJK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 05:29:14 -0500
Date: Wed, 10 Nov 2004 11:28:54 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110102854.GI20754@zaphods.net>
References: <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net> <419197EA.9090809@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419197EA.9090809@cyberone.com.au>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 03:24:10PM +1100, Nick Piggin wrote:
> Can you try the following patch, please? It is diffed against 2.6.10-rc1,
> but I think it should apply to -mm kernels as well.
> 
> Basically 2.6.8 and earlier kernels had some quirks in the page allocator
> that would allow for example, a large portion of "DMA" memory to be reserved
> for network memory allocations (atomic allocations). After 'fixing' this
> problem, 2.6.9 is effectively left with about a quarter the amount of memory
> reserved for network allocations compared with 2.6.8.
> 
> The following patch roughly restores parity there. Thanks.
I applied the patch to 2.6.10-rc1-mm4 and the application froze again, but i
just remembered that i changed a kernel-option in mm4 and forgot about that
yesterday:
I unset CONFIG_PACKET_MMAP and i suppose this could have this kind of effect
on high connection rates.
I set it back to CONFIG_PACKET_MMAP=y and if the application does not freeze
for some hours at this load we can blame at least this issue (-1 EAGAIN) on
that parameter.

My variation of Harrisberger's Fourth Law of the Lab:
 Experience is directly proportional to the amount of braincells ruined.

*ouch*,
	Stefan
