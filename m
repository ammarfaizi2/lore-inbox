Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbTLaBeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbTLaBeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:34:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:29385 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266049AbTLaBdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:33:51 -0500
Date: Tue, 30 Dec 2003 17:34:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: torvalds@osdl.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 performance problems
Message-Id: <20031230173411.01d46876.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312301938060.3193@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
	<Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
	<Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
	<Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
	<Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
	<20031230143929.GN27687@holomorphy.com>
	<Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
	<Pine.LNX.4.58.0312301318540.2065@home.osdl.org>
	<Pine.LNX.4.58.0312301938060.3193@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cablespeed.com> wrote:
>
>  On Tue, 30 Dec 2003, Linus Torvalds wrote:
>  > Ok. This looks much closer to the 2.4.x numbers you reported:
>  > 
>  > 	real    13m50.198s
>  > 	user    0m33.780s
>  > 	sys     0m15.390s
>  > 
>  > so I assume that we can consider this problem largely solved? There's 
>  > still some difference, that could be due to just VM tuning.. 
>  > 
>  > I suspect that what happened is:
>  >  - slab debugging adds a heavy CPU _and_ it also makes all the slab caches 
>  >    much less dense.
>  >  - as a result, you see much higher system times, and you also end up 
>  >    needing much more memory for things like the dentry cache, so your 
>  >    memory-starved machine ended up swapping a lot more too.
> 
>  So you are telling me that I am paying the price for running development 
>  kernels and enabling all the debugging.

CONFIG_DEBUG_PAGEALLOC really does hurt on small machines.  Mainly because
it rounds the size of all slab object which are >= 128 bytes up to a full
4k.  So things like inodes and dentries take vastly more memory.

The other debug options are less costly.

