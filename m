Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVBUHxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVBUHxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVBUHxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:53:40 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:29660 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261912AbVBUHxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:53:23 -0500
Message-ID: <421993A2.4020308@ak.jp.nec.com>
Date: Mon, 21 Feb 2005 16:54:10 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@sgi.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org>
In-Reply-To: <20050218171610.757ba9c9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone.

Andrew Morton wrote:
 > Jay Lan <jlan@sgi.com> wrote:
 >
 >>Since the need of Linux system accounting has gone beyond what BSD
 >>accounting provides, i think it is a good idea to create a thin layer
 >>of common code for various accounting packages, such as BSD accounting,
 >>CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
 >>a routine in the common code which would then invoke those accounting
 >>packages that register to the acct_common to handle do_exit situation.
 >
 >
 > This all seems to be heading in the wrong direction.  Do we really want to
 > have lots of different system accounting packages all hooking into a
 > generic we-cant-decide-what-to-do-so-we-added-some-pointless-overhead
 > framework?
 >
 > Can't we get _one_ accounting system in there, get it right, avoid the
 > framework?

I think there are two issues about system accounting framework.

Issue: 1) How to define the appropriate unit for accounting ?
Current BSD-accountiong make a collection per process accounting information.
CSA make additionally a collection per process-aggregation accounting.

It is appropriate to make the fork-exit event handling framework for definition
of the process-aggregation, such as PAGG.

This system-accounting per process-aggregation is quite useful,
thought I tried the SGI's implementation named 'job' in past days.


Issue: 2) What items should be collected for accounting information ?
BSD-accounting collects PID/UID/GID, User/Sys/Elapsed-Time, and # of
minor/major page faults. SGI's CSA collects VM/RSS size on exit time,
Integral-VM/RSS, and amount of block-I/O additionally.

I think it's hard to implement the accounting-engine as a kernel loadable
module using any kinds of framework. Because, we must put callback functions
into all around the kernel for this purpose.

Thus, I make a proposion as follows:
We should separate the process-aggregation functionality and collecting
accounting informations.
Something of framework to implement process-aggregation is necessary.
And, making a collection of accounting information should be merged
into BSD-accounting and implemented as a part of monolithic kernel
as Guillaume said.

Thanks.
-- 
Linux Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
