Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268910AbTGOQsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268898AbTGOQsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:48:35 -0400
Received: from kogut2.o2.pl ([212.126.20.58]:48610 "EHLO kogut2.o2.pl")
	by vger.kernel.org with ESMTP id S268911AbTGOQsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:48:00 -0400
Date: Tue, 15 Jul 2003 10:23:39 +0200
From: Rafal Bujnowski <bujnor@go2.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] kernel BUG at kernel/timer.c 2.6.0-test1
Message-Id: <20030715102339.1ff31f77.bujnor@go2.pl>
Organization: bujnor.lan
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Debian GNU/Linux 3.0
X-Registered-Linux-User: 203781
X-Website: http://www.bujnor.iq.pl/
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have something like that in my kernel-log. I had the same on 2.5.75.
It happens during cd burning (cd audio).



 kernel: ------------[ cut here ]------------
 kernel: kernel BUG at kernel/timer.c:166!
 kernel: invalid operand: 0000 [#1]
 kernel: CPU:    0
 kernel: EIP:    0060:[add_timer+151/176]    Not tainted
 kernel: EFLAGS: 00010002
 kernel: EIP is at add_timer+0x97/0xb0
 kernel: eax: 00000001   ebx: e3c74000   ecx: c0361b00   edx: c040470c
 kernel: esi: 00000000   edi: e3cee2a4   ebp: e3c75ed0   esp: e3c75ebc
 kernel: ds: 007b   es: 007b   ss: 0068
 kernel: Process scsi_eh_0 (pid: 9, threadinfo=e3c74000 task=e3ccc680)
 kernel: Stack: 00000046 00000032 e3c74000 00000000 c040470c e3c75f00
c02755a7 e3cee2a4
 kernel:        c0274f80 00000032 00000000 e3cee280 c0404660 00000096
00000000 c040470c
 bujnor kernel:        c040471c e3c75f10 c02755e9 c040470c 00000000
e3c75f30 c0290f1f c040470c
 kernel: Call Trace:
 kernel:  [do_reset1+567/608] do_reset1+0x237/0x260
 kernel:  [atapi_reset_pollfunc+0/288] atapi_reset_pollfunc+0x0/0x120
 kernel:  [ide_do_reset+25/32] ide_do_reset+0x19/0x20
 kernel:  [idescsi_reset+223/288] idescsi_reset+0xdf/0x120
 kernel:  [scsi_try_bus_device_reset+84/144]
scsi_try_bus_device_reset+0x54/0x90
 kernel:  [scsi_eh_bus_device_reset+102/288]
scsi_eh_bus_device_reset+0x66/0x120
 kernel:  [scsi_eh_ready_devs+40/112] scsi_eh_ready_devs+0x28/0x70
 kernel:  [scsi_unjam_host+192/208] scsi_unjam_host+0xc0/0xd0
 kernel:  [scsi_error_handler+218/288] scsi_error_handler+0xda/0x120
 kernel:  [scsi_error_handler+0/288] scsi_error_handler+0x0/0x120
 kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
 kernel:
 kernel: Code: 0f 0b a6 00 cb 38 31 c0 eb 8e eb 0d 90 90 90 90 90 90 90
90
 kernel:  <6>note: scsi_eh_0[9] exited with preempt_count 3
 kernel: hdc: ATAPI reset timed-out, status=0xd0
 kernel: hdd: DMA disabled


And from cdrecord 2.0:

Starting new track at sector: 0
Track 01:   50 of   50 MB written (fifo 100%) [buf  99%]   4.2x.
Track 01: Total bytes read/written: 53404512/53404512 (22706 sectors).
Starting new track at sector: 22858
Track 02:   29 of   31 MB written (fifo 100%) [buf  99%]  
4.2x.cdrecord: faio_wait_on_buffer for writer timed out.


Regards,

rafal


-- 

[              Rafal Bujnowski ][ e-mail: bujnor<at>go2.pl            ]
[     http://www.bujnor.iq.pl/ ][ e-mail: bujnor<at>poczta.onet.pl    ]
[   ICQ: 85602025  GG: 4174829 ][ Jabber: bujnor<at>jabberpl.org      ]
