Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLBOIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTLBOIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:08:32 -0500
Received: from mail1.neceur.com ([193.116.254.3]:40428 "EHLO mail1.neceur.com")
	by vger.kernel.org with ESMTP id S262116AbTLBOIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:08:06 -0500
In-Reply-To: <3FCC9307.8050409@wmich.edu>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-SCSI oops in 2.6.0-test11
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OFCDE312E0.4BD86A49-ON80256DF0.004D17F7-80256DF0.004DA592@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Tue, 2 Dec 2003 14:08:06 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 02:07:54 PM,
	Serialize complete at 12/02/2003 02:07:54 PM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 02:07:54 PM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 12/02/2003 02:07:56 PM,
	Serialize complete at 12/02/2003 02:07:56 PM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI works fine but LAPIC doesn't.  If I turn ACPI I have to add 
pci=noacpi.  It
is safer to turn the whole beast off.

The Oops was at the end of the syslog output.  Maybe I should have put it
at the start.

I can't get the source, otherwise I would have compiled it against 2.6.0. 
However
I don't find this point particularly relevant since 2.6.0 should be 
backward compatible
with 2.4,0, atleast at the binary level.

I tried the earlier versions of dvdrtools and cdrtools and their didn't 
like ide-cd.  This
version (cdrecord-dvdpro) does but it still don't alter the fact that 
while using ide-scsi
is no longer recommended, it still should work.

Here the the oops again.

Dec  2 12:02:46 mig27 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Dec  2 12:02:46 mig27 kernel:  printing eip:
Dec  2 12:02:46 mig27 kernel: 00000000
Dec  2 12:02:46 mig27 kernel: *pde = 00000000
Dec  2 12:02:46 mig27 kernel: Oops: 0000 [#1]
Dec  2 12:02:46 mig27 kernel: CPU:    0
Dec  2 12:02:46 mig27 kernel: EIP:    0060:[<00000000>]    Not tainted
Dec  2 12:02:46 mig27 kernel: EFLAGS: 00210202
Dec  2 12:02:46 mig27 kernel: EIP is at 0x0
Dec  2 12:02:46 mig27 kernel: eax: c0354f10   ebx: c035516c   ecx: 
00000000   edx: 00000170
Dec  2 12:02:46 mig27 kernel: esi: f623e400   edi: f6ed4fc0   ebp: 
e4161be0   esp: e4161bb8
Dec  2 12:02:46 mig27 kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 12:02:46 mig27 kernel: Process cdrecord-prodvd (pid: 369, 
threadinfo=e4160000 task=f65d4100)
Dec  2 12:02:46 mig27 kernel: Stack: f9859b1b c035516c f623e400 0000000c 
00000000 0000001e f6ed4fc0 c035516c 
Dec  2 12:02:46 mig27 kernel:        00000000 f6f9b240 e4161c0c c01ff25a 
c035516c f623e400 00000000 00000000 
Dec  2 12:02:46 mig27 kernel:        0000001e 0000000f f6f9b240 c035516c 
c0354f10 e4161c38 c01ff570 c035516c 
Dec  2 12:02:46 mig27 kernel: Call Trace:
Dec  2 12:02:46 mig27 kernel:  [<f9859b1b>] 
idescsi_transfer_pc+0x11b/0x120 [ide_scsi]
Dec  2 12:02:46 mig27 kernel:  [<c01ff25a>] start_request+0x16a/0x270
Dec  2 12:02:46 mig27 kernel:  [<c01ff570>] ide_do_request+0x1e0/0x360
Dec  2 12:02:46 mig27 kernel:  [<c01f3587>] __elv_add_request+0x27/0x40
Dec  2 12:02:46 mig27 kernel:  [<c01ffd5e>] ide_do_drive_cmd+0xce/0x170
Dec  2 12:02:46 mig27 kernel:  [<f985a36b>] idescsi_queue+0x1fb/0x630 
[ide_scsi]
Dec  2 12:02:46 mig27 kernel:  [<f993171f>] 
scsi_init_cmd_from_req+0xcf/0x150 [scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<f993159e>] scsi_dispatch_cmd+0x14e/0x200 
[scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<f99317a0>] scsi_done+0x0/0x70 [scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<f9933ae0>] scsi_times_out+0x0/0x50 
[scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<f993631d>] scsi_request_fn+0x1cd/0x320 
[scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<c01f5b0c>] blk_insert_request+0x7c/0xd0
Dec  2 12:02:46 mig27 kernel:  [<f9934ffb>] 
scsi_insert_special_req+0x3b/0x40 [scsi_mod]
Dec  2 12:02:46 mig27 kernel:  [<f98c3eb1>] sg_common_write+0x161/0x1d0 
[sg]
Dec  2 12:02:46 mig27 kernel:  [<f98c5290>] sg_cmd_done+0x0/0x280 [sg]
Dec  2 12:02:46 mig27 kernel:  [<f98c3c73>] sg_new_write+0x1c3/0x2a0 [sg]
Dec  2 12:02:46 mig27 kernel:  [<f98c4c09>] sg_ioctl+0xce9/0xf20 [sg]
Dec  2 12:02:46 mig27 kernel:  [<c0204812>] pre_task_mulout_intr+0x82/0x90
Dec  2 12:02:46 mig27 kernel:  [<c01afee4>] __delay+0x14/0x20
Dec  2 12:02:46 mig27 kernel:  [<c02037fe>] do_rw_taskfile+0x12e/0x2b0
Dec  2 12:02:46 mig27 kernel:  [<c01faff3>] 
as_remove_queued_request+0x83/0x120
Dec  2 12:02:46 mig27 kernel:  [<c020a194>] lba_28_rw_disk+0xa4/0xb0
Dec  2 12:02:46 mig27 kernel:  [<c01284b6>] update_process_times+0x46/0x50
Dec  2 12:02:46 mig27 kernel:  [<c012832d>] update_wall_time+0xd/0x40
Dec  2 12:02:46 mig27 kernel:  [<c012877e>] do_timer+0xde/0xf0
Dec  2 12:02:46 mig27 kernel:  [<c01284b6>] update_process_times+0x46/0x50
Dec  2 12:02:46 mig27 kernel:  [<c012832d>] update_wall_time+0xd/0x40
Dec  2 12:02:46 mig27 kernel:  [<c012877e>] do_timer+0xde/0xf0
Dec  2 12:02:46 mig27 kernel:  [<c011cbf0>] default_wake_function+0x0/0x20
Dec  2 12:02:46 mig27 kernel:  [<c01103ea>] do_gettimeofday+0x2a/0xc0
Dec  2 12:02:46 mig27 kernel:  [<c01666d4>] sys_ioctl+0xf4/0x2a0
Dec  2 12:02:46 mig27 kernel:  [<c010a36f>] syscall_call+0x7/0xb
Dec  2 12:02:46 mig27 kernel: 
Dec  2 12:02:46 mig27 kernel: Code:  Bad EIP value.

Cheers,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."




Ed Sweetman <ed.sweetman@wmich.edu>
02/12/2003 01:26 p.m.
 
        To:     ross.alexander@uk.neceur.com
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: IDE-SCSI oops in 2.6.0-test11


ross.alexander@uk.neceur.com wrote:
> CPU: Athlon-XP 2700+
> MB: ASUS A7N8X Deluxe
> Memory: 3 x 512MB
> Notes: UP kernel, standard EIDE driver, boot paramters acpi=off 
> nolapic,noapic
> Libc: glibc-2.3.2 with linuxthreads.
> 
> This error occurs while trying to write a DVD+RW to an NEC-1300A DVD 
> writer
> using cdrecord-dvdpro executable (no source available).  This works fine
> on linux-2.4.23.
> 



First off, acpi should be working just fine now...should have been for 
the last couple versions of 2.6.0-test.
Second, you probably shouldn't be using ide-scsi.  ATAPI works just fine 
using straight ide for CDR's so it probably works fine for DVD-R+R+RW 
whatever stupid acronymn they're using today.
Third, you didn't post the actual oops so how is anyone supposed t osay 
anything about this problem?
Fourth, you are using a binary you didn't compile that's probably 
compiled against headers for api's found in 2.4.x which is seriously 
different from the kernel you're running it on. Compile your own 
cdrecord and see how it goes.



