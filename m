Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTKIPfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTKIPfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:35:20 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:15553 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262546AbTKIPfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:35:16 -0500
Date: Sun, 09 Nov 2003 07:34:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Davide Libenzi <davidel@xmailserver.org>,
       Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Message-ID: <121800000.1068392090@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0311081631300.2122-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0311081631300.2122-100000@bigblue.dev.mdolabs.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> prev_cpu_load[i] is nr_running of cpu i last time this operation was
>> performed. Either it, or the current nr_running is taken, whichever
>> is lower.
>> 
>> I guess its done this way for cache benefits, but it was correct as
>> Ingo intended. For example, with Con's patch you can see
>> rq_src->prev_cpu_load[i] will only ever use the ith position in the array.
> 
> Yes. The prev_cpu_load[] array takes a snapshot of the run queue lengths 
> seen by the current rq (this_rq). The code is ok as is, and the reason is 
> to avoid stealing tasks too fast from remote CPU (cache thing). Time ago I 
> also tried to store an K-average (by varying K) rq length in 
> prev_cpu_load[] instead of a simple min-of-two-values:
> 
> this_rq->prev_cpu_load[i] = (K * this_rq->prev_cpu_load[i] + rq_src->nr_running) / (K + 1);
> 
> I couldn't see any major improvements in my 2SMP (never tried on bigger SMP/NUMA).

I ran it on the 16-way - no difference in performance. If the code is 
correct as was before (and I agree, it seems it was), perhaps it's just
in need of a big fat comment to explain the confusion? ;-)

M.

