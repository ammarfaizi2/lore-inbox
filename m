Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTE1FSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTE1FSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:18:52 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:36261 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264516AbTE1FSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:18:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 15:33:08 +1000
User-Agent: KMail/1.5.1
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de>
In-Reply-To: <200305271954.11635.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305281533.08524.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 04:04, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 19:50, manish wrote:
>
> Hi Manish,
>
> > It is not a system hang but the processes hang showing the same stack
> > trace. This is certainly not a pause since the bonnie processes that
> > were hung (or deadlocked) never completed after several hrs. The stack
> > trace  was the same.
>
> then you are hitting a different bug or a bug related to the issues
> Christian Klose and me and $tons of others were complaining.
>
> The bug you are hitting might be the problem with "process stuck in D
> state" Andrea Arcangeli fixed, let me guess, over half a year ago or so.
>
> In case you have a good mind to try to address your issue, you might want
> to try out the patch you can find here:
>
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2
>aa1/9980_fix-pausing-2
>
> ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is
> dead/: speak _NOW_ please, doesn't matter who you are!

Yo!

I'll throw my babushka into the ring too. I think it's obvious from MCP's 
comments that I've been involved in testing this problem. I've spent hours, 
possibly days trying to find a way to fix the pauses introduced since 
2.4.19pre1. I agree with what MCP describes that the machine can come to a 
standstill under any sort of disk i/o and is unusable for a variable length 
of time. I've been playing with all sorts of numbers in my patchset to try 
and limit it with only mild success. The best results I've had without a 
major decrease in throughput was using akpm's read latency 2 patch but by 
significantly reducing the nr_requests. It was changing the number of 
requests that I discovered dropping them to 4 fixed the problem but destroyed 
write throughput. I was pleased to see AA give the problem recognition after 
my contest results on his kernel but disappointed that the problem only was 
reduced, not fixed.

I have seen it on every piece of hardware I have used a 2.4.19+ kernel on 
using the desktop. I have no idea what the real problem is, but I firmly 
believe with MCP that it is the biggest flaw in 2.4 on the desktop (no idea 
what it does to servers). We've tried over and over again fiddling with the 
numbers and patches and only going to less than 2.4.19 fixes it completely.

Con
