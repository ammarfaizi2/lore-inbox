Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSFDStw>; Tue, 4 Jun 2002 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFDStv>; Tue, 4 Jun 2002 14:49:51 -0400
Received: from inje.iskon.hr ([213.191.128.16]:63665 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S316235AbSFDStB>;
	Tue, 4 Jun 2002 14:49:01 -0400
To: linux-kernel@vger.kernel.org
Cc: Martin Dalecki <dalecki@evision-ventures.com>
Subject: IDE{,-SCSI} trouble [2.5.20]
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 04 Jun 2002 20:48:51 +0200
Message-ID: <87elfmq3qk.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.20 on a typical UP setup (PIII, BX chipset) produces quite a lot of

Jun  4 19:34:44 magla kernel: hda: lost interrupt
Jun  4 19:47:09 magla kernel: hda: lost interrupt
Jun  4 19:53:59 magla kernel: hda: lost interrupt
Jun  4 19:56:54 magla kernel: hda: lost interrupt
Jun  4 20:05:49 magla kernel: hda: lost interrupt
Jun  4 20:06:09 magla kernel: hda: lost interrupt
Jun  4 20:11:59 magla kernel: hda: lost interrupt
Jun  4 20:12:34 magla kernel: hda: lost interrupt
Jun  4 20:33:29 magla kernel: hda: lost interrupt
Jun  4 20:42:24 magla kernel: hdc: lost interrupt

I haven't run lots of 2.5.x on that machine, so I don't know if it's
specific/new to 2.5.20.


Second thing, ide-scsi has some kind of trouble that hasn't been
solved for some time now. This one is on SMP machine, 2.5.20, but I've
seen it on older 2.5.x:

Jun  4 20:08:41 atlas kernel: VFS: Disk change detected on device sr(11,1)
Jun  4 20:08:41 atlas kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000098
Jun  4 20:08:41 atlas kernel:  printing eip:
Jun  4 20:08:41 atlas kernel: c01af537
Jun  4 20:08:41 atlas kernel: *pde = 00000000
Jun  4 20:08:41 atlas kernel: Oops: 0000
Jun  4 20:08:41 atlas kernel: CPU:    1
Jun  4 20:08:41 atlas kernel: EIP:    0010:[blk_rq_map_sg+23/356]    Not tainted
Jun  4 20:08:41 atlas kernel: EFLAGS: 00210296
Jun  4 20:08:41 atlas kernel: eax: da17df40   ebx: efdfb000   ecx: da17df40   edx: 00000000
Jun  4 20:08:41 atlas kernel: esi: 0000c008   edi: da17df40   ebp: c0371b08   esp: dabefc74
Jun  4 20:08:41 atlas kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 20:08:41 atlas kernel: Process nautilus (pid: 457, threadinfo=dabee000 task=ec808120)
Jun  4 20:08:41 atlas kernel: Stack: efdfb000 0000c008 da17df40 c0371b08 da17dd40 00000000 da17dd40 c0371b1c 
Jun  4 20:08:41 atlas kernel:        00000000 c03717a8 c01aebba c01ca5cb 00000000 da17df40 efdfb000 efdfc000 
Jun  4 20:08:41 atlas kernel:        0000c008 00000008 c0371b08 c0371b08 00000000 c01caa38 c03717a8 da17df40 
Jun  4 20:08:41 atlas kernel: Call Trace: [__elv_next_request+10/16] [build_sglist+271/448] [udma_new_table+36/332] [ata_start_dma+44/100] [udma_pci_init+20/212] 
Jun  4 20:08:41 atlas kernel:    [idescsi_issue_pc+100/324] [idescsi_do_request+27/60] [start_request+288/396] [__elv_next_request+10/16] [queue_commands+294/372] [do_request+64/104] 
Jun  4 20:08:41 atlas kernel:    [do_ide_request+16/20] [ide_do_drive_cmd+228/292] [idescsi_queue+1332/1420] [scsi_dispatch_cmd+265/428] [scsi_done+0/164] [scsi_request_fn+1128/1168] 
Jun  4 20:08:41 atlas kernel:    [generic_unplug_device+59/84] [blk_run_queues+174/268] [do_page_cache_readahead+227/264] [page_cache_readahead+235/244] [do_generic_file_read+146/808] [generic_file_read+126/304] 
Jun  4 20:08:41 atlas kernel:    [file_read_actor+0/140] [vfs_read+154/264] [sys_read+42/60] [syscall_call+7/11] 
Jun  4 20:08:41 atlas kernel: 
Jun  4 20:08:41 atlas kernel: Code: 8b 8a 98 00 00 00 83 e1 02 89 4c 24 18 c7 44 24 28 00 00 00 
Jun  4 20:09:21 atlas kernel:  <6>scsi: device set offline - command error recover failed: host 1 channel 0 id 0 lun 0
Jun  4 20:09:21 atlas kernel: SCSI cdrom error : host 1 channel 0 id 0 lun 0 return code = 6000000
Jun  4 20:09:21 atlas kernel: end_request: I/O error, dev 0b:01, sector 64
Jun  4 20:09:21 atlas kernel: Buffer I/O error on device sr(11,1), logical block 8
Jun  4 20:09:21 atlas kernel: end_request: I/O error, dev 0b:01, sector 72
Jun  4 20:09:21 atlas kernel: Buffer I/O error on device sr(11,1), logical block 9
Jun  4 20:09:21 atlas kernel: Buffer I/O error on device sr(11,1), logical block 10
Jun  4 20:09:21 atlas kernel: Buffer I/O error on device sr(11,1), logical block 11
Jun  4 20:09:21 atlas kernel: SCSI error: host 1 id 0 lun 0 return code = 6000000
Jun  4 20:09:21 atlas kernel: ^ISense class 0, sense error 0, extended sense 0
Jun  4 20:09:21 atlas kernel: VFS: Disk change detected on device sr(11,1)
Jun  4 20:09:21 atlas kernel: VFS: Disk change detected on device sr(11,1)
Jun  4 20:09:41 atlas kernel: scsi: device set offline - command error recover failed: host 0 channel 0 id 0 lun 0
Jun  4 20:09:41 atlas kernel: SCSI error: host 0 id 0 lun 0 return code = 6000000
Jun  4 20:09:41 atlas kernel: ^ISense class 0, sense error 0, extended sense 0
Jun  4 20:09:41 atlas kernel: VFS: Disk change detected on device sr(11,0)
Jun  4 20:09:41 atlas kernel: VFS: Disk change detected on device sr(11,0)

More info available on request.

Regards,
-- 
Zlatko
