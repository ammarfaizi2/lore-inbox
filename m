Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266515AbUBETFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUBETFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:05:13 -0500
Received: from gprs146-93.eurotel.cz ([160.218.146.93]:1921 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266526AbUBETEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:04:35 -0500
Date: Thu, 5 Feb 2004 20:03:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alok Mooley <rangdi@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <20040205190349.GC294@elf.ucw.cz>
References: <20040204191829.57468.qmail@web9704.mail.yahoo.com> <Pine.LNX.4.53.0402041427270.2947@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402041427270.2947@chaos>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If this is an Intel x86 machine, it is impossible
> > > for pages
> > > to get fragmented in the first place. The hardware
> > > allows any
> > > page, from anywhere in memory, to be concatenated
> > > into linear
> > > virtual address space. Even the kernel address space
> > > is virtual.
> > > The only time you need physically-adjacent pages is
> > > if you
> > > are doing DMA that is more than a page-length at a
> > > time. The
> > > kernel keeps a bunch of those pages around for just
> > > that
> > > purpose.
> > >
> > > So, if you are making a "memory defragmenter", it is
> > > a CPU time-sink.
> > > That's all.
> >
> > What if the external fragmentation increases so much
> > that it is not possible to find a large sized block?
> > Then, is it not better to defragment rather than swap
> > or fail?
> >
> > -Alok
> 
> All "blocks" are the same size, i.e., PAGE_SIZE. When RAM
> is tight the content of a page is written to the swap-file
> according to a least-recently-used protocol. This frees
> a page. Pages are allocated to a process only one page at
> a time. This prevents some hog from grabbing all the memory
> in the machine. Memory allocation and physical page allocation
> are two different things, I can malloc() a gigabyte of RAM on
> a machine. It only gets allocated when an attempt is made
> to access a page.

Alok is right. kernel needs to do kmalloc(8K) from time to time. And
notice that kernel uses 4M tables.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
