Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSKUAUF>; Wed, 20 Nov 2002 19:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSKUAUE>; Wed, 20 Nov 2002 19:20:04 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:56970 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265382AbSKUAUD>;
	Wed, 20 Nov 2002 19:20:03 -0500
Date: Thu, 21 Nov 2002 00:28:16 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021121002816.GC12650@bjl1.asuk.net>
References: <20021120235135.GA32715@mark.mielke.cc> <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201546250.974-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> typedef union epoll_obj {
> 	void *ptr;
> 	__uint32_t u32[2];
> 	__uint64_t u64;
> } epoll_obj_t;
> 
> I'm open to suggestions though. The "ptr" enable me to avoid wierd casts
> to avoid gcc screaming.

That makes more sense to me, because it will be fine to use `ptr' even
on 128-bit pointer machines when they arrive, yet preserves the
property that 64<->32 bit conversion functions don't need to reformat
the buffer when running 32-bit applications on a 64-bit CPU... even if
the 32-bit application uses the `ptr' field.

Did I just write that? :)

-- Jamie
