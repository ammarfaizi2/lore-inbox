Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVAZI6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVAZI6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVAZI6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:58:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:13502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262398AbVAZI6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:58:49 -0500
Date: Wed, 26 Jan 2005 00:58:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050126005844.6880d195.akpm@osdl.org>
In-Reply-To: <20050126084743.GD2751@suse.de>
References: <20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<1106528219.867.22.camel@boxen>
	<20050124204659.GB19242@suse.de>
	<20050124125649.35f3dafd.akpm@osdl.org>
	<Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
	<20050126080152.GA2751@suse.de>
	<20050126001113.30933eef.akpm@osdl.org>
	<20050126084005.GB2751@suse.de>
	<20050126004419.26aab4a5.akpm@osdl.org>
	<20050126084743.GD2751@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> This is my current situtation:
> 
> ...
>  axboe@wiggum:/home/axboe $ cat /proc/meminfo 
>  MemTotal:      1024992 kB
>  MemFree:          9768 kB
>  Buffers:         76664 kB
>  Cached:         328024 kB
>  SwapCached:          0 kB
>  Active:         534956 kB
>  Inactive:       224060 kB
>  HighTotal:           0 kB
>  HighFree:            0 kB
>  LowTotal:      1024992 kB
>  LowFree:          9768 kB
>  SwapTotal:           0 kB
>  SwapFree:            0 kB
>  Dirty:            1400 kB
>  Writeback:           0 kB
>  Mapped:         464232 kB
>  Slab:           225864 kB
>  CommitLimit:    512496 kB
>  Committed_AS:   773844 kB
>  PageTables:       8004 kB
>  VmallocTotal: 34359738367 kB
>  VmallocUsed:       644 kB
>  VmallocChunk: 34359737167 kB
>  HugePages_Total:     0
>  HugePages_Free:      0
>  Hugepagesize:     2048 kB

OK.  There's rather a lot of anonymous memory there - 700M on the LRU, 300M
pageache, 400M anon, 200M of slab.  You need some swapspace ;)

What are the symptoms?  Slow to load applications?  Lots of paging?  Poor
I/O speeds?
