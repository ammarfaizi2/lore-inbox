Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbULAIfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbULAIfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULAIfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:35:43 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:54288 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261338AbULAIfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:35:36 -0500
Message-ID: <41AD8122.4070108@mrv.com>
Date: Wed, 01 Dec 2004 10:30:26 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41ACB846.40400@free.fr> <20041130081548.GA8707@elte.hu>
In-Reply-To: <20041130081548.GA8707@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> 
> fixed this in -V0.7.31-14.
> 
> 	Ingo
>  This mail arrived via mail.mrv.com
> 
> 

Compiling -V0.7.31-15 without CONFIG_LATENCY_TRACE results in:
...
   CC      kernel/latency.o
kernel/latency.c: In function `check_critical_timing':
kernel/latency.c:765: warning: implicit declaration of function `__trace'
...
   LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1e407): In function `check_critical_timing':
: undefined reference to `__trace'
make: *** [.tmp_vmlinux1] Error 1

Seems to be fixed by the patch below:

--- kernel/latency.c.orig       2004-12-01 10:21:45.000000000 +0200
+++ kernel/latency.c    2004-12-01 10:11:37.000000000 +0200
@@ -762,7 +762,9 @@
         tr->critical_sequence = max_sequence;
         tr->preempt_timestamp = cycles();
         tr->early_warning = 0;
+#ifdef CONFIG_LATENCY_TRACE
         __trace(CALLER_ADDR0, parent_eip);
+#endif
  }

  void notrace touch_critical_timing(void)
-- 
Eran Mann
