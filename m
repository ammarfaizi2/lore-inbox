Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTLXJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 04:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTLXJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 04:21:59 -0500
Received: from [62.29.72.212] ([62.29.72.212]:7040 "EHLO southpark.com")
	by vger.kernel.org with ESMTP id S263479AbTLXJV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 04:21:57 -0500
From: "ismail 'cartman' =?utf-8?q?d=C3=B6nmez?=" <kde@myrealbox.com>
Reply-To: kde@myrealbox.com
Organization: Bogazici University
To: linux-kernel@vger.kernel.org
Subject: PPP ooopses on 2.6.0-mm1
Date: Wed, 24 Dec 2003 11:21:56 +0200
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200312241121.56934.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is what I get from syslog :


Dec 24 11:09:51 southpark kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000065
Dec 24 11:09:51 southpark kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000065
Dec 24 11:09:51 southpark kernel:  printing eip:
Dec 24 11:09:51 southpark kernel: e500dfcb
Dec 24 11:09:51 southpark kernel: *pde = 00000000
Dec 24 11:09:51 southpark kernel: *pde = 00000000
Dec 24 11:09:51 southpark kernel: Oops: 0000 [#1]
Dec 24 11:09:51 southpark kernel: PREEMPT
Dec 24 11:09:51 southpark kernel: CPU:    0
Dec 24 11:09:51 southpark kernel: EIP:    0060:[_end+617343539/1070258792]    Not tainted VLI
Dec 24 11:09:51 southpark kernel: EFLAGS: 00010002
Dec 24 11:09:51 southpark kernel: EIP is at process_input_packet+0x6b/0x230 [ppp_async]
Dec 24 11:09:51 southpark kernel: eax: d5156c00   ebx: 0000007e   ecx: dae99310   edx: 00000000
Dec 24 11:09:51 southpark kernel: esi: 00000001   edi: dae99710   ebp: d5156c00   esp: e3f8dee8
Dec 24 11:09:51 southpark kernel: ds: 007b   es: 007b   ss: 0068
Dec 24 11:09:51 southpark kernel: Process events/0 (pid: 3, threadinfo=e3f8c000 task=c15cecc0)
Dec 24 11:09:51 southpark kernel: Stack: c02a151c c15cecc0 e3fedc28 dae990bc e3f8df70 0000007e 00000001 dae99710
Dec 24 11:09:51 southpark kernel:        00000002 e500e34c d5156c00 0000f18b c029fa60 e3f8c000 00000286 d5156c00
Dec 24 11:09:51 southpark kernel:        dae99000 e500d522 d5156c00 dae99310 dae99710 00000008 dae99000 00000008
Dec 24 11:09:51 southpark kernel: Call Trace:
Dec 24 11:09:51 southpark kernel:  [_end+617344436/1070258792] ppp_async_input+0x1bc/0x340 [ppp_async]
Dec 24 11:09:51 southpark kernel:  [_end+617340810/1070258792] ppp_asynctty_receive+0x52/0xd0 [ppp_async]
Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+156/272] flush_to_ldisc+0x9c/0x110
Dec 24 11:09:51 southpark kernel:  [worker_thread+477/720] worker_thread+0x1dd/0x2d0
Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+0/272] flush_to_ldisc+0x0/0x110
Dec 24 11:09:51 southpark kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 24 11:09:51 southpark kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Dec 24 11:09:51 southpark kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 24 11:09:51 southpark kernel:  [worker_thread+0/720] worker_thread+0x0/0x2d0
Dec 24 11:09:51 southpark kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Dec 24 11:09:51 southpark kernel:
Dec 24 11:09:51 southpark kernel: Code: 89 d0 c1 e8 08 32 13 43 0f b6 d2 0f b7 94 12 40 f3 00 e5 31 c2 49 75 e8 81 fa b8 f0 00 00 74 4e c7 45 08 04 00 00 00 85 f6 74 25 <8b> 4e 64 85 c9 74 1e 8b 56 68 85 d2 75 1f c7 46 64 00 00 00 00
Dec 24 11:09:51 southpark kernel:  <6>note: events/0[3] exited with preempt_count 1


This somehow freezes X too. Anyone seen similar problems?
-- 
Joe Random Hacker Since 2002
