Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVL0XC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVL0XC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVL0XC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:02:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932231AbVL0XC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:02:27 -0500
Date: Tue, 27 Dec 2005 15:02:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-Id: <20051227150220.12d038e8.akpm@osdl.org>
In-Reply-To: <20051227144242.GA8870@elte.hu>
References: <20051222114147.GA18878@elte.hu>
	<20051222153014.22f07e60.akpm@osdl.org>
	<20051222233416.GA14182@infradead.org>
	<200512251708.16483.zippel@linux-m68k.org>
	<20051225150445.0eae9dd7.akpm@osdl.org>
	<20051225232222.GA11828@elte.hu>
	<20051226023549.f46add77.akpm@osdl.org>
	<20051227144242.GA8870@elte.hu>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > hm, can you see any easy way for me to test my bold assertion on ext3, 
> > > by somehow moving/hacking it back to semaphores?
> > 
> > Not really.  The problem was most apparent after the lock_kernel() 
> > removal patches.  The first thing a CPU hit when it entered the fs was 
> > previously lock_kernel().  That became lock_super() and performance 
> > went down the tubes.  From memory, the bad kernel was tip-of-tree as 
> > of Memorial Weekend 2003 ;)
> > 
> > I guess you could re-add all the lock_super()s as per 2.5.x's 
> > ext3/jbd, check that it sucks running SDET on 8-way then implement the 
> > lock_super()s via a mutex.
> 
> ok - does the patch below look roughly ok as a really bad (but 
> functional) hack to restore that old behavior, for ext2?
> 

Hard to tell ;) 2.5.20's ext2 had 7 lock_super()s whereas for some reason
this patch adds 12...

I don't recall whether ext2 suffered wild context switches as badly as ext3
did.  It becomes pretty obvious in testing.

The really bad workload was SDET, which isn't available to mortals.  So
some hunting might be neded to find a suitable alternative.  dbench would be
a good start I guess.

