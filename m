Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTDSRz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTDSRz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:55:26 -0400
Received: from mail.ithnet.com ([217.64.64.8]:22803 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263415AbTDSRzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:55:23 -0400
Date: Sat, 19 Apr 2003 20:07:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030419200712.3c48a791.skraw@ithnet.com>
In-Reply-To: <87lly6flrz.fsf@deneb.enyo.de>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	<87lly6flrz.fsf@deneb.enyo.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003 19:18:56 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
> > Most I came across have only small problems (few dead sectors),
> 
> IDE disks automatically remap defective sectors, so you won't see any
> of them unless the disk is already quite broken.

One year ago I thought basically the same, just to give you some info on todays' case (on 2.4.21-pre7-ac1):

Apr 18 22:08:53 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x4, unit #0. 
Apr 18 22:08:57 admin kernel: 3w-xxxx: scsi2: AEN: ERROR: Drive error: Port #0.
Apr 18 22:08:57 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 18 22:08:58 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 18 22:10:11 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x4b, unit #0.
Apr 18 22:10:13 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 18 22:11:20 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x58, unit #0. 
Apr 18 22:11:23 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 18 23:11:27 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 18 23:11:27 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 18 23:11:31 admin kernel: 3w-xxxx: scsi2: Reset succeeded.

Apr 19 00:15:47 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:15:47 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:15:48 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 19 00:16:03 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 19 00:16:07 admin kernel: 3w-xxxx: scsi2: AEN: ERROR: Drive error: Port #0.
Apr 19 00:16:09 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 19 00:16:26 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xcb, flags = 0x37, unit #1.
Apr 19 00:16:26 admin kernel: 3w-xxxx: scsi2: AEN: ERROR: Drive error: Port #0.
Apr 19 00:16:26 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xcb, flags = 0x37, unit #1.
Apr 19 00:16:26 admin kernel:  I/O error: dev 08:21, sector 125092104
Apr 19 00:16:26 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xcb, flags = 0x37, unit #1.
Apr 19 00:16:26 admin kernel:  I/O error: dev 08:21, sector 125092104
Apr 19 00:28:06 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x24, unit #0.
Apr 19 00:28:10 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 19 00:28:36 admin kernel: 3w-xxxx: scsi2: Unit #0: Command (f7419c00) timed out, resetting card.
Apr 19 00:28:43 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 19 00:56:23 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 19 00:56:23 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x4, unit #0. 
Apr 19 00:56:23 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x9, unit #0. 
Apr 19 00:56:23 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 19 00:56:23 admin last message repeated 2 times

Apr 19 00:56:27 admin kernel: 3w-xxxx: scsi2: AEN: ERROR: Drive error: Port #0.
Apr 19 00:56:27 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0.
Apr 19 00:56:54 admin kernel: 3w-xxxx: scsi2: Unit #0: Command (f7415200) timed out, resetting card.
Apr 19 00:56:54 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x80, unit #0. 
Apr 19 00:56:56 admin kernel: 3w-xxxx: scsi2: Reset succeeded.
Apr 19 00:57:30 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:57:34 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.
Apr 19 00:57:59 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:58:03 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.
Apr 19 00:58:29 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:58:32 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.
Apr 19 00:58:58 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:59:02 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.
Apr 19 00:59:27 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.
Apr 19 00:59:31 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.
Apr 19 00:59:56 admin kernel: 3w-xxxx: scsi2: Command failed: status = 0xc7, flags = 0x1b, unit #0.

And then reiserfs is going mad:

Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 53320
Apr 19 00:59:56 admin kernel: journal-601, buffer write failed   
Apr 19 00:59:56 admin kernel: kernel BUG at prints.c:334!
Apr 19 00:59:56 admin kernel: invalid operand: 0000
Apr 19 00:59:56 admin kernel: CPU:    1
Apr 19 00:59:56 admin kernel: EIP:    0010:[reiserfs_panic+56/112]    Not tainted
Apr 19 00:59:56 admin kernel: EIP:    0010:[<c0188128>]    Not tainted
Apr 19 00:59:56 admin kernel: EFLAGS: 00010282
Apr 19 00:59:56 admin kernel: eax: 00000024   ebx: f6ce8c00   ecx: 00000001   edx: c02cb6cc
Apr 19 00:59:56 admin kernel: esi: 00000000   edi: f6ce8c00   ebp: 00000006   esp: c34f5eb8
Apr 19 00:59:56 admin kernel: ds: 0018   es: 0018   ss: 0018
Apr 19 00:59:56 admin kernel: Process kupdated (pid: 9, stackpage=c34f5000)
Apr 19 00:59:56 admin kernel: Stack: c029a58c c036c5c0 f6ce8c00 f8c136b4 c019352a f6ce8c00 c02a3220 00001000
Apr 19 00:59:56 admin kernel:        e32965c0 00000009 00000007 00000000 da2b6c80 00000000 00000014 dde3b000
Apr 19 00:59:56 admin kernel:        00000004 c01976a1 f6ce8c00 f8c136b4 00000001 00000006 f8c1c3c4 00000004
Apr 19 00:59:56 admin kernel: Call Trace:    [flush_commit_list+714/1104] [do_journal_end+1649/2976] [flush_old_commits+292/448] [reiserfs_write_super+112/128] [syn
Apr 19 00:59:56 admin kernel: Call Trace:    [<c019352a>] [<c01976a1>] [<c01968b4>] [<c0184e40>] [<c014894c>]
Apr 19 00:59:56 admin kernel:   [sync_old_buffers+60/176] [kupdate+253/320] [rest_init+0/96] [rest_init+0/96] [arch_kernel_thread+46/64] [kupdate+0/320]
Apr 19 00:59:56 admin kernel:   [<c01479ac>] [<c0147d1d>] [<c0105000>] [<c0105000>] [<c010581e>] [<c0147c20>]
Apr 19 00:59:56 admin kernel: 

Apr 19 00:59:56 admin kernel: Code: 0f 0b 4e 01 58 d4 29 c0 85 db 74 0e 0f b7 43 08 89 04 24 e8
Apr 19 00:59:56 admin kernel:  SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2   
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285225664
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285225672
Apr 19 00:59:56 admin kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226176
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226184
Apr 19 00:59:56 admin kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285225920
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285225928
Apr 19 00:59:56 admin kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226432
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226440
Apr 19 00:59:56 admin kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226688
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226696
Apr 19 00:59:56 admin kernel: SCSI disk error : host 2 channel 0 id 0 lun 0 return code = 2
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226944
Apr 19 00:59:56 admin kernel:  I/O error: dev 08:11, sector 285226952
Apr 19 01:00:00 admin kernel: 3w-xxxx: scsi2: AEN: WARNING: ATA port timeout: Port #0.

Things turn out a bit more complicated as you may notice ...

Regards,
Stephan


