Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbULIEzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbULIEzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 23:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbULIEzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 23:55:41 -0500
Received: from waste.org ([209.173.204.2]:60069 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261453AbULIEzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 23:55:36 -0500
Date: Wed, 8 Dec 2004 20:55:32 -0800
From: Matt Mackall <mpm@selenic.com>
To: andyliu <liudeyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209045532.GC12189@waste.org>
References: <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <aad1205e0412081846161b4dcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad1205e0412081846161b4dcd@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 10:46:30AM +0800, andyliu wrote:
> hi Ted
> 
>    i think this is better than use the spin lock.
>   but i think maybe there should put an #ifdef SMP :)
> just like
> 
> #ifdef CONFIG_SMP
>                tmp[0] = 0x67452301 ^ smp_processor_id();
>                tmp[1] = 0xefcdab89 ^ (__u32) current;
>                tmp[2] = 0x98badcfe ^ preempt_count();
> #endif
> 
> is it needed? 

The race can be hit with get_random_bytes on UP if we get
interrupted/preempted between hashing and mixing. Which is why
preempt_count is useful..

-- 
Mathematics is the supreme nostalgia of our time.
