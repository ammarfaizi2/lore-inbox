Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVJUQbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVJUQbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVJUQbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:31:04 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:10649 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965021AbVJUQbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:31:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ufVtnxib8U6i4RsrWthgvPUJtWiH74NPaHvJQiZ9yencLZzyXhaK85ztnJoEeggQIlbGtwyAsVqL916CvdpTCWvzRH/MADTBOZq7ThG+DdGMXc0UfM+SJ50YbvJMQOz2OZFNIbC88R6GlHAv7wspiKIj74c4OjgvffPNVvU5Kvk=
Message-ID: <5bdc1c8b0510210931h1fad38e1v1f0fecf28e3ddb3d@mail.gmail.com>
Date: Fri, 21 Oct 2005 09:31:03 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: -rc5-rt3 - IRQoff tracing numbers still reflect timer? (AMD64?)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
   I want to ensure I understand the status of the kernel right now.
When I enable

[*] Interrupts-off critical section latency timing

I immediately see values as shown below. I think that this is the
timer, which I have set to 1000HZ and not a rela latency. Is that
correct?

   If my understanding is correct then is there someone that can spend
some time and look into this? Is this an x86_64 issue only?

Thanks,
Mark


( softirq-timer/0-3    |#0): new 998 us maximum-latency critical section.
 => started at timestamp 286541291: <acpi_processor_idle+0x20/0x379>
 =>   ended at timestamp 286542289: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014e19c>{check_critical_timing+492}
<ffffffff8014e5f5>{sub_preempt_count_ti+133}
       <ffffffff803ff43c>{thread_return+70}
<ffffffff803ff4ab>{thread_return+181}
       <ffffffff803ff615>{schedule+261} <ffffffff801379aa>{ksoftirqd+138}
       <ffffffff80137920>{ksoftirqd+0} <ffffffff80147bfd>{kthread+205}
       <ffffffff8010e70e>{child_rip+8} <ffffffff80147b30>{kthread+0}
       <ffffffff8010e706>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803feef8>] .... __schedule+0xb8/0x5b6
.....[<00000000>] ..   ( <= _stext+0x7feff0e8/0xe8)

 =>   dump-end timestamp 286542378

lightning ~ #
