Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbUKECM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbUKECM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUKECM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:12:58 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:17074 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262586AbUKECMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:12:20 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.11 (oops)
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041104195206.GB11672@elte.hu>
References: <OF88A40911.ECF57E25-ON86256F42.006C01DC-86256F42.006C0216@raytheon.com>
	 <20041104195206.GB11672@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1099620674.3137.98.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Nov 2004 18:11:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this on my athlon64 test machine with V0.7.11:

Freeing unused kernel memory: 208k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
IRQ#8 thread RT prio: 44.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
BUG: Unable to handle kernel paging request at virtual address f888d940
 printing eip:
c0229153
*pde = 37f40067
Oops: 0002 [#1]
PREEMPT 
Modules linked in: video(U) container(U) button(U) battery(U) ac(U)
ext3(U) jbd(U) raid5(U) xor(U) sata_via(U) sata_promise(U) libata(U)
sd_mod(U) scsi_mod(U)
CPU:    0
EIP:    0060:[<c0229153>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-1.520.1rV0.7.11.ll.rhfc2.ccrma) 
EIP is at acpi_bus_register_driver+0x40/0x63
eax: f888d940   ebx: f88960c0   ecx: c013ef0b   edx: 00000002
esi: 00000000   edi: 00000000   ebp: f68a3f94   esp: f68a3f8c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process insmod (pid: 1012, threadinfo=f68a2000 task=f688a000)
Stack: c03ba660 f8896680 f68a3fa0 f887e039 f88960c0 f68a3fbc c0144ec9
c049a5a4 
       00000001 f8896680 0807a018 00000000 f68a2000 c01072a1 0807a018
00004ad4 
       0807a008 00000000 00000000 bfffced8 00000080 0000007b 0000007b
00000080 
Call Trace:
 [<c010811f>] show_stack+0x8f/0xb0 (28)
 [<c01082da>] show_registers+0x16a/0x1d0 (56)
 [<c01084f1>] die+0xf1/0x190 (64)
 [<c011de39>] do_page_fault+0x369/0x660 (216)
 [<c0107d21>] error_code+0x2d/0x38 (76)
 [<f887e039>] acpi_video_init+0x39/0x59 [video] (12)
 [<c0144ec9>] sys_init_module+0x169/0x220 (28)
 [<c01072a1>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c010843e>] .... die+0x3e/0x190
.....[<c011de39>] ..   ( <= do_page_fault+0x369/0x660)
.. [<c0140c9d>] .... print_traces+0x1d/0x60
.....[<c010811f>] ..   ( <= show_stack+0x8f/0xb0)

Code: b8 ed ff ff ff eb 42 85 db b8 ea ff ff ff 74 39 68 60 a6 3b c0 e8
de 5d f1 ff c7 03 1c a7 3b c0 a1 20 a7 3b c0 89 1d 20 a7 3b c0 <89> 18
89 43 04 c7 04 24 60 a6 3b c0 e8 7c 5e f1 ff 58 89 5d 08 
 insmod:1012 BUG: lock held at task exit time!
 [c03ba660] {drivers/acpi/scan.c:27}
.. held by:            insmod/ 1012 [f688a000, 118]
... acquired at:  acpi_bus_register_driver+0x2f/0x63
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 21, pci mem 0xcfffed00
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10

The machine can boot single user. Kudzu hangs (but I can reboot with
ctrl-alt-del), if I disable kudzu it does not make it to X. Apparently
hangs, cannot reboot of do anything. With "acpi=off" it hangs after
(apparently) loading sata_via, responds to ctrl-alt-del. 

-- Fernando


