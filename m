Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTGCMHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbTGCMHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:07:34 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:26563 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S265229AbTGCMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:07:30 -0400
Date: Thu, 3 Jul 2003 14:21:54 +0200 (CEST)
From: fcorneli@elis.ugent.be
X-X-Sender: fcorneli@tom.elis.UGent.be
To: linux-kernel@vger.kernel.org
Subject: ide-scsi BUG in 2.5.74
Message-ID: <Pine.LNX.4.44.0307031408560.1293-100000@tom.elis.UGent.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Look what dmesg had to say to me lately...
Maybe someone will find this dump useful.
Although it's not a plain vanilla kernel I'm running it should have 
nothing to do with my stuff (hehe).

Frank.

Linux version 2.5.74 (fcorneli@tom) (gcc version 3.2 20020903 (Red Hat 
Linux 8.0 3.2-7)) #1 Thu Jul 3 13:02:22 CEST 2003
.................................................................
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: CD-RW NR-9100A    Rev: 108A
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi-1 drive
.................................................................
hdc: lost interrupt
ide-scsi: abort called for 15253
bad: scheduling while atomic!
Call Trace:
 [<c0117103>] schedule+0x3df/0x3e4
 [<c0108053>] __down+0x91/0x108
 [<c0117158>] default_wake_function+0x0/0x2e
 [<c01171b7>] __wake_up_common+0x31/0x50
 [<c010827b>] __down_failed+0xb/0x14
 [<c028820b>] .text.lock.scsi_error+0x37/0x48
 [<c0287a62>] scsi_sleep_done+0x0/0x14
 [<c028dd69>] idescsi_abort+0xf1/0xfa
 [<c02873fd>] scsi_try_to_abort_cmd+0x65/0x80
 [<c0287524>] scsi_eh_abort_cmds+0x40/0x74
 [<c0287ecb>] scsi_unjam_host+0xa5/0xcc
 [<c0287fbe>] scsi_error_handler+0xcc/0x10a
 [<c0287ef2>] scsi_error_handler+0x0/0x10a
 [<c01072a5>] kernel_thread_helper+0x5/0xc

ide-scsi: abort called for 15252
ide-scsi: reset called for 15253
hdc: DMA disabled
------------[ cut here ]------------
kernel BUG at drivers/scsi/ide-scsi.c:493!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c028cf59>]    Not tainted
EFLAGS: 00010282
EIP is at idescsi_transfer_pc+0xa5/0x12c
eax: c0272e1a   ebx: c048acf4   ecx: 237c30a0   edx: 00000172
esi: eaf0ef40   edi: f7d66fb0   ebp: f7d2fdfc   esp: f7d2fdd8
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 9, threadinfo=f7d2e000 task=f7da8710)
Stack: 00000172 c048acf4 00000008 00000080 0000001e f7d66fb0 c048acf4 
f7cd7180
       00000000 f7d2fe28 c026f217 c048acf4 eaf0ef40 00000000 00000088 
0000001e
       00000001 f7cd7180 c048acf4 c048ac48 f7d2fe5c c026f566 c048acf4 
f7cd7180
Call Trace:
 [<c026f217>] start_request+0x177/0x286
 [<c026f566>] ide_do_request+0x21a/0x3be
 [<c026fd38>] ide_do_drive_cmd+0xd4/0x128
 [<c028d825>] idescsi_queue+0x1e7/0x63a
 [<c02870c6>] scsi_send_eh_cmnd+0xaa/0x178
 [<c0286fd2>] scsi_eh_done+0x0/0x4a
 [<c0286fb0>] scsi_eh_times_out+0x0/0x22
 [<c02874ac>] scsi_eh_tur+0x94/0xcc
 [<c02876db>] scsi_eh_bus_device_reset+0xef/0x118
 [<c0287d6a>] scsi_eh_ready_devs+0x28/0x74
 [<c0287ee8>] scsi_unjam_host+0xc2/0xcc
 [<c0287fbe>] scsi_error_handler+0xcc/0x10a
 [<c0287ef2>] scsi_error_handler+0x0/0x10a
 [<c01072a5>] kernel_thread_helper+0x5/0xc

Code: 0f 0b ed 01 be 38 39 c0 8b 56 38 a1 80 00 3d c0 89 d1 29 c1
 hdc: ATAPI reset complete
hdc: status error: status=0x08 { DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x80 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete

