Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVKVCog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVKVCog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVKVCog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:44:36 -0500
Received: from koto.vergenet.net ([210.128.90.7]:39820 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S964878AbVKVCof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:44:35 -0500
From: Horms <horms@verge.net.au>
To: Karol Lewandowski <klz@o2.pl>, 340228@bugs.debian.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH, IDE] Blacklist CD-912E/ATK
In-Reply-To: <E1EeJoy-0001LS-DG__45201.7337469899$1132611644$gmane$org@iglo.domek.prywatny>
X-Newsgroups: gmane.linux.debian.devel.kernel
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.14-1-686-smp (i686))
Message-Id: <20051122024426.8C16A34043@koto.vergenet.net>
Date: Tue, 22 Nov 2005 11:44:26 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    URL: http://bugs.debian.org/340228
    From: Karol Lewandowski <klz@o2.pl>
    
    Package: kernel-image-2.6.8-2-k7
    Version: 2.6.8-16
    Severity: important
    
    Linux kernel 2.6.(everything) panics when mounting cdrom when DMA
    transfers are enabled (default).  It works fine if DMA is disabled.
    
    The drive is clearly broken.  Adding blacklist to drivers/ide/ide-dma.c
    for this model ("CD-912E/ATK") fixes this problem.
    
    Messages gathered on panic condition:
    
    --- Begin kernel messages ---
    
    ide-cd: cmd 0x28 timed out
    hdc: DMA interrupt recovery
    hdc: lost interrupt
    hdc: cdrom_decode_status: status=0xd0 { Busy }
    ide: failed opcode was: unknown
    hdc: DMA disabled
    ------------[ cut here ]------------
    kernel BUG at drivers/ide/ide-iops.c:949!
    invalid operand: 0000 [#1]
    Modules linked in:
    CPU:    0
    EIP:    0060:[<c01ece82>]    Not tainted VLI
    EFLAGS: 00010086   (2.6.14-eve1)
    EIP is at ide_execute_command+0x22/0x90
    eax: c01ecef0   ebx: c02fed38   ecx: 00008000   edx: c3f81580
    esi: c02feca8   edi: 00000286   ebp: c01f9000   esp: c02c7e50
    ds: 007b   es: 007b   ss: 0068
    Process swapper (pid: 0, threadinfo=c02c6000 task=c028eba0)
    Stack: 00000082 00808000 c01179e5 a00ce600 c10ce600 c02fed38 c02feca8 c01f8869
    c02fed38 000000a0 c01f9000 00001770 c01f86e0 c10d8ec4 c02fed38 c10d8ec4
    c10ce600 00000004 c01f938a c02fed38 00008000 c01f9000 c02fed38 c10d8ec4
    Call Trace:
    [<c01179e5>] update_process_times+0x85/0x130
    [<c01f8869>] cdrom_start_packet_command+0x119/0x1a0
    [<c01f9000>] cdrom_start_read_continuation+0x0/0xb0
    [<c01f86e0>] cdrom_timer_expiry+0x0/0x70
    [<c01f938a>] cdrom_start_read+0xca/0xd0
    [<c01f9000>] cdrom_start_read_continuation+0x0/0xb0
    [<c01fa075>] ide_do_rw_cdrom+0x95/0x1b0
    [<c01eb1b6>] start_request+0x156/0x240
    [<c01eb4fa>] ide_do_request+0x22a/0x380
    [<c01eb867>] ide_timer_expiry+0xd7/0x1c0
    [<c01eb790>] ide_timer_expiry+0x0/0x1c0
    [<c0117b66>] run_timer_softirq+0xb6/0x1b0
    [<c0113deb>] __do_softirq+0x7b/0x90
    [<c0113e26>] do_softirq+0x26/0x30
    [<c010415e>] do_IRQ+0x1e/0x30
    [<c0102a46>] common_interrupt+0x1a/0x20
    [<c0100920>] default_idle+0x0/0x30
    [<c0100943>] default_idle+0x23/0x30
    [<c01009e0>] cpu_idle+0x50/0x60
    [<c02c87f6>] start_kernel+0x146/0x170
    [<c02c8380>] unknown_bootoption+0x0/0x1e0
    Code: c3 90 8d b4 26 00 00 00 00 57 56 53 83 ec 10 8b 5c 24 20 0f b6 44 24 24 88 44 24 0f 8b 73 6c 8b 56 08 9c 5f fa 8b 02 85 c0 74 08 <0f> 0b b5 03 9c 08 27 c0 8b 44 24 28 89 02 8b 44 24 30 89 82 dc
    <0>Kernel panic - not syncing: Fatal exception in interrupt
    
    --- End ---
    
    Thanks, I'm forwarding the patch you suggest to the IDE maintainers for
    consideration. It seems to apply to current 2.6 head as well
    as the somewhat ancient 2.6.8.
    
    Signed-off-by: Horms <horms@verge.net.au>

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 1e15313..e430717 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -126,6 +126,7 @@ static const struct drive_list_entry dri
 	{ "HITACHI CDR-8435"	,	"ALL"		},
 	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
 	{ "CD-532E-A"		,	"ALL"		},
+	{ "CD-912E/ATK"		,	"ALL"		},
 	{ "E-IDE CD-ROM CR-840",	"ALL"		},
 	{ "CD-ROM Drive/F5A",	"ALL"		},
 	{ "WPI CDD-820",		"ALL"		},
