Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUJFRMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUJFRMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJFRMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:12:52 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:1711 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S269390AbUJFREI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:04:08 -0400
Date: Wed, 6 Oct 2004 13:04:06 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: PANIC with 2.6.9-rc3-mm2
Message-ID: <Pine.LNX.4.60-041.0410061256310.2578@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting - while doing module dependency calculations - egrep seems 
to cause a panic in an interrupt handler (AIEE...), though no stack trace 
is given at the time.

System is uniprocessor Transmeta Crusoe 8500.

Via SysRq+t shows (copied by hand, apologies for errors):

PID 560, comm:		egrep
EIP 0060: [<c011d08b>] CPU: 0
EIP is at panic+0xab/0xb0
  EFLAGS: 00000246	Not tainted (2.6.9-rc3-mm2)
EAX: 00000000 EBX: d65d7ac0 ECX: c0442c40 EDX: 00000000
ESI: d661c000 EDI: d6b8a1b0 EBP: 0000000b DS: 007b ES: 007b
CR0: 8005003b CR2: b7f5fd25 CR3: 16658000 CR4: 00000010
[<c011fa7d>] do_exit + 0x33d/0x420
[<c011fbe5>] do_group_exit + 0x35/0xa0
[<c0128b06>] get_signal_to_deliver + 0x216/0x3a0
[<c0103dcf>] do_signal + 0x8f/0x170
[<c01183a0>] scheduler_tick + 0x20/0x7e0
[<c0112cfc>] smp_local_timer_interrupt + 0xc/0x50
[<c0109928>] timer_interrupt + 0x108/0x130
[<c0121fc0>] __do_softirq + 0x40/0x90
[<c01156bo>] do_page_fault + 0x0/0x5b5
[<c0103ee7>] do_notify_resume + 0x37/0x3c
[<c010405a>] work_notifysig + 0x13/0x15

Anybody have any ideas?  Would more information be helpful?
Note that I can't capture most things as I don't have a serial port on 
this hardware and can't scroll the console back after it dumps (so 
SysRq+P is not terribly useful).
