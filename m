Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSLQQlR>; Tue, 17 Dec 2002 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLQQlR>; Tue, 17 Dec 2002 11:41:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264625AbSLQQlR>; Tue, 17 Dec 2002 11:41:17 -0500
Date: Tue, 17 Dec 2002 08:50:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.44.0212170848120.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2002, dean gaudet wrote:
>
> don't many of the multi-CPU problems with tsc go away because you've got a
> per-cpu physical page for the vsyscall?

No.

The per-cpu page is _inside_ the kernel, and is only pointed at by the
SYSENTER_EIP_MSR, and not accessible from user space. It's not virtually
mapped to the same address at all.

The userspace vsyscall page is shared on the whole system, and has to be
so, because anything else is a disaster from a TLB standpoint (two threads
running on different CPU's have the same page tables, so it's basically
impossible to sanely do per-cpu TLB mappings with a hw-filled TLB like the
x86).

		Linus

