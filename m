Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVDAWcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVDAWcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVDAWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:32:45 -0500
Received: from fmr23.intel.com ([143.183.121.15]:2270 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262923AbVDAWcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:32:43 -0500
Message-Id: <200504012232.j31MWTg03706@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Paul Jackson" <pj@engr.sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, <torvalds@osdl.org>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Fri, 1 Apr 2005 14:32:29 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU2hpI4DBtAhluHSq2CnpbfwQ4YswAgdy1Q
In-Reply-To: <20050401064611.GA26203@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Thursday, March 31, 2005 10:46 PM
> before we get into complexities, i'd like to see whether it solves Ken's
> performance problem. The attached patch (against BK-curr, but should
> apply to vanilla 2.6.12-rc1 too) adds the autodetection feature. (For
> ia64 i've hacked in a cachesize of 9MB for Ken's testsystem.)

Very nice, it had a good estimate of 9ms on my test system.  Our historical
data showed that 12ms was the best on the same system for the db workload
(that was done on 2.6.8).  Scheduler dynamic has changed in 2.6.11 and this
old finding may not apply any more for the new kernel.

migration cost matrix (cache_size: 9437184, cpu: 1500 MHz):
        [00]  [01]  [02]  [03]
[00]:    9.1   8.5   8.5   8.5
[01]:    8.5   9.1   8.5   8.5
[02]:    8.5   8.5   9.1   8.5
[03]:    8.5   8.5   8.5   9.1
min_delta: 8908106
using cache_decay nsec: 8908106 (8 msec)


Paul, you definitely want to check this out on your large numa box.  I booted
a kernel with this patch on a 32-way numa box and it took a long .... time
to produce the cost matrix.


