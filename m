Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282525AbRLBAAw>; Sat, 1 Dec 2001 19:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282508AbRLBAAm>; Sat, 1 Dec 2001 19:00:42 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:52236 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282509AbRLBAAa>; Sat, 1 Dec 2001 19:00:30 -0500
Date: Sat, 1 Dec 2001 16:11:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: kumon@flab.fujitsu.co.jp
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <200112012350.IAA03884@asami.proc.flab.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.40.0112011604260.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001 kumon@flab.fujitsu.co.jp wrote:

> Davide Libenzi writes:
>  > On Sat, 1 Dec 2001, Alan Cox wrote:
>  > > Because it is much much much faster
>  >
>  > We'll see how much faster is the global register allocation against code
>  > like :
>  >
>  > movl %esp, %eax
>  > andl $-8192, %eax
>  > movl (%eax), %eax
>
> Current should be much faster, if it is accessed very frequently.
> If the frequency is high, the value is very likely being kept on L1
> cache. If that's true, the access time is fast enough.
> So, using indirection doesn't cause large penalty.
>
> Apart from that, stack coloring is difficult. Recent CPUs use much
> larger cache block, coloring needs big room in the stack area.
> Pentium4 is said using 64B block, but actually it is sectored cache
> within 128B block.
> 1KB room for stack coloring realizes only 8 colors.

true, that's why I'm using the Manfred idea of a separate allocation of
task structs through a slab allocator ( with task struct pointer stored at
stack base ) + init stack pointer jittering.
true even that with 128 bytes you'll get 8 colors in 1Kb, but 8 colors are
about 1/8 collision.




- Davide


