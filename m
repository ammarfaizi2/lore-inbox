Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267136AbSLREnT>; Tue, 17 Dec 2002 23:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSLREnT>; Tue, 17 Dec 2002 23:43:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54800 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267136AbSLREnS>; Tue, 17 Dec 2002 23:43:18 -0500
Date: Tue, 17 Dec 2002 20:52:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021218154023.29726d09.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0212172049410.1749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Dec 2002, Stephen Rothwell wrote:
>
> It would help to know what "unhappy" means :-)

Andrew reported an oops in the BIOS. I ahev the full oops info somewhere,
but quite frankly it isn't that readable. It shows

	EIP:    00b8:[<000044d7>]    Not tainted
	ds: 0000   es: 0000   ss: 0068
	Call Trace:
	 [<c0112739>] apm_bios_call+0x75/0xf4
	 [<c0130000>] cache_init_objs+0x34/0xd8
	 [<c0112b72>] apm_get_power_status+0x42/0x84
	 [<c012d843>] __alloc_pages+0x77/0x244
	 [<c0113828>] apm_get_info+0x38/0xe4
	 [<c016982d>] proc_file_read+0xa9/0x1ac
	 [<c0141b53>] vfs_read+0xb7/0x138
	 [<c0141dee>] sys_read+0x2a/0x40
	 [<c0108e67>] syscall_call+0x7/0xb

and I suspect the problem is that 0 in ds/es..

> Does the following fix it for you? Untested, assumes cache lines are 32
> bytes.

Andrew?

		Linus

