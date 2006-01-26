Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWAZFaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWAZFaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAZFaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:30:00 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:30134 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750763AbWAZFaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:30:00 -0500
Message-ID: <43D85E56.8040201@bigpond.net.au>
Date: Thu, 26 Jan 2006 16:29:58 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [BUG]  Invalid sleeping function call in 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 26 Jan 2006 05:29:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error report early during system start up:

Jan 26 16:18:54 origma kernel: [17179569.184000] BUG: sleeping function 
called from invalid context at 
/mudlark/wrk/KERNELS/Linux/MM-2.6.X/kernel/mutex.c:259
Jan 26 16:18:54 origma kernel: [17179569.184000] in_atomic():0, 
irqs_disabled():1
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c010648d>] 
show_trace+0xd/0x10
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c01064a7>] 
dump_stack+0x17/0x20
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c011eacc>] 
__might_sleep+0x8c/0xa0
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c02ce2a5>] 
mutex_lock_interruptible+0x15/0x30
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c01413ec>] 
__lock_cpu_hotplug+0x4c/0x60
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c014140d>] 
lock_cpu_hotplug_interruptible+0xd/0x10
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c0141504>] 
register_cpu_notifier+0x14/0x40
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c03f1dad>] 
page_alloc_init+0xd/0x10
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c03de3ac>] 
start_kernel+0x13c/0x3f0
Jan 26 16:18:54 origma kernel: [17179569.184000]  [<c0100210>] 0xc0100210

The message appears just the once and no similar messages have been 
seen.  It is repeatable.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
