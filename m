Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVALKkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVALKkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 05:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVALKkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 05:40:39 -0500
Received: from relay.muni.cz ([147.251.4.35]:1678 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261323AbVALKk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 05:40:28 -0500
Date: Wed, 12 Jan 2005 11:40:25 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: ATA/x86_64 oops during SMART command
Message-ID: <20050112104025.GE13145@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

	today I have found that SMART self-test on my /dev/hdb failed.
When trying to do selective self-test for the affected blocks, the
smartctl command segfaulted in kernel. Is this a smartctl bug or
a IDE driver bug?

	The command line was the following:

# smartctl -t select,14552074-14552300 /dev/hdb
smartctl version 5.33 [x86_64-redhat-linux-gnu] Copyright (C) 2002-4 Bruce AllenHome page is http://smartmontools.sourceforge.net/

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Killed
#

	The machine is ASUS SK8V (VIA KT800), Athlon FX-51 running
2.6.10 and Fedora Core 3. End of my dmesg(8) output is here:

end_request: I/O error, dev hdb, sector 14552072
hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=14552078, high=0, low=14552078, sector=14552072
ide: failed opcode was: unknown
end_request: I/O error, dev hdb, sector 14552072
Unable to handle kernel NULL pointer dereference at 0000000000000048 RIP:
<ffffffff80286c50>{pre_task_out_intr+160}
PML4 3c9b0067 PGD 0
Oops: 0000 [1]
CPU 0
Modules linked in: loop vfat fat parport_pc lp parport sd_mod binfmt_misc ohci1394 ieee1394 usb_storage floppy sata_via libata scsi_mod
Pid: 27322, comm: smartctl Not tainted 2.6.10
RIP: 0010:[<ffffffff80286c50>] <ffffffff80286c50>{pre_task_out_intr+160}
RSP: 0018:000001002fff3ac8  EFLAGS: 00010216
RAX: 0000000000000000 RBX: ffffffff80493010 RCX: 0000000000000170
RDX: ffffffff80481240 RSI: 000001003fd32640 RDI: ffffffff8047fcc0
RBP: 0000000000000000 R08: 000000000000752f R09: 000001001fcf2000
R10: 0000000000000000 R11: ffffffff80286bb0 R12: 0000000000000000
R13: 000001003fd32600 R14: ffffffff80492c80 R15: 00000000ffffffff
FS:  0000002a9579eb00(0000) GS:ffffffff804b36c0(0000) knlGS:00000000558a5ea0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000048 CR3: 0000000000101000 CR4: 00000000000006e0
Process smartctl (pid: 27322, threadinfo 000001002fff2000, task 0000010012922750)
Stack: 0000000000000000 ffffffff80493010 000001002fff3ba8 ffffffff80281e64
       0000000000000000 000001003fd32640 000001002fff3ba8 0000000000000016
       0000000000000002 000001002fff3ba8
Call Trace:<ffffffff80281e64>{ide_do_request+1268} <ffffffff802824f9>{ide_do_drive_cmd+201}
       <ffffffff80286d83>{ide_diag_taskfile+227} <ffffffff8028712d>{ide_taskfile_ioctl+765}
       <ffffffff80286bb0>{pre_task_out_intr+0} <ffffffff80286aa0>{task_out_intr+0}
       <ffffffff8027fd0f>{generic_ide_ioctl+975} <ffffffff80224cf9>{pty_write+89}
       <ffffffff8022132d>{tty_default_put_char+29} <ffffffff80221d21>{opost+449}
       <ffffffff80223e7c>{write_chan+892} <ffffffff8025a2ca>{blkdev_ioctl+1818}
       <ffffffff8021e484>{tty_write+628} <ffffffff80127a04>{recalc_task_prio+436}
       <ffffffff80382090>{thread_return+41} <ffffffff80173a90>{sys_ioctl+880}
       <ffffffff8010d19a>{system_call+126}

Code: 48 83 7d 48 00 74 07 c7 45 70 00 00 00 00 48 8b 83 90 00 00
RIP <ffffffff80286c50>{pre_task_out_intr+160} RSP <000001002fff3ac8>
CR2: 0000000000000048

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
