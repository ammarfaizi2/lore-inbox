Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269488AbUJFU6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269488AbUJFU6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUJFU4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:56:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269488AbUJFUva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:51:30 -0400
Date: Wed, 6 Oct 2004 16:50:56 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Andrew Morton'" <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: RE: Default cache_hot_time value back to 10ms
In-Reply-To: <200410062038.i96KcJ608221@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0410061643160.20121@devserv.devel.redhat.com>
References: <200410062038.i96KcJ608221@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Oct 2004, Chen, Kenneth W wrote:

> Let me try to persuade ;-).  First, it hard to accept the fact that we
> are leaving 11% of performance on the table just due to a poorly chosen
> parameter. This much percentage difference on a db workload is a huge
> deal.  It basically "unfairly" handicap 2.6 kernel behind competition,
> even handicap ourselves compare to 2.4 kernel.  We have established from
> various workloads that 10 ms works the best, from db to java workload.  
> What more data can we provide to swing you in that direction?

the problem is that 10 msec might be fine for a 9MB L2 cache CPU running a
DB benchmark, but it will sure be too much of a migration cutoff for other
boxes. And too much of a migration cutoff means increased idle time -
resulting in CPU-under-utilization and worse performance.

so i'd prefer to not touch it for 2.6.9 (consider that tree closed from a
scheduler POV), and we can do the auto-tuning in 2.6.10 just fine. It will
need the same weeks-long testcycle that all scheduler balancing patches
need. There are so many different type of workloads ...

> Secondly, let me ask the question again from the first mail thread:  
> this value *WAS* 10 ms for a long time, before the domain scheduler.  
> What's so special about domain scheduler that all the sudden this
> parameter get changed to 2.5? I'd like to see some justification/prior
> measurement for such change when domain scheduler kicks in.

iirc it was tweaked as a result of the other bug that you fixed. But, high
sensitivity to this tunable was nevery truly established, and a 9 MB L2
cache CPU is certainly not typical - and it is certainly the one that
hurts most from migration effects.

anyway, we were running based on cache_decay_ticks for a long time - is
that what was 10 msec on your box? The cache_decay_ticks calculation was
pretty fine too, it scaled up with cachesize.

	Ingo
