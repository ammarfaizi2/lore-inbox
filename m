Return-Path: <linux-kernel-owner+w=401wt.eu-S932308AbXADG4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbXADG4K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbXADG4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:56:09 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44713
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932308AbXADG4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:56:08 -0500
Date: Wed, 03 Jan 2007 22:56:07 -0800 (PST)
Message-Id: <20070103.225607.133169483.davem@davemloft.net>
To: akpm@osdl.org
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, gelma@gelma.net,
       linux-kernel@vger.kernel.org
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070103221220.c4589831.akpm@osdl.org>
References: <20070103214121.997be3e6.akpm@osdl.org>
	<459C98BF.5080409@yahoo.com.au>
	<20070103221220.c4589831.akpm@osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 3 Jan 2007 22:12:20 -0800

> On Thu, 04 Jan 2007 17:03:43 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > > That bug was introduced in 2.6.19, with the dirty page tracking patches.
> > > 
> > > 2.6.18 and earlier used ->private_lock coverage in try_to_free_buffers() to
> > > prevent it.
> > 
> > Ohh, right you are, I was looking at 2.6.19 sources. The comments above
> > ttfb match that as well. Curious that the dirty page patches were allowed
> > to mess with this...
> 
> Frankly, those patches scared the crap out of me, specifically because of
> the delicacy and complexity of the various dirtiness state coherencies. 
> But I just didn't have the bandwidth to go through them with a sufficiently
> fine toothcomb, sorry.
> 
> > Anyway that leaves us with the question of why Andrea's database is getting
> > corrupted. Hopefully he can give us a minimal test-case.
> 
> It'd odd that stories of pre-2.6.19 BerkeleyDB corruption are now coming
> out of the woodwork.  It's the first I've ever heard of them.

Note that the original rtorrent debian bug report was against 2.6.18
