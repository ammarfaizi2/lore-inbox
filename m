Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSKVTlL>; Fri, 22 Nov 2002 14:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSKVTlL>; Fri, 22 Nov 2002 14:41:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265247AbSKVTlK>; Fri, 22 Nov 2002 14:41:10 -0500
Date: Fri, 22 Nov 2002 11:47:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
In-Reply-To: <20021122162312.32ff4bd3.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Nov 2002, Stephen Rothwell wrote:
> 
> This patch merely adds include/asm-generic/compat32.h which is the header
> information that is common to all the 32 bit compatibility code across all
> the architectures (except parisc as I don't pretend to understand that
> :-)).

What kind of strange _crap_ is this?

	+typedef unsigned int           __kernel_size_t32;
	+typedef int                    __kernel_ssize_t32;
	+typedef int                    __kernel_time_t32;
	+typedef int                    __kernel_clock_t32;
	+typedef int                    __kernel_pid_t32;
	+typedef unsigned int           __kernel_ino_t32;
	+typedef int                    __kernel_daddr_t32;
	+typedef int                    __kernel_off_t32;
	+typedef unsigned int           __kernel_caddr_t32;
	+typedef long                   __kernel_loff_t32;

You're doing a compat layer, and then you're using various undefined types 
that can be random sizes, and calling them xxx_t32.

For christ sake, somebody is on drugs here.

If they are called "xxx_t32", then that means that you _know_ the size 
already statically, and you should use "u32" or "s32" which are shorter 
and clearer anyway. You should sure as hell not use some random C type 
that can be different depending on compiler options etc, and then calling 
it a "compat" library.

Quite frankly, I don't see the point of this AT ALL. You're introducing 
new types that cannot be sanely used directly anyway. What's the point?

Make your compat stuff use u32/s32/u64 directly, instead of making up ugly 
new types that make no sense.

		Linus

