Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVCaA37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVCaA37 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVCaA36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:29:58 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:7890 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262464AbVCaA3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:29:36 -0500
Subject: 2.6.12-rc1-RT-V0.7.41-15: it_real_fn oops on boot in
	run_timer_softirq
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 19:29:30 -0500
Message-Id: <1112228970.19975.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.12-rc1-RT something I get this Oops on boot about 50% of the
time.  It's clearly some kind of race because if I just reboot again it
works.  Seems to happen shortly after ksoftirqd startup (maybe the first
time we hit the timer softirq?).

This is (lazily) hand copied and incomplete, but hopefully is enough
info...

EIP is at it_real_fn+0x2f/0x70
eax 0 ebx df9020f0  ecx 1 edx c0019b49
esi 0 edi "       " ebp dffd5f44 esp  dffd5f34
ds 7b es 7b ss 68 preempt 1
process ksoftirqd/0, pid 2, tid dffd4000, task dffd1110

call trace
 show_stack
 show_registers
 die
 do_page_fault
 error_code
 run_timer_softirq
 ___do_softirq
 _do_softirq
 ksoftirqd
 kthread
 kthread_helper

Lee

