Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUICP7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUICP7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUICP7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:59:44 -0400
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:24531 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S269072AbUICP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:59:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
References: <20040903014811.6247d47d.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Sep 2004 17:59:37 +0200
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
Message-ID: <m3brgncphy.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> 
> - Added the m32r architecture.  Haven't looked at it yet.
> 
> - Status update on various large patches in -mm:
> 
>   - The packet-writing code is awaiting resolution of the
>     abuse-of-elevator-fields problem.

It doesn't abuse the elevator fields any more. That was fixed by the
packet-writing-avoid-bio-hackery patch which is already in -mm.

One problem that does remain though, is that when dumping huge amounts
of data to a CD or DVD disc (so that you get memory pressure), the
effective writing speed of other block devices (like IDE hard disks)
is reduced to the same speed as the packet device.

I have posted a patch that fixes this problem by limiting the amount
of writeback data in the packet driver, but unfortunately it makes the
effective writing speed of the packet device suffer a lot. The proper
fix is probably to improve the filesystem and/or VM code to start I/O
operations in sequential order a lot more often than it currently
does.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
