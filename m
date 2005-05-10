Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVEJMfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVEJMfD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEJMfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:35:02 -0400
Received: from general.keba.co.at ([193.154.24.243]:42809 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261625AbVEJMe5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:34:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Real-Time Preemption: BUG initializing kgdb
Date: Tue, 10 May 2005 14:34:54 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323209@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Real-Time Preemption: BUG initializing kgdb
Thread-Index: AcVUn9unJLMCbvBBS9CZcwNpJSH1sAAu3f4w
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Lee Revell" <rlrevell@joe-job.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to merge the kgdb and the rt patches (not too difficult, only
three rejects, and they all look trivial). The resulting kernel
compiles, boots, and works fine.

However, kgdb initialization generates a BUG, and kgdb does not work at
all (gdb on the host is unable to connect to the target, and Alt-SysRq-g
has no effect).

The bug:

May 10 15:56:46 OF455 kern.notice kernel: Linux version
2.6.12-rc3-RT-V0.7.46-02 (kk@silver) (gcc version 3.4.3) #3 Tue May 10
13:41:59 CEST 2005

 ...

May 10 15:56:46 OF455 kern.warn kernel: kgdb <20030915.1651.33> : port
=2e8, IRQ=5, divisor =1
May 10 15:56:46 OF455 kern.err kernel: BUG: scheduling while atomic:
swapper/0x00000001/1
May 10 15:56:46 OF455 kern.warn kernel: caller is schedule+0x102/0x110
May 10 15:56:46 OF455 kern.warn kernel:  [<c0102f29>]
dump_stack+0x17/0x19 (12)
May 10 15:56:46 OF455 kern.warn kernel:  [<c025de85>]
__schedule+0xa5/0x633 (88)
May 10 15:56:46 OF455 kern.warn kernel:  [<c025e515>]
schedule+0x102/0x110 (36)
May 10 15:56:46 OF455 kern.warn kernel:  [<c025e671>]
wait_for_completion+0x86/0xbd (84)
May 10 15:56:46 OF455 kern.warn kernel:  [<c01262eb>]
kthread_create+0x118/0x146 (208)
May 10 15:56:46 OF455 kern.warn kernel:  [<c012be97>]
start_irq_thread+0x42/0x77 (32)
May 10 15:56:46 OF455 kern.warn kernel:  [<c012ba57>]
setup_irq+0x51/0x12f (28)
May 10 15:56:46 OF455 kern.warn kernel:  [<c012bc9e>]
request_irq+0x86/0x9f (24)
May 10 15:56:46 OF455 kern.warn kernel:  [<c01a0b73>]
kgdb_enable_ints_now+0x76/0xae (16)
May 10 15:56:46 OF455 kern.warn kernel:  [<c02d26e7>]
kgdb_enable_ints+0x38/0x3f (8)
May 10 15:56:46 OF455 kern.warn kernel:  [<c02c47ff>]
do_initcalls+0x62/0xb3 (32)
May 10 15:56:46 OF455 kern.warn kernel:  [<c02c4871>]
do_basic_setup+0x21/0x23 (8)
May 10 15:56:46 OF455 kern.warn kernel:  [<c01002cd>] init+0x32/0xfd
(20)
May 10 15:56:46 OF455 kern.warn kernel:  [<c0100c21>]
kernel_thread_helper+0x5/0xb (1055084564)

 ...

This is with RT-V0.7.46-02 and the kgdb patchset from -rc3-mm3.

Any hints or suggestions?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
