Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCOW05>; Sat, 15 Mar 2003 17:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbTCOW05>; Sat, 15 Mar 2003 17:26:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:23440 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261584AbTCOW04>;
	Sat, 15 Mar 2003 17:26:56 -0500
Date: Sat, 15 Mar 2003 14:37:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-Id: <20030315143718.60e006b7.akpm@digeo.com>
In-Reply-To: <20030315220241.GX20188@holomorphy.com>
References: <m365qk1gzx.fsf@lexa.home.net>
	<20030315220241.GX20188@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 22:37:03.0191 (UTC) FILETIME=[6653F670:01C2EB43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sun, Mar 16, 2003 at 12:01:38AM +0300, Alex Tomas wrote:
> > here is the patch for ext2 concurrent inode allocation. should be applied
> > on top of previous concurrent-balloc patch. tested on dual p3 for several
> > hours of stress-test + fsck. hope someone test it on big iron ;)
> 
> 32x/48GB NUMA-Q
> 
> Throughput 257.986 MB/sec 128 procs
> dbench 128  95.36s user 4833.06s system 2832% cpu 2:53.97 total
> 
> vma      samples  %-age       symbol name
> c01dc9ac 4532033  21.4566     .text.lock.dec_and_lock
> c0169c0b 3835802  18.1603     .text.lock.dcache
> c0106ff4 1741849  8.24666     default_idle

Looks like it's gone nuts when 128 processes all try to close lots of
files at the same time.

One possible reason for this leaping out is that all the instances are now
achieving more uniform runtimes.   You can tell that by comparing the dbench
dots.

