Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSLUP7D>; Sat, 21 Dec 2002 10:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLUP7D>; Sat, 21 Dec 2002 10:59:03 -0500
Received: from [217.13.199.129] ([217.13.199.129]:51589 "EHLO
	server1.netdiscount.de") by vger.kernel.org with ESMTP
	id <S261644AbSLUP7C>; Sat, 21 Dec 2002 10:59:02 -0500
Date: Sat, 21 Dec 2002 17:07:06 +0100
From: Christian Leber <christian@leber.de>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021221160706.GA26838@core.home>
References: <Pine.LNX.4.44.0212170850250.2702-100000@home.transmeta.com> <3E0006D2.3000907@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <3E0006D2.3000907@quark.didntduck.org>
User-Agent: Mutt/1.4i
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 12:25:38AM -0500, Brian Gerst wrote:

> How about this patch?  Instead of making a per-cpu trampoline, write to 
> the msr during each context switch.  This means that the stack pointer 
> is valid at all times, and also saves memory and a cache line bounce.  I 
> also included some misc cleanups.

Just a little bit of benchmarking:
(little testprogram by Linus out of this thread)
(on a AMD Duron 750)

2.5.52-bk2+sysenter-1 (Brian Gerst):
igor3:~# ./a.out
187.894946 cycles    (call 0xfffff000)
299.155075 cycles    (int $0x80)

2.5.52-bk6:
igor3:~# ./a.out
202.134535 cycles    (call 0xffffe000)
299.117583 cycles    (int $0x80)

Not really much, but the difference is there. (I don't about other side
effects)


Christian Leber

