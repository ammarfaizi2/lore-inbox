Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUBDAJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUBDAJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:09:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:24971 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266222AbUBDAJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:09:30 -0500
Date: Tue, 3 Feb 2004 16:10:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call Trace: page allocation failure - is it normal behaviour?
Message-Id: <20040203161055.47596de4.akpm@osdl.org>
In-Reply-To: <200402031806.15439.gluk@php4.ru>
References: <200402031806.15439.gluk@php4.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander Y. Fomichev" <gluk@php4.ru> wrote:
>
> Hello,
> 
> I noticed some call trace when testing box under heavy load.
> To create a load following jobs have been running simultaneously.
> 
>  ab2 -c 200 -n 10000000 http://192.168.114.239/
>  fsx-linux -l 900000000 fsx-data3
>  dbench 100
> 
> adt root # w
>  19:24:32 up 14:58,  6 users,  load average: 90.92, 83.97, 84.28
> 
> Some times after dmesg has shown  multiple call traces of two types:
> 
> swapper: page allocation failure. order:2, mode:0x20
> Call Trace:
>  [<c014059c>] __alloc_pages+0x30c/0x350
>  [<c0140605>] __get_free_pages+0x25/0x40
>  [<c01435a7>] cache_grow+0xc7/0x310
>  [<c01438fe>] cache_alloc_refill+0x10e/0x2c0
>  [<c0143e01>] __kmalloc+0x71/0x80
>  [<c0266697>] alloc_skb+0x47/0xe0
>  [<c0294e7e>] tcp_fragment+0x5e/0x340
>  [<c02975b8>] tcp_write_wakeup+0xe8/0x280
>  [<c0298870>] tcp_write_timer+0x0/0x130
>  [<c029776d>] tcp_send_probe0+0x1d/0x110
>  [<c0298933>] tcp_write_timer+0xc3/0x130
>  [<c01298f7>] run_timer_softirq+0xe7/0x1d0
>  [<c0124e2a>] do_softirq+0xca/0xd0
>
>  ...
> bwt I've noticed no visible harm to system and question ruther is
> whether this behaviour is normal under such circumstances?

Yes, it is expected and the networking stack will recover.  We'll remove
that debug code at some point.

