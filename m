Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSLREHF>; Tue, 17 Dec 2002 23:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSLREHE>; Tue, 17 Dec 2002 23:07:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28430 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267047AbSLREHA>; Tue, 17 Dec 2002 23:07:00 -0500
Date: Tue, 17 Dec 2002 20:15:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171159440.1095-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171716020.1362-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Dec 2002, Linus Torvalds wrote:
>
> How about this diff? It does both the 6-parameter thing _and_ the
> AT_SYSINFO addition.

The 6-parameter thing is broken. It's clever, but playing games with %ebp
is not going to work with restarting of the system call - we need to
restart with the proper %ebp.

I pushed out the AT_SYSINFO stuff, but we're back to the "needs to use
'int $0x80' for system calls that take 6 arguments" drawing board.

The only sane way I see to fix the %ebp problem is to actually expand the
kernel "struct ptregs" to have separate "ebp" and "arg6" fields (so that
we can re-start with the right ebp, and have arg6 as the right argument on
the stack). That would work but is not really worth it.

		Linus


