Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbTCQUQh>; Mon, 17 Mar 2003 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTCQUQh>; Mon, 17 Mar 2003 15:16:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8334 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261909AbTCQUQg>;
	Mon, 17 Mar 2003 15:16:36 -0500
Date: Mon, 17 Mar 2003 20:27:26 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Matthew Wilcox <willy@debian.org>, bzzz@tmi.comex.ru,
       adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030317202726.GF28607@parcelfarce.linux.theplanet.co.uk>
References: <m3el5773to.fsf@lexa.home.net> <20030316104447.D12806@schatzie.adilger.int> <m3bs0bugca.fsf@lexa.home.net> <20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk> <m3ptoqjagt.fsf@lexa.home.net> <20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk> <20030317122357.41df48a9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317122357.41df48a9.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 12:23:57PM -0800, Andrew Morton wrote:
> Matthew Wilcox <willy@debian.org> wrote:
> >
> > Anyway, I think dcounters should probably be allocated from kmalloc_percpu()
> > rather than as part of the dcounter struct.
> 
> That will still consume up to 4 kilobytes per 32-bit counter.  We'd
> need to merge Kiran & Dipankar's interlace allocator to do this less
> grossly.

Right -- or have dcounter manage a pool of memory itself.  That's maybe too
much work though.

> Which is why I'm waiting to see some profiles and benchmarks.  Judging from
> the last set of profiles, in which ext2_count_free_blocks() was not present,
> this may not be justified.

If we can manage without it, that's even better of course.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
