Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVLaRm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVLaRm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVLaRm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:42:26 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:16291 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932109AbVLaRmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:42:25 -0500
Date: Sat, 31 Dec 2005 18:42:28 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231184228.508ecd7b@localhost>
In-Reply-To: <20051231182440.56863dd3@localhost>
References: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
	<20051231182440.56863dd3@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 18:24:40 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> You shouldn't use "the same exact numbers", you should try different
> args and see if you can reproduce the problem. Or maybe preemption
> make some difference... I'll try with PREEMPT enabled and see.

Ok, just tried with Complete Preemption: I can easly reproduce the
problem.

For example:

"./a.out 1000 & ./a.out 1239"

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5433 paolo     16   0  2396  324  252 R 50.3  0.1   0:34.67 a.out
 5434 paolo     16   0  2392  320  252 R 47.4  0.1   0:30.76 a.out
  265 root     -48  -5     0    0    0 S  0.6  0.0   0:00.68 IRQ 12
 5261 root      15   0  166m  16m 2844 S  0.6  3.3   0:04.81 X
 5349 paolo     15   0 86640  22m  15m S  0.6  4.5   0:01.36 konsole
 5344 paolo     15   0 98.8m  20m  12m S  0.3  4.1   0:01.64 kicker
 5444 paolo     18   0  4948 1520  412 R  0.3  0.3   0:00.05 dd

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-rt1 on x86_64
