Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbTEGXmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTEGXmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:42:35 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42719 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264200AbTEGXlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:41:50 -0400
Date: Wed, 07 May 2003 14:40:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 675] New: kernel dies in sighandler when installing a game in winex3 
Message-ID: <17990000.1052343610@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=675

           Summary: kernel dies in sighandler when installing a game in
                    winex3
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: jmm@informatik.uni-bremen.de


Distribution: Debian GNU/Linux testing with certain components from sid

Hardware Environment: Athlon Thunderbird XP 1700+ on Elitegroup K7-S5A-LAN,
Sony DVD-ROM DDU 1211. dmesg and lspci -vvvv available at
http://www.informatik.uni-bremen.de/~jmm/idecdbug-69.txt

Software Environment: Kernel 2.5.69 without additional patches, winex 3.0
.config available at http://www.informatik.uni-bremen.de/~jmm/idecdbug-69.txt

Problem Description: When installing the Windows game "Star Trek Voyager:
Elite Force" in winex 3.0 the kernel dies in the interrupt handler. This
is reproducable. The oops msg:

kernel BUG at drivers/ide/ide-cd.c:2990!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c035bcc6>]    Tainted: G S
EFLAGS: 00010286
EIP is at ide_cdrom_prep_fs+0xc6/0xd0
eax: ffffffff   ebx: dfd6d540   ecx: 001f8d68   edx: 00000000
esi: fffa289c   edi: ffffffff   ebp: c0503e20   esp: c0503e00
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0502000 task=c045bc80)
Stack: c055ed40 001f1933 c0503e38 00000004 0007e35a c5b467a0 dfd6d540 c34b4d00
       c0503e3c c03593ab c056315c dfd6d540 dfd6d540 c056314c dfe0a800 c0503e5c
       c03593ec dfd6d540 c0503e54 c02b65b4 00000000 00082ed8 00000000 c0503e84
Call Trace:       
 [<c03593ab>] restore_request+0xab/0xc0
 [<c03593ec>] cdrom_start_read+0x2c/0xc0
 [<c02b65b4>] __delay+0x14/0x20
 [<c035a2e5>] ide_do_rw_cdrom+0xa5/0x1c0
 [<c03499e7>] start_request+0x107/0x160
 [<c0349c6d>] ide_do_request+0x1fd/0x3a0
 [<c034a021>] ide_timer_expiry+0x141/0x260
 [<c034ddb0>] atapi_reset_pollfunc+0x0/0x120
 [<c0349ee0>] ide_timer_expiry+0x0/0x260
 [<c012949e>] run_timer_softirq+0xde/0x1c0
 [<c0124f8b>] do_softirq+0xcb/0xd0
 [<c0116487>] smp_apic_timer_interrupt+0xd7/0x140
 [<c01070c0>] default_idle+0x0/0x40
 [<c0109f4a>] apic_timer_interrupt+0x1a/0x20
 [<c01070c0>] default_idle+0x0/0x40
 [<c01070f0>] default_idle+0x30/0x40
 [<c010717b>] cpu_idle+0x3b/0x50
 [<c0105000>] _stext+0x0/0x70
 [<c05048c5>] start_kernel+0x165/0x180
 [<c05044a0>] unknown_bootoption+0x0/0x100

Code: 0f 0b ae 0b bd 7c 42 c0 eb 81 55 89 e5 53 8b 5d 08 0f b6 43
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


Steps to reproduce:
1. Mount the "Elite Force" CD-ROM
2. $ winex3 /cdrom/Setup.exe
3. Select "Install"
4. After a few seconds the system freezes


