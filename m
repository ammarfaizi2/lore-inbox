Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUHXPzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUHXPzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUHXPza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:55:30 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:27057 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S268053AbUHXPzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:55:05 -0400
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: oom-killer 2.6.8.1
Date: Tue, 24 Aug 2004 17:55:04 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, joe@unthought.net,
       Gene Heskett <gene.heskett@verizon.net>,
       Hugh Dickins <hugh@veritas.com>
References: <200408181455.42279.as@cohaesio.com> <200408241130.15577.as@cohaesio.com> <20040824154131.GM2793@holomorphy.com>
In-Reply-To: <20040824154131.GM2793@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408241755.05149.as@cohaesio.com>
X-OriginalArrivalTime: 24 Aug 2004 15:55:04.0044 (UTC) FILETIME=[B84E32C0:01C489F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 August 2004 17:41, William Lee Irwin III wrote:
> On Tue, Aug 24, 2004 at 11:30:15AM +0200, Anders Saaby wrote:
> > OK - I now have some additional info regarding the slapinfo/oom-killer
> > issue.
> > As I wrote earlier this server is a storage server providing NFS storage
> > to a number of webservers - ondisk filesystem is xfs, kernel = 2.6.8.1.
> > At 03:00 some logrotate scripts runs throug a lot of files. It appears
> > that this is what is using the slabs (see this graph, K = M, so max used
> > slab is approx. 700M)
> > http://saaby.com/slabused.gif (values are from /proc/meminfo)
> > These are the values (from slabinfo, active_objs), which changed
> > remarkably from 03:00 to 06:00:
> > 03:00:        06:00:
> > xfs_chashlist  91297    xfs_chashlist     151994
> > xfs_inode     243791    xfs_inode         586780
> > linvfs_icache 243791    linvfs_icache     586807
> > dentry_cache  196033    dentry_cache      430609
>
> xfs has some known bad slab behavior. I think punting this in the
> direction of xfs mailing lists may be useful.
>
OK, interesting! - I will do that.

> On Tue, Aug 24, 2004 at 11:30:15AM +0200, Anders Saaby wrote:
> > The server crashed every night at approx. 03:00 to 04:00 - until last
> > night where we changed:
> > vm.min_free_kbytes from default (approx. 900K) to
> > vm.min_free_kbytes=32768 (32M)
> > This seems to solve the problem - Does this make any sense to you? - Or
> > just pure luck?
>
> I guess it makes some sense since it refuses to let slab cut into the
> very last bits of RAM. If you're getting temporarily heavily fragmented
> with active references it may mean the difference between the box
> livelocking/deadlocking and making forward progress.
>
Sounds right.

Thanks for your help! :-)

/Saaby

>
> -- wli
