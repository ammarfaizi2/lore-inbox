Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUIYLv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUIYLv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUIYLv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:51:56 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49299 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269284AbUIYLvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:51:53 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040925014546.200828E71E@voldemort.scrye.com>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
Content-Type: text/plain
Message-Id: <1096113235.5937.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 21:53:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 11:45, Kevin Fenzi wrote:
> Nigel> The problem isn't really that you're out of memory. Rather, the
> Nigel> memory is so fragmented that swsusp is unable to get an order 8
> Nigel> allocation in which to store its metadata. There isn't really
> Nigel> anything you can do to avoid this issue apart from eating
> Nigel> memory (which swsusp is doing anyway).
> 
> Odd. I have never run into this before with either swsusp2 or
> swsusp1. 

You won't run into it with suspend2 because it doesn't use high order
allocations. There might be one exception, but apart from that, all of
suspend2's data is stored in order zero allocated pages, so
fragmentation is not an issue. This is the real solution to the problem.
I had to do it this way because I aim to have suspend work without
eating any memory.

> What causes memory to be so fragmented? 

Normal usage; the pattern of pages being freed and allocated inevitably
leads to fragmentation. The buddy allocator does a good job of
minimising it, but what is really needed is a run-time defragmenter. I
saw mention of this recently, but it's probably not that practical to
implement IMHO.

> Nothing can be done to prevent it?

Apart from the above, no, sorry.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

