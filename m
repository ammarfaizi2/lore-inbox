Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUCGGjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCGGjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:39:37 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:17508 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261766AbUCGGje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:39:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ben Collins <bcollins@debian.org>
Subject: OOPS when copying data from local to an external drive (ieee1394)
Date: Sun, 7 Mar 2004 01:39:30 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403070139.30268.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I started getting oopses when cpying data from local IDE to an external
Firewire drive. Not always, but quite often. The kernel is a bk pull a
day before 2.6.4-rc2 was released, I do not see any ieee1394 updates
since.

Unfortunately the oops was not saves in the logs, so here is what I managed
to write down:

Oops: 00002 [#1]
PREEMPT
CPU: 0
EIP: 0060 [<c0243d087>] Tainted: P
EFLAGS: 00010047
EIP is at hpsb_packet_sent+0x86/0x90
eax: 00100100 ebx: dfd74000 ecx: dd6edfb0 edx: 00200200
esi: 00000001 edi: dd6cdf60 ebp: c03e3ee0 esp: c03c3edc
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0; threadinfo=c03c2000, task=c034a800)
....
Call trace:
[<co25306e>] dma_trm_tasklet+0xae/0x1b0
recal_task_prio+0xb4/0x1f0
tasklet_action
do_softirq
do_IRQ
common_interrupt
acpi_process_idle
default_idle
rest_init
default_init
rest_init
cpu_idle
start_kernel
unknown_bootparam

Code: ...
Kernel panic: Fatal exception in interrupt
In interrupt handler - not synching


This OOPS is with NVIDIA module loaded but I have seen exactly the
same trace without the module loaded.

-- 
Dmitry
