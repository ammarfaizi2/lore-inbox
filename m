Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULFIaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULFIaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULFIaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:30:39 -0500
Received: from nacho.alt.net ([207.14.113.18]:15822 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S261358AbULFIa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:30:28 -0500
Date: Mon, 6 Dec 2004 00:30:24 -0800 (PST)
To: Jason Stubbs <jstubbs@work-at.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Message-ID: <Pine.LNX.4.44.0412060009400.30663-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you ever find a solution to the following?

I am seeing something similar in 2.6.9 and 2.6.9-ac12.  Mine shows up as:

  Pid: 12647, comm:                   sh
  EIP: 0060:[<c02ebfa8>] CPU: 0
  EIP is at _spin_lock+0x37/0x74
  EFLAGS: 00000246    Not tainted  (2.6.9-ac12)
  EAX: 00000000 EBX: 00000000 ECX: c0336680 EDX: c03f7000
  ESI: c0389680 EDI: ffffffff EBP: c03f7fc4 DS: 007b ES: 007b
  CR0: 8005003b CR2: b7fd6f68 CR3: 25542000 CR4: 000006d0
  Stack pointer is garbage, not printing trace

or:

  Pid: 3053, comm:                   sh
  EIP: 0060:[<c02ea6df>] CPU: 0
  EIP is at _spin_lock+0x3a/0x74
  EFLAGS: 00000246    Not tainted  (2.6.9)
  EAX: 00000000 EBX: 00000000 ECX: c0335680 EDX: c03f5000
  ESI: c0388680 EDI: ffffffff EBP: c03f5fc4 DS: 007b ES: 007b
  CR0: 8005003b CR2: b7fd6f68 CR3: 1300a000 CR4: 000006d0
  Stack pointer is garbage, not printing trace

CPUs are dual Intel Xeon 3.06ghz 533mhz FSB 512k ECC cache (both are CPUID
F29).  Hyperthreading is enabled.  Microcode updates as follows:

  microcode: CPU2 updated from revision 0x22 to 0x2d, date = 08112004
  microcode: CPU1 updated from revision 0x22 to 0x2d, date = 08112004
  microcode: CPU3 updated from revision 0x22 to 0x2d, date = 08112004
  microcode: CPU0 updated from revision 0x22 to 0x2d, date = 08112004

Chris

---

From	Jason Stubbs <>
Subject	PROBLEM: Consistent lock up on >=2.6.8
Date	Mon, 4 Oct 2004 16:11:16 +0900

Hi,

I'm getting consistent hangs under heavy load on 2.6.8.1, 2.6.9-rc2 and
2.6.9-rc3. I have tested on 2.6.7 and have no problems at all. I can
reproduce the problem in less than 10 minutes by repeatedly running a cpu
intensive process such as openssl while the system performs its regular
tasks.

SysRq works and I was able to pull the registers (which are always very
similar) and the last 50 lines of the task list. If more of the task list
is necessary, I'll go out and buy a serial cable to get it. All
information provided is from 2.6.9-rc3.

Regards,
Jason Stubbs


========================================
Pid: 22433, comm:              openssl
EIP: 0060:[<c02d5082>] CPU: 0
EIP is at _spin_lock+0xa/0x13
 EFLAGS: 00000286    Not tainted  (2.6.9-rc3)
EAX: c03b2500 EBX: 00000000 ECX: x031ca80 EDX: 00000000
ESI: f8b9c926 EDI: ffffffff EBP: c03e1f44 DS: 007b ES: 007b
CR0: 8005003b CR2: b7df91df CR3: 3705c000 CR4: 000006d0
Stack pointer is garbage, not printing trace
[...]

