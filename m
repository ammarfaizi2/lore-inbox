Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSF0TWY>; Thu, 27 Jun 2002 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSF0TWX>; Thu, 27 Jun 2002 15:22:23 -0400
Received: from io.iol.unh.edu ([132.177.123.82]:11218 "EHLO iol.unh.edu")
	by vger.kernel.org with ESMTP id <S316849AbSF0TWW>;
	Thu, 27 Jun 2002 15:22:22 -0400
Date: Thu, 27 Jun 2002 15:23:30 -0400 (EDT)
From: Chaoyang Deng <cdeng@io.iol.unh.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG
Message-ID: <Pine.LNX.4.43.0206271514230.9712-100000@io.iol.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on an iSCSI target driver with a Fibre Channel disk. After I
updated my OS to linux7.3 with kernel 2.4.18-3, I got problem: my driver
will crash my box. I am not sure if it is a bug in my code or in the
Qlogic Fibre Channel driver or in the kernel. Could anyone give me a hint?

The kernel log file is as following:

Jun 27 14:38:11 sierra kernel: ------------[ cut here ]------------
Jun 27 14:38:11 sierra kernel: kernel BUG at /usr/src/build/90234-i686/BUILD/kernel-2.4.18/linux/include/asm/pci.h:153!
Jun 27 14:38:11 sierra kernel: invalid operand: 0000
Jun 27 14:38:11 sierra kernel: iscsi_target scsi_target es1371 ac97_codec gameport soundcore i810 agpgart bin
Jun 27 14:38:11 sierra kernel: CPU:    0
Jun 27 14:38:11 sierra kernel: EIP:    0010:[<c8832442>]    Not tainted
Jun 27 14:38:11 sierra kernel: EFLAGS: 00010082
Jun 27 14:38:11 sierra kernel:
Jun 27 14:38:11 sierra kernel: EIP is at qla2x00_64bit_start_scsi [qla2200] 0xc2 (2.4.18-3)
Jun 27 14:38:11 sierra kernel: eax: 00000059   ebx: 00000000   ecx: 00000001   edx: 00002930
Jun 27 14:38:11 sierra kernel: esi: 00000001   edi: 00000001   ebp: c7e30084   esp: c5849e58
Jun 27 14:38:11 sierra kernel: ds: 0018   es: 0018   ss: 0018
Jun 27 14:38:11 sierra kernel: Process scsi_target_thread
Jun 27 14:38:11 sierra kernel:  (pid: 1744, stackpage=c5849000)
Jun 27 14:38:11 sierra kernel: Stack: c883ebc0 00000099 00000000 000000d1 66692020 c7e0e500 c7c05e60 00000000
Jun 27 14:38:11 sierra kernel:        00000001 c78fe000 00292264 0000d800 c78ff1a0 c7952000 c7e30084 c7952004
Jun 27 14:38:11 sierra kernel:        c8836812 c78ff1a0 c78ff1a0 c7e30084 00000000 c7953800 c882f445 c7e30084
Jun 27 14:38:11 sierra kernel: Call Trace: [<c883ebc0>] .rodata.str1.32 [qla2200] 0x60
Jun 27 14:38:11 sierra kernel: [<c8836812>] qla2x00_next [qla2200] 0xa2
Jun 27 14:38:11 sierra kernel: [<c882f445>] qla2100_queuecommand [qla2200] 0x295
Jun 27 14:38:11 sierra kernel: [<c880d679>] scsi_dispatch_cmd [scsi_mod] 0x1e9
Jun 27 14:38:11 sierra kernel: [<c8813a50>] scsi_old_done [scsi_mod] 0x0
Jun 27 14:38:11 sierra kernel: [<c8815364>] scsi_request_fn [scsi_mod] 0x2d4
Jun 27 14:38:11 sierra kernel: [<c8814744>] __scsi_insert_special [scsi_mod] 0x64
Jun 27 14:38:11 sierra kernel: [<c881479a>] scsi_insert_special_req [scsi_mod] 0x1a
Jun 27 14:38:11 sierra kernel: [<c880d964>] scsi_do_req_Rc63a25cd [scsi_mod] 0x174
Jun 27 14:38:11 sierra kernel: [<c8e67360>] te_cmnd_processed [scsi_target] 0x0
Jun 27 14:38:11 sierra kernel: [<c8e67349>] handle_cmd [scsi_target] 0x249
Jun 27 14:38:11 sierra kernel: [<c8e67360>] te_cmnd_processed [scsi_target] 0x0
Jun 27 14:38:11 sierra kernel: [<c8e66937>] scsi_target_process_thread [scsi_target] 0x267
Jun 27 14:38:11 sierra kernel: [<c8e69358>] target_data [scsi_target] 0x18
Jun 27 14:38:11 sierra kernel: [<c8e6892e>] .rodata.str1.1 [scsi_target] 0x6e
Jun 27 14:38:11 sierra kernel: [<c8e676ab>] .text.lock.KBUILD_BASENAME [scsi_target] 0x2d
Jun 27 14:38:11 sierra kernel: [<c8e666d0>] scsi_target_process_thread [scsi_target] 0x0
Jun 27 14:38:11 sierra kernel: [<c0107136>] kernel_thread [kernel] 0x26
Jun 27 14:38:11 sierra kernel: [<c8e666d0>] scsi_target_process_thread [scsi_target] 0x0



  +----------------------------------------------------+
  | Chaoyang Deng -- cdeng@iol.unh.edu -- 603.868.1908 |
  | iSCSI Consortium, InterOperability lab (IOL),  UNH |
  | http://www.iol.unh.edu/consortiums/iscsi/          |
  | 204 Forest Park, Durham, NH 03824  -- 603.862.3470 |
  +----------------------------------------------------+

