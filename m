Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbULMRTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbULMRTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbULMRSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:18:17 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:16796 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261281AbULMROU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:14:20 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-22.tower-45.messagelabs.com!1102958054!8266333!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Unknown Issue.
Date: Mon, 13 Dec 2004 12:14:11 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4179@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unknown Issue.
Thread-Index: AcThNc0bdoCvAbnPSxGvklqu2rt0nAAAFLcA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Eric Sandeen" <sandeen@sgi.com>
Cc: "Patrick" <nawtyness@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My first thought is that perhaps the filesystem has shut down due to 
> some error (memory corruption, bad disk, xfs bug...); did you check
your 
> log messages?

Yes, there was nothing relevant on either machine.

> Justin, when you mentioned that you used xfs' fsck, I guess you used 
> xfs_repair.  Was the log clean when you ran it, or did you force
repair 
> to zero out the log?  That could explain the large lost+found/ when
you 
> were done...

Ah, good question, yes I used xfs_repair, at this point I knew I had to
restore from backup and answered "y" to all questions.  I am not sure
but I do not recall the log being dirty.

In the logs on my main machine, it showed the following when it
attempted to mount the two filesystems (root and boot, /dev/hde4 and
/dev/hde1 respectively).

As far as bad disk/memory, I have tested both systems with memtest86 and
the result was 0 errors, as far as the disks go, I have not experienced
any problems with either of them until I moved to 2.6.9/2.6.10-rc{1,2}.


Justin.

Dec  5 08:23:53 jpiszcz kernel: XFS internal error
XFS_WANT_CORRUPTED_GOTO at line 1583 of file fs/xfs/xfs_alloc.c.  Caller
0xc021de57
Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_ag_extent+1237/2065]
xfs_free_ag_extent+0x4d5/0x811
Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_extent+207/242]
xfs_free_extent+0xcf/0xf2
Dec  5 08:23:53 jpiszcz kernel:  [xlog_grant_push_ail+279/400]
xlog_grant_push_ail+0x117/0x190
Dec  5 08:23:53 jpiszcz kernel:  [xfs_free_extent+207/242]
xfs_free_extent+0xcf/0xf2
Dec  5 08:23:53 jpiszcz kernel:  [xfs_trans_get_efd+56/70]
xfs_trans_get_efd+0x38/0x46
Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_process_efi+402/508]
xlog_recover_process_efi+0x192/0x1fc
Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_process_efis+77/129]
xlog_recover_process_efis+0x4d/0x81
Dec  5 08:23:53 jpiszcz kernel:  [xlog_recover_finish+26/194]
xlog_recover_finish+0x1a/0xc2
Dec  5 08:23:53 jpiszcz kernel:  [xfs_rtmount_inodes+193/230]
xfs_rtmount_inodes+0xc1/0xe6
Dec  5 08:23:53 jpiszcz kernel:  [xfs_log_mount_finish+44/48]
xfs_log_mount_finish+0x2c/0x30
Dec  5 08:23:53 jpiszcz kernel:  [xfs_mountfs+2459/3995]
xfs_mountfs+0x99b/0xf9b
Dec  5 08:23:53 jpiszcz kernel:  [pagebuf_iostart+143/159]
pagebuf_iostart+0x8f/0x9f
Dec  5 08:23:53 jpiszcz kernel:  [atomic_dec_and_lock+39/68]
atomic_dec_and_lock+0x27/0x44
Dec  5 08:23:53 jpiszcz kernel:  [xfs_readsb+417/559]
xfs_readsb+0x1a1/0x22f
Dec  5 08:23:53 jpiszcz kernel:  [xfs_ioinit+27/46] xfs_ioinit+0x1b/0x2e
Dec  5 08:23:53 jpiszcz kernel:  [xfs_mount+934/1646]
xfs_mount+0x3a6/0x66e
Dec  5 08:23:53 jpiszcz kernel:  [linvfs_fill_super+155/486]
linvfs_fill_super+0x9b/0x1e6
Dec  5 08:23:53 jpiszcz kernel:  [snprintf+39/43] snprintf+0x27/0x2b
Dec  5 08:23:53 jpiszcz kernel:  [disk_name+98/191] disk_name+0x62/0xbf
Dec  5 08:23:53 jpiszcz kernel:  [sb_set_blocksize+46/94]
sb_set_blocksize+0x2e/0x5e
Dec  5 08:23:53 jpiszcz kernel:  [get_sb_bdev+258/342]
get_sb_bdev+0x102/0x156
Dec  5 08:23:53 jpiszcz kernel:  [alloc_vfsmnt+156/215]
alloc_vfsmnt+0x9c/0xd7
Dec  5 08:23:53 jpiszcz kernel:  [linvfs_get_sb+47/51]
linvfs_get_sb+0x2f/0x33
Dec  5 08:23:53 jpiszcz kernel:  [linvfs_fill_super+0/486]
linvfs_fill_super+0x0/0x1e6
Dec  5 08:23:53 jpiszcz kernel:  [do_kern_mount+99/235]
do_kern_mount+0x63/0xeb
Dec  5 08:23:53 jpiszcz kernel:  [do_new_mount+158/247]
do_new_mount+0x9e/0xf7
Dec  5 08:23:53 jpiszcz kernel:  [do_mount+413/443] do_mount+0x19d/0x1bb
Dec  5 08:23:53 jpiszcz kernel:  [copy_mount_options+96/183]
copy_mount_options+0x60/0xb7
Dec  5 08:23:53 jpiszcz kernel:  [sys_mount+191/291]
sys_mount+0xbf/0x123
Dec  5 08:23:53 jpiszcz kernel:  [do_mount_root+47/158]
do_mount_root+0x2f/0x9e
Dec  5 08:23:53 jpiszcz kernel:  [mount_block_root+96/305]
mount_block_root+0x60/0x131
Dec  5 08:23:53 jpiszcz kernel:  [mount_root+101/135]
mount_root+0x65/0x87
Dec  5 08:23:53 jpiszcz kernel:  [prepare_namespace+25/178]
prepare_namespace+0x19/0xb2
Dec  5 08:23:53 jpiszcz kernel:  [flush_workqueue+136/180]
flush_workqueue+0x88/0xb4
Dec  5 08:23:53 jpiszcz kernel:  [init+427/475] init+0x1ab/0x1db
Dec  5 08:23:53 jpiszcz kernel:  [init+0/475] init+0x0/0x1db
Dec  5 08:23:53 jpiszcz kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Dec  5 08:23:53 jpiszcz kernel: VFS: Mounted root (xfs filesystem)
readonly.

-----Original Message-----
From: Eric Sandeen [mailto:sandeen@sgi.com] 
Sent: Monday, December 13, 2004 12:04 PM
To: Piszcz, Justin Michael
Cc: Patrick; linux-kernel@vger.kernel.org; linux-xfs@oss.sgi.com; Andrew
Morton; Kristofer T. Karas; Jeff Garzik; Linus Torvalds
Subject: Re: Unknown Issue.

My first thought is that perhaps the filesystem has shut down due to 
some error (memory corruption, bad disk, xfs bug...); did you check your

log messages?

Justin, when you mentioned that you used xfs' fsck, I guess you used 
xfs_repair.  Was the log clean when you ran it, or did you force repair 
to zero out the log?  That could explain the large lost+found/ when you 
were done...

Patrick, can you reproduce on a non-gentoo kernel?  That'd be the first 
step for this audience.

-Eric

Piszcz, Justin Michael wrote:
> Patrick,
> 
> I had the same problem on two machines with XFS.  Both
slackware-current
> machines.  The kernel on the Dell GX1 was built with GCC-3.4.2 and on
my
> main box was GCC-3.4.3.
> 
> There seems to be a bug in XFS with some configurations of 2.6.9 and
> 2.6.10-rc series.
> 
> After re-installing Slackware-10.0 and upgrading to -current, I have
> installed 2.6.10-rc3 and so far, I have not been able to reproduce the
> problem.
> 
> Some questions for you:
> 
> 1] What kernel are you running?
> 2] What did you last change before you started getting these errors?
> 
> As far as severity goes, I ran XFS' fsck from a KNOPPIX CD and as a
> result, I had about 500-600mb of files in my /lost+found directory
when
> it was finished.  Files were missing from all parts of the file
system.
> I had to restore from backup.  I would say stick with your previous
> 2.6.9 configuration (if you were running it) or go back to 2.6.8.1,
some
> 2.6.9 configurations and 2.6.10-rc1 and/or 2.6.10-rc2 definitely cause
> file corruption with XFS.  So far, however, I have not been able to
> reproduce the error with 2.6.10-rc3.
> 
> Justin.
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Patrick
> Sent: Sunday, December 12, 2004 4:15 PM
> To: linux-kernel@vger.kernel.org
> Subject: Unknown Issue.
> 
> Hi, 
> 
> I've got a computer running gentoo, on a clean install where i've got
> an odd problem :
> 
> after a while, the computer refuses to spawn processes anymore : 
> 
> -/bin/bash: /bin/ps: Input/output error
> -/bin/bash: /usr/bin/w: Input/output error
> -/bin/bash: /bin/df: Input/output error
> -/bin/bash: /bin/mount: Input/output error
> 

