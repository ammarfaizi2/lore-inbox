Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUJFRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUJFRtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJFRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:49:46 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36796 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269330AbUJFRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:49:27 -0400
Message-Id: <200410061749.i96Hn2606805@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: RE: [patch] sched: auto-tuning task-migration
Date: Wed, 6 Oct 2004 10:49:16 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSrqFViqFLr4cYXSpONAJAOMJOhzwAEO5mA
In-Reply-To: <20041006132930.GA1814@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Wednesday, October 06, 2004 6:30 AM
> the following patch adds a new feature to the scheduler: during bootup
> it measures migration costs and sets up cache_hot value accordingly.
>
> could you try this patch on your testbox and send me the bootlog? How
> close does this method get us to the 10 msec value you measured to be
> close to the best value? The patch is against 2.6.9-rc3 + the last
> cache_hot fixpatch you tried.

Ran it on a similar system.  Below is the output.  Haven't tried to get a
real benchmark run with 42 ms cache_hot_time.  I don't think it will get
peak throughput as we already start tapering off at 12.5 ms.

task migration cache decay timeout: 10 msecs.
CPU 1: base freq=199.458MHz, ITC ratio=15/2, ITC freq=1495.941MHz+/--1ppm
CPU 2: base freq=199.458MHz, ITC ratio=15/2, ITC freq=1495.941MHz+/--1ppm
CPU 3: base freq=199.458MHz, ITC ratio=15/2, ITC freq=1495.941MHz+/--1ppm
Calibrating delay loop... 2232.84 BogoMIPS (lpj=1089536)
Brought up 4 CPUs
Total of 4 processors activated (8939.60 BogoMIPS).
arch cache_decay_nsec: 10000000
migration cost matrix (cache_size: 9437184, cpu: 1500 MHz):
        [00]  [01]  [02]  [03]
[00]:   50.2  42.8  42.9  42.8
[01]:   42.9  50.2  42.1  42.9
[02]:   42.9  42.9  50.2  42.8
[03]:   42.9  42.9  42.9  50.2
min_delta: 44785782
using cache_decay nsec: 44785782 (42 msec)


