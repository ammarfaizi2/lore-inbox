Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbTCQUNt>; Mon, 17 Mar 2003 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCQUNt>; Mon, 17 Mar 2003 15:13:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:8120 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261853AbTCQUNs>;
	Mon, 17 Mar 2003 15:13:48 -0500
Date: Mon, 17 Mar 2003 12:23:57 -0800
From: Andrew Morton <akpm@digeo.com>
To: Matthew Wilcox <willy@debian.org>
Cc: bzzz@tmi.comex.ru, willy@debian.org, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid
 group scaning
Message-Id: <20030317122357.41df48a9.akpm@digeo.com>
In-Reply-To: <20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
References: <m3el5773to.fsf@lexa.home.net>
	<20030316104447.D12806@schatzie.adilger.int>
	<m3bs0bugca.fsf@lexa.home.net>
	<20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
	<m3ptoqjagt.fsf@lexa.home.net>
	<20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2003 20:23:54.0449 (UTC) FILETIME=[217E2C10:01C2ECC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>
> Anyway, I think dcounters should probably be allocated from kmalloc_percpu()
> rather than as part of the dcounter struct.

That will still consume up to 4 kilobytes per 32-bit counter.  We'd
need to merge Kiran & Dipankar's interlace allocator to do this less
grossly.

Which is why I'm waiting to see some profiles and benchmarks.  Judging from
the last set of profiles, in which ext2_count_free_blocks() was not present,
this may not be justified.

