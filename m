Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265756AbUFXVy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUFXVy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFXVxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:53:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:19174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265813AbUFXVwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:52:16 -0400
Date: Thu, 24 Jun 2004 14:54:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@suse.de, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624145441.181425c8.akpm@osdl.org>
In-Reply-To: <20040624165629.GG21066@holomorphy.com>
References: <20040623213643.GB32456@hygelac>
	<20040623234644.GC38425@colin2.muc.de>
	<s5hhdt1i4yc.wl@alsa2.suse.de>
	<20040624112900.GE16727@wotan.suse.de>
	<s5h4qp1hvk0.wl@alsa2.suse.de>
	<20040624164258.1a1beea3.ak@suse.de>
	<s5hy8mdgfzj.wl@alsa2.suse.de>
	<20040624152946.GK30687@dualathlon.random>
	<40DAF7DF.9020501@yahoo.com.au>
	<20040624165200.GM30687@dualathlon.random>
	<20040624165629.GG21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Is there any chance you could send in thise improved implementation of
> zone fallback watermarks and describe the deficiencies in the current
> scheme that it corrects?

We decided earlier this year that the watermark stuff should be
forward-ported in toto, but I don't recall why.  Nobody got around to doing
it because there have been no bug reports.

It irks me that the 2.4 algorithm gives away a significant amount of
pagecache memory.  It's a relatively small amount, but it's still a lot of
memory, and all the 2.6 users out there at present are not reporting
problems, so we should not penalise all those people on behalf of the few
people who might need this additional fallback protection.

It should be runtime tunable - that doesn't seem hard to do.  All the
infrastructure is there now to do this.

Note that this code was sigificantly changed between 2.6.5 and 2.6.7.

First thing to do is to identify some workload which needs the patch. 
Without that, how can we test it?
