Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282501AbRLAXvm>; Sat, 1 Dec 2001 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282498AbRLAXvc>; Sat, 1 Dec 2001 18:51:32 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63629 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S282502AbRLAXvU>; Sat, 1 Dec 2001 18:51:20 -0500
Date: Sun, 2 Dec 2001 08:50:50 +0900
Message-Id: <200112012350.IAA03884@asami.proc.flab.fujitsu.co.jp>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <Pine.LNX.4.40.0112011350120.1696-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <E16A6lc-0006cV-00@the-village.bc.nu>
	<Pine.LNX.4.40.0112011350120.1696-100000@blue1.dev.mcafeelabs.com>
Reply-To: kumon@flab.fujitsu.co.jp
From: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi writes:
 > On Sat, 1 Dec 2001, Alan Cox wrote:
 > > Because it is much much much faster
 > 
 > We'll see how much faster is the global register allocation against code
 > like :
 > 
 > movl %esp, %eax
 > andl $-8192, %eax
 > movl (%eax), %eax

Current should be much faster, if it is accessed very frequently.
If the frequency is high, the value is very likely being kept on L1
cache. If that's true, the access time is fast enough.
So, using indirection doesn't cause large penalty.

Apart from that, stack coloring is difficult. Recent CPUs use much
larger cache block, coloring needs big room in the stack area.
Pentium4 is said using 64B block, but actually it is sectored cache
within 128B block.
1KB room for stack coloring realizes only 8 colors.
--
Kouichi Kumon, Software Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
