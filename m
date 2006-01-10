Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWAJSl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWAJSl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJSl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:41:56 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:42375 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932112AbWAJSlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:41:55 -0500
Date: Tue, 10 Jan 2006 19:46:24 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.15 OOPS while trying to mount cdrom
Message-ID: <20060110184624.GA6721@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.15 amd64, gcc 4.1.0 from debian.

The cdrom (/dev/hda) is usually fine.  I tried booting with
hda=ide-scsi in order to read a scratched audio cd with cdparanoia.
That way, I at least get error messages when the scratches are
too bad.

I forgot about hda=ide-scsi, and tried to mount /dev/hda as
usual in order to read an ordinary iso9660 cd.  This is
probably not supposed to work when ide-scsi is using the device,
but then I expect something like EBUSY rather than this oops:

ide-scsi: unsup command: dev hda: flags = REQ_SORTED REQ_CMD REQ_STARTED 
REQ_ELVPRIV 
sector 64, nr/cnr 2/2
bio ffff8100044a9b40, biotail ffff8100044a9b40, buffer ffff81000cb4d000, data 
0000000000000000, len 0
end_request: I/O error, dev hda, sector 64
isofs_fill_super: bread failed, dev=hda, iso_blknum=16, block=32
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
<ffffffff80235a92>{strlen+2}
PGD 73bc067 PUD 14ecd067 PMD 0 
Oops: 0000 [1] PREEMPT 
CPU 0 
Pid: 9457, comm: mount Tainted: G   M  2.6.15 #30
RIP: 0010:[<ffffffff80235a92>] <ffffffff80235a92>{strlen+2}
RSP: 0018:ffff810006701c40  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000000d0
RDX: 0000000000000000 RSI: 00000000000000d0 RDI: 0000000000000000
RBP: ffff81001f9a68a8 R08: ffff810006700000 R09: ffff81001ef39d80
R10: 000000000000002b R11: 0000000000000246 R12: ffff81001f9a68a8
R13: 00000000000000d0 R14: 0000000000000000 R15: ffff810002825000
FS:  00002aaaab00e6d0(0000) GS:ffffffff80758800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000000c296000 CR4: 00000000000006e0
Process mount (pid: 9457, threadinfo ffff810006700000, task ffff81001fd78790)
Stack: ffffffff8023328f 00000000fffffff4 00000000000000d0 0000000000000005 
       0000000000000000 0000000000000000 ffffffff80233666 0000000000000000 
       ffff810001ff0c80 ffffffff8060d820 
Call Trace:<ffffffff8023328f>{kobject_get_path+31} 
<ffffffff80233666>{do_kobject_uevent+54}
       <ffffffff8017f9c5>{kill_block_super+37} 
<ffffffff8017fb04>{deactivate_super+148}
       <ffffffff8017fe2e>{get_sb_bdev+302} 
<ffffffff801f0390>{isofs_fill_super+0}
       <ffffffff8017fba7>{do_kern_mount+103} <ffffffff801984c4>{do_mount+1860}
       <ffffffff8016700e>{__handle_mm_fault+1518} 
<ffffffff8015aa87>{get_page_from_freelist+743}
       <ffffffff802354f2>{__up_read+130} <ffffffff8015abe6>{__alloc_pages+118}
       <ffffffff8015ae77>{__get_free_pages+55} 
<ffffffff8019860b>{sys_mount+155}
       <ffffffff8010eb7a>{system_call+126} 

Code: 80 3f 00 74 14 48 89 f8 66 66 90 66 66 90 48 ff c0 80 38 00 
RIP <ffffffff80235a92>{strlen+2} RSP <ffff810006701c40>
CR2: 0000000000000000

The pc didn't seem to malfunction after this.

Helge Hafting
