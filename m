Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVDCN14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDCN14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVDCN14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 09:27:56 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:6509 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261724AbVDCN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:27:54 -0400
Message-ID: <424FEF51.9020104@yahoo.com.au>
Date: Sun, 03 Apr 2005 23:27:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] optimise resched, idle task
References: <424E11C6.8090702@yahoo.com.au>
In-Reply-To: <424E11C6.8090702@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> This actually improves performance noticably (ie. a % or so) on schedule /
> wakeup happy benchmarks (tbench, on a dual Xeon with HT using mwait idle).
> 

Here are some numbers on a 2 socket Xeon with HT and mwait idle.

Average of 3 runs, tbench, single client and single server processes on:
		samethread	samecpu		othercpu
before patch:   188.684 MB/s    189.237 MB/s    172.306 MB/s
after patch :   188.425 MB/s    191.628 MB/s    174.224 MB/s

The improvement on other CPUs should be due to the removal of
RMW operations in resched_task.

