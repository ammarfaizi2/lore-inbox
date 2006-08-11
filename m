Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWHKHaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWHKHaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWHKHaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:30:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:49851 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161214AbWHKHaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:30:12 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc3-mm2 - OOM storm
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060810235526.84c9f601.akpm@osdl.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <44DAF6A4.9000004@free.fr> <20060810021957.38c82311.akpm@osdl.org>
	 <1155285231.5841.6.camel@Homer.simpson.net>
	 <20060810235526.84c9f601.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:37:34 +0000
Message-Id: <1155289056.6455.7.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 23:55 -0700, Andrew Morton wrote:
> On Fri, 11 Aug 2006 08:33:51 +0000
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > kernel BUG at mm/vmscan.c:383!
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/ ;)
> 

Duh, I should have thought to look there first.  Sorry.

Anyhoo, I can reproduce the problem.  I now have ~800MB of cache that
echo 3 > drop_caches doesn't help with, and I just started swapping.

MemTotal:      1032656 kB
MemFree:         42704 kB
Buffers:           648 kB
Cached:         825468 kB
SwapCached:      29312 kB
Active:          31196 kB
Inactive:       830144 kB
HighTotal:      131008 kB
HighFree:         3056 kB
LowTotal:       901648 kB
LowFree:         39648 kB
SwapTotal:     1028152 kB
SwapFree:       961356 kB
Dirty:             156 kB
Writeback:           0 kB
AnonPages:       17240 kB
Mapped:          10240 kB
Slab:           118536 kB
PageTables:       1876 kB
NFS Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   1544480 kB
Committed_AS:   266884 kB
VmallocTotal:   114680 kB
VmallocUsed:      5372 kB
VmallocChunk:   109216 kB


