Return-Path: <linux-kernel-owner+w=401wt.eu-S932300AbXADHGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbXADHGh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbXADHGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:06:37 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:53291 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300AbXADHGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:06:36 -0500
Date: Wed, 3 Jan 2007 23:06:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, torvalds@osdl.org, gelma@gelma.net,
       linux-kernel@vger.kernel.org
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-Id: <20070103230629.a2e734b9.akpm@osdl.org>
In-Reply-To: <20070103.225607.133169483.davem@davemloft.net>
References: <20070103214121.997be3e6.akpm@osdl.org>
	<459C98BF.5080409@yahoo.com.au>
	<20070103221220.c4589831.akpm@osdl.org>
	<20070103.225607.133169483.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 22:56:07 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Wed, 3 Jan 2007 22:12:20 -0800
> 
> > On Thu, 04 Jan 2007 17:03:43 +1100
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > > > That bug was introduced in 2.6.19, with the dirty page tracking patches.
> > > > 
> > > > 2.6.18 and earlier used ->private_lock coverage in try_to_free_buffers() to
> > > > prevent it.
> > > 
> > > Ohh, right you are, I was looking at 2.6.19 sources. The comments above
> > > ttfb match that as well. Curious that the dirty page patches were allowed
> > > to mess with this...
> > 
> > Frankly, those patches scared the crap out of me, specifically because of
> > the delicacy and complexity of the various dirtiness state coherencies. 
> > But I just didn't have the bandwidth to go through them with a sufficiently
> > fine toothcomb, sorry.
> > 
> > > Anyway that leaves us with the question of why Andrea's database is getting
> > > corrupted. Hopefully he can give us a minimal test-case.
> > 
> > It'd odd that stories of pre-2.6.19 BerkeleyDB corruption are now coming
> > out of the woodwork.  It's the first I've ever heard of them.
> 
> Note that the original rtorrent debian bug report was against 2.6.18

I think that was 2.6.18+debian-added-dirty-page-tracking-patches.

If that memory is correct, I'll assert (and emphasise) that the cause of the
alleged BerkeleyDB corruption is not known at this time.

The post-2.6.19 "fix" might make it go away.  But if it does, we do not know
why, and it might still be there, only harder to hit.

