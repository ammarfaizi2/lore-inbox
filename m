Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUACBWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUACBWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:22:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:3223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265880AbUACBWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:22:45 -0500
Date: Fri, 2 Jan 2004 17:23:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Calin Szonyi <caszonyi@rdslink.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problem with 2.6.0
Message-Id: <20040102172340.130f75ba.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401030252510.5448@grinch.ro>
References: <Pine.LNX.4.53.0312271912350.511@grinch.ro>
	<20031227194144.54d052d1.akpm@osdl.org>
	<Pine.LNX.4.53.0401010559330.687@grinch.ro>
	<20040101020406.4bbb2fdd.akpm@osdl.org>
	<Pine.LNX.4.53.0401030252510.5448@grinch.ro>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

caszonyi@rdslink.ro wrote:
>
> see atached file


> mplayer: page allocation failure. order:1, mode:0x21
> Call Trace:
>  [<c013a3fc>] __alloc_pages+0x30c/0x350
>  [<c013a45f>] __get_free_pages+0x1f/0x50
>  [<c036fd5d>] sound_alloc_dmap+0x9d/0x1a0
>  [<c0377ec0>] ad_mute+0x20/0x40
>  [<c0370116>] open_dmap+0x26/0x100
>  [<c0370554>] DMAbuf_open+0x174/0x1a0
>  [<c036e0c2>] audio_open+0xc2/0x250
>  [<c036d2e4>] sound_open+0xf4/0x120
>  [<c036c5b5>] soundcore_open+0x1e5/0x330
>  [<c036c3d0>] soundcore_open+0x0/0x330
>  [<c015c3e8>] chrdev_open+0xe8/0x210
>  [<c0161fdc>] open_namei+0xac/0x3f0
>  [<c015c300>] chrdev_open+0x0/0x210
>  [<c0152425>] dentry_open+0x145/0x210
>  [<c01522d8>] filp_open+0x68/0x70
>  [<c015276b>] sys_open+0x5b/0x90
>  [<c0109367>] syscall_call+0x7/0xb
> 
> Sound error: Couldn't allocate DMA buffer
> esd: page allocation failure. order:4, mode:0x21
> Call Trace:
>  [<c013a3fc>] __alloc_pages+0x30c/0x350
>  [<c013a45f>] __get_free_pages+0x1f/0x50
>  [<c036fd5d>] sound_alloc_dmap+0x9d/0x1a0
>  [<c0377ec0>] ad_mute+0x20/0x40
>  [<c0370116>] open_dmap+0x26/0x100
>  [<c0370554>] DMAbuf_open+0x174/0x1a0
>  [<c036e0c2>] audio_open+0xc2/0x250
>  [<c036d2e4>] sound_open+0xf4/0x120
>  [<c036c5b5>] soundcore_open+0x1e5/0x330
>  [<c036c3d0>] soundcore_open+0x0/0x330
>  [<c015c3e8>] chrdev_open+0xe8/0x210
>  [<c0161fdc>] open_namei+0xac/0x3f0
>  [<c015c300>] chrdev_open+0x0/0x210
>  [<c0152425>] dentry_open+0x145/0x210
>  [<c01522d8>] filp_open+0x68/0x70
>  [<c015276b>] sys_open+0x5b/0x90
>  [<c0109367>] syscall_call+0x7/0xb

sound_alloc_dmap() is trying to perform a 4-order GFP_ATOMIC allocation.

There is just nothing the MM system can do about that - it is a basic
design problem in that part of the OSS sound system.

I'm not sure what to suggest - development and maintenance of OSS seems to
have come to a stop.

Can you use ALSA instead?  If not, increasing /proc/sys/vm/min_free_kbytes
by quite a lot will probably decrease the frequency at which this occurs.

