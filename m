Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWIMSKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWIMSKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWIMSKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:10:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:33494 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750972AbWIMSKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:10:41 -0400
Subject: BUG: warning at kernel/lockdep.c:581/print_infinite_recursion_bug()
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu, arjan@infradead.org
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 13 Sep 2006 11:10:36 -0700
Message-Id: <1158171036.5683.7.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I was booting 2.6.18-rc6-mm2 with some various lock debug config
options on and I tripped over this during boot.  The system is i386
summit. 


BUG: warning at kernel/lockdep.c:581/print_infinite_recursion_bug()
 [<c1004de9>] dump_trace+0x63/0x1ca
 [<c1004f62>] show_trace_log_lvl+0x12/0x25
 [<c10054d2>] show_trace+0xd/0x10
 [<c100558c>] dump_stack+0x16/0x18
 [<c103c15d>] print_infinite_recursion_bug+0x32/0x39
 [<c103c18b>] find_usage_backwards+0x27/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c1bf>] find_usage_backwards+0x5b/0x80
 [<c103c7b8>] check_usage+0x25/0x1fb
 [<c103d4b0>] __lock_acquire+0x81f/0x96c
 [<c103db21>] lock_acquire+0x45/0x64
 [<c12134fb>] _spin_lock+0x19/0x28
 [<c101ef98>] double_rq_lock+0x26/0x2a
 [<c10205c5>] rebalance_tick+0x17a/0x2c2
 [<c1020a17>] scheduler_tick+0x30a/0x322
 [<c102e336>] update_process_times+0x57/0x63
 [<c1017dd3>] smp_apic_timer_interrupt+0x70/0x79
 [<c100493b>] apic_timer_interrupt+0x33/0x38
DWARF2 unwinder stuck at apic_timer_interrupt+0x33/0x38

Leftover inexact backtrace:

 [<c1002c25>] cpu_idle+0xa6/0xbf
 [<c1016efd>] start_secondary+0x3ce/0x3d9
 [<00000000>] 0x0
 [<f7d95fb0>] 0xf7d95fb0
 =======================

Any ideas?  What debug info is needed to sort this locking bug out?


Thanks,
  Keith 


