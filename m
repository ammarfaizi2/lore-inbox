Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUKORDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUKORDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUKORDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:03:24 -0500
Received: from no-dns-yet.demon.co.uk ([83.104.125.164]:9226 "EHLO
	toxic.bogusmove.com") by vger.kernel.org with ESMTP id S261641AbUKORDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:03:08 -0500
From: "Michael Wright" <michael@bogusmove.com>
To: <linux-kernel@vger.kernel.org>, <dlw@althea.taco.com>
Subject: Re: Kernel BUG from Compaq cpqfc driver
Date: Mon, 15 Nov 2004 17:04:40 -0000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAA0WFpTHk8EC/z0UkhenP2sKAAAAQAAAA9R2befaKtUWM+myVf2netgEAAAAA@bogusmove.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTLNTGgQIw9I22OTcei3RkdxZzk6w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In trying to ressurect an old Compaq FC array, I tried
> to use the cpqfc driver. I managed to compile the driver
> without trouble, but when modprobing it, I get
> the following:
> 
**** SNIP - kernel bug crash output stuff ****
> 
> As you can see, the card actually makes it out to the SAN to find
devices...
> 
> The kernel, in this case is from SLES9, and has the following uname..
> 
> Linux sles-test 2.6.5-7.97-default #1 Fri Jul 2 14:21:59 UTC 2004 i686
athlon i386 GNU/Linux
> 
> cpqfc is compiled as a module.
> 
> 
> Thank you for your help,
> 
> Dan Weigert

I have the same. The driver will load without crashing
if it can't see the disk array, but as soon as you attach
the array, it falls over.

It is because the driver doesn't work with the 2.6 kernel
I suspect. I resorted to a 2.4 kernel and it works fine...
Bit of a drag but you can probably get it going the same
way.

Mike.


PS My crash was as follows if anyone is interested:

My own kernel, cos cpqfc isn't included by default, server is a dual cpu
Compaq DL580.

Nov 11 11:23:48 HOSTNAME kernel: cpqfcTS: New FC port 000001h WWN:
500508B10004D5D0 SCSI Chan/Trgt 0/0
Nov 11 11:23:49 HOSTNAME kernel: ------------[ cut here ]------------
Nov 11 11:23:49 HOSTNAME kernel: kernel BUG at
drivers/scsi/scsi_scan.c:1323!
Nov 11 11:23:49 HOSTNAME kernel: invalid operand: 0000 [#1]
Nov 11 11:23:49 HOSTNAME kernel: SMP
Nov 11 11:23:49 HOSTNAME kernel: CPU:    1
Nov 11 11:23:49 HOSTNAME kernel: EIP:    0060:[<a283c985>]    Not tainted
Nov 11 11:23:49 HOSTNAME kernel: EFLAGS: 00010213   (2.6.5-1.358custom)
Nov 11 11:23:49 HOSTNAME kernel: EIP is at scsi_free_host_dev+0x10/0x42
[scsi_mod]
Nov 11 11:23:49 HOSTNAME kernel: eax: ffffffff   ebx: 9b8a2400   ecx:
a14e8980   edx: 96120000
Nov 11 11:23:49 HOSTNAME kernel: esi: 95f51b00   edi: 39ec050c   ebp:
961201e0   esp: 95f53e6c
Nov 11 11:23:49 HOSTNAME kernel: ds: 007b   es: 007b   ss: 0068
Nov 11 11:23:49 HOSTNAME kernel: Process cpqfcTS_wt_0 (pid: 2100,
threadinfo=95f53000 task=9bbbeb70)
Nov 11 11:23:49 HOSTNAME kernel: Stack: 39ec0400 a2b76d0d 9b8a2400 95f2031c
00000000 95f53fc0 95f20310 96120000
Nov 11 11:23:49 HOSTNAME kernel:        961201e4 a2b7556a 95f20000 00000004
95fc0000 961201e0 93f53063 00000000
Nov 11 11:23:49 HOSTNAME kernel:        fffebcaf 994eccf0 00000000 04429ce0
00400100 9cd0b080 95f53f18 00000000
Nov 11 11:23:49 HOSTNAME kernel: Call Trace:
Nov 11 11:23:49 HOSTNAME kernel:  [<a2b76d0d>]
IssueReportLunsCommand+0x13c/0x144 [cpqfc]
Nov 11 11:23:49 HOSTNAME kernel:  [<a2b7556a>] cpqfcTS_WorkTask+0x1e4/0x469
[cpqfc]
Nov 11 11:23:49 HOSTNAME kernel:  [<0229fcef>] schedule+0x4bf/0x523
Nov 11 11:23:49 HOSTNAME kernel:  [<0211b4b3>] __wake_up_locked+0xf/0x11
Nov 11 11:23:49 HOSTNAME kernel:  [<0211b419>] default_wake_function+0x0/0xc
Nov 11 11:23:49 HOSTNAME kernel:  [<a2b752d4>]
cpqfcTSWorkerThread+0x1b4/0x1fa [cpqfc]
Nov 11 11:23:49 HOSTNAME kernel:  [<a2b75120>] cpqfcTSWorkerThread+0x0/0x1fa
[cpqfc]
Nov 11 11:23:49 HOSTNAME kernel:  [<021041f1>] kernel_thread_helper+0x5/0xb
Nov 11 11:23:49 HOSTNAME kernel:
Nov 11 11:23:49 HOSTNAME kernel: Code: 0f 0b 2b 05 96 4a 84 a2 8b 42 64 8b
50 40 85 d2 74 04 89 d8
Nov 11 11:23:51 HOSTNAME kernel:  <6>scsi0 : Compaq FibreChannel HBA Tachyon
TS HPFC-5166A/1.2: WWN 500508B2001CA6D0
Nov 11 11:23:51 HOSTNAME kernel:  on PCI bus 7 device 0xa0fc irq 74 IObaseL
0x6000, MEMBASE 0xf7fe0000
Nov 11 11:23:51 HOSTNAME kernel: PCI bus width 64 bits, bus speed 66 MHz
Nov 11 11:23:51 HOSTNAME kernel: FCP-SCSI Driver v2.5.4
Nov 11 11:23:51 HOSTNAME kernel: GBIC detected: Short-wave.  LPSM 0h Monitor
Nov 11 11:23:52 HOSTNAME kernel: cpqfcTS: New FC port 000001h WWN:
500508B10004B140 SCSI Chan/Trgt 0/0
Nov 11 11:23:53 HOSTNAME kernel: ------------[ cut here ]------------
Nov 11 11:23:53 HOSTNAME kernel: kernel BUG at
drivers/scsi/scsi_scan.c:1323!
Nov 11 11:23:53 HOSTNAME kernel: invalid operand: 0000 [#2]
Nov 11 11:23:53 HOSTNAME kernel: SMP
Nov 11 11:23:53 HOSTNAME kernel: CPU:    1
Nov 11 11:23:53 HOSTNAME kernel: EIP:    0060:[<a283c985>]    Not tainted
Nov 11 11:23:53 HOSTNAME kernel: EFLAGS: 00010213   (2.6.5-1.358custom)
Nov 11 11:23:53 HOSTNAME kernel: EIP is at scsi_free_host_dev+0x10/0x42
[scsi_mod]
Nov 11 11:23:53 HOSTNAME kernel: eax: ffffffff   ebx: 994f4000   ecx:
a14e8980   edx: 9c2c6000
Nov 11 11:23:53 HOSTNAME kernel: esi: 95f51b00   edi: a14fe30c   ebp:
9c2c61e0   esp: 95f55e6c
Nov 11 11:23:53 HOSTNAME kernel: ds: 007b   es: 007b   ss: 0068
Nov 11 11:23:53 HOSTNAME kernel: Process cpqfcTS_wt_1 (pid: 2102,
threadinfo=95f55000 task=9bbbf110)
Nov 11 11:23:53 HOSTNAME kernel: Stack: a14fe200 a2b76d0d 994f4000 95ec031c
00000000 95f55fc0 95ec0310 9c2c6000
Nov 11 11:23:53 HOSTNAME kernel:        9c2c61e4 a2b7556a 95ec0000 00000004
95ee0000 9c2c61e0 93f55063 00000000
Nov 11 11:23:53 HOSTNAME kernel:        0427eaa0 00000001 02383200 00000001
a1fa13a0 9bbbf110 a1fa1110 00000000
Nov 11 11:23:53 HOSTNAME kernel: Call Trace:
Nov 11 11:23:53 HOSTNAME kernel:  [<a2b76d0d>]
IssueReportLunsCommand+0x13c/0x144 [cpqfc]
Nov 11 11:23:53 HOSTNAME kernel:  [<a2b7556a>] cpqfcTS_WorkTask+0x1e4/0x469
[cpqfc]
Nov 11 11:23:53 HOSTNAME kernel:  [<0229fcc1>] schedule+0x491/0x523
Nov 11 11:23:53 HOSTNAME kernel:  [<0211b4b3>] __wake_up_locked+0xf/0x11
Nov 11 11:23:53 HOSTNAME kernel:  [<0211b419>] default_wake_function+0x0/0xc
Nov 11 11:23:53 HOSTNAME kernel:  [<a2b752d4>]
cpqfcTSWorkerThread+0x1b4/0x1fa [cpqfc]
Nov 11 11:23:53 HOSTNAME kernel:  [<a2b75120>] cpqfcTSWorkerThread+0x0/0x1fa
[cpqfc]
Nov 11 11:23:54 HOSTNAME kernel:  [<021041f1>] kernel_thread_helper+0x5/0xb
Nov 11 11:23:54 HOSTNAME kernel:
Nov 11 11:23:54 HOSTNAME kernel: Code: 0f 0b 2b 05 96 4a 84 a2 8b 42 64 8b
50 40 85 d2 74 04 89 d8
Nov 11 11:23:57 HOSTNAME kernel:   @Linux _abort Scsi_Cmnd 95f51080 in
BoardLockCmnd Q
Nov 11 11:23:57 HOSTNAME kernel: scsi: Device offlined - not ready after
error recovery: host 0 channel 0 id 0 lun 0
Nov 11 11:23:57 HOSTNAME kernel: scsi1 : Compaq FibreChannel HBA Tachyon TS
HPFC-5166A/1.2: WWN 500508B2001CA020
Nov 11 11:23:57 HOSTNAME kernel:  on PCI bus 7 device 0xa0fc irq 90 IObaseL
0x6800, MEMBASE 0xf7fd0000
Nov 11 11:23:57 HOSTNAME kernel: PCI bus width 64 bits, bus speed 66 MHz
Nov 11 11:23:57 HOSTNAME kernel: FCP-SCSI Driver v2.5.4
Nov 11 11:23:57 HOSTNAME kernel: GBIC detected: Short-wave.  LPSM 0h Monitor
Nov 11 11:24:03 HOSTNAME kernel:  @Linux _abort Scsi_Cmnd 95f51080 in
BoardLockCmnd Q
Nov 11 11:24:03 HOSTNAME kernel: scsi: Device offlined - not ready after
error recovery: host 1 channel 0 id 0 lun 0

