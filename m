Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUHXPn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUHXPn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUHXPn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:43:29 -0400
Received: from holomorphy.com ([207.189.100.168]:59523 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268047AbUHXPlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:41:36 -0400
Date: Tue, 24 Aug 2004 08:41:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anders Saaby <as@cohaesio.com>
Cc: linux-kernel@vger.kernel.org, joe@unthought.net,
       Gene Heskett <gene.heskett@verizon.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: oom-killer 2.6.8.1
Message-ID: <20040824154131.GM2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anders Saaby <as@cohaesio.com>, linux-kernel@vger.kernel.org,
	joe@unthought.net, Gene Heskett <gene.heskett@verizon.net>,
	Hugh Dickins <hugh@veritas.com>
References: <200408181455.42279.as@cohaesio.com> <200408181624.25131.as@cohaesio.com> <20040818211142.GH11200@holomorphy.com> <200408241130.15577.as@cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408241130.15577.as@cohaesio.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 11:30:15AM +0200, Anders Saaby wrote:
> OK - I now have some additional info regarding the slapinfo/oom-killer
> issue.
> As I wrote earlier this server is a storage server providing NFS storage to a 
> number of webservers - ondisk filesystem is xfs, kernel = 2.6.8.1. At 03:00 
> some logrotate scripts runs throug a lot of files. It appears that this is 
> what is using the slabs (see this graph, K = M, so max used slab is approx. 
> 700M) 
> http://saaby.com/slabused.gif (values are from /proc/meminfo)
> These are the values (from slabinfo, active_objs), which changed remarkably 
> from 03:00 to 06:00:
> 03:00:        06:00:
> xfs_chashlist  91297    xfs_chashlist     151994
> xfs_inode     243791    xfs_inode         586780
> linvfs_icache 243791    linvfs_icache     586807
> dentry_cache  196033    dentry_cache      430609

xfs has some known bad slab behavior. I think punting this in the
direction of xfs mailing lists may be useful.


On Tue, Aug 24, 2004 at 11:30:15AM +0200, Anders Saaby wrote:
> The server crashed every night at approx. 03:00 to 04:00 - until last night 
> where we changed:
> vm.min_free_kbytes from default (approx. 900K) to vm.min_free_kbytes=32768 
> (32M)
> This seems to solve the problem - Does this make any sense to you? - Or just 
> pure luck?

I guess it makes some sense since it refuses to let slab cut into the
very last bits of RAM. If you're getting temporarily heavily fragmented
with active references it may mean the difference between the box
livelocking/deadlocking and making forward progress.


-- wli
