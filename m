Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUFYVep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUFYVep (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266866AbUFYVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:34:45 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:8336 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S266868AbUFYVee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:34:34 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
MBOX-Line: From george@galis.org  Fri Jun 25 17:34:33 2004
Date: Fri, 25 Jun 2004 17:34:33 -0400
From: George Georgalis <george@galis.org>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
Message-ID: <20040625213433.GB6502@trot.local>
References: <20040624155919.GA16422@trot.local> <Pine.GSO.4.33.0406241442430.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406241442430.25702-100000@sweetums.bluetronic.net>
X-Time: trot.local; @940; Fri, 25 Jun 2004 17:34:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 02:46:39PM -0400, Ricky Beam wrote:
>On Thu, 24 Jun 2004, George Georgalis wrote:
>...
>>has caused pdflush to block IO, any access to /mnt and the process
>>does not return. other than the pdflush load of ~99% the box seems to
>>function normally. 2.6.7-bk6, seagate drive
>
>-bk6 is not new enough.  bk7 has the necessary max_sectors fix.  You
>may need to add your drive model to the sil_blacklist in
>drivers/scsi/sata_sil.c.

Okay, 2.6.7-bk8 has written 8Gb to the sda4 with SATA_SIL and still
going strong! "dd if=/dev/zero of=/mnt/zero-`date +%s`"

However at about 3Gb (if that is relevant) top segfaulted with a
non critical oops. top will not restart, but the box is otherwise
functioning well considering the write load.

Is there any way to determine the drive model without first connecting
with the other sata driver (as hdc) and using hdparm?


Unable to handle kernel NULL pointer dereference at virtual address 000000b4
 printing eip:
c017c78a
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c017c78a>]    Not tainted
EFLAGS: 00010286   (2.6.7-sta-bk8) 
EIP is at pid_alive+0xa/0x30
eax: 000000b8   ebx: d32b0310   ecx: 00000000   edx: 00000000
esi: 00000000   edi: ef7bb7a0   ebp: d22b1b40   esp: db473e4c
ds: 007b   es: 007b   ss: 0068
Process top (pid: 489, threadinfo=db472000 task=e60ac7c0)
Stack: c017cca4 00000000 d22b1b40 db473f18 ef7bb7a0 db473ec4 c0159754 d22b1b40 
       db473f18 eaa1f006 eaa1f009 db473ec4 db473f18 c0159cc5 db473f18 db473ecc 
       db473ec4 ef7b86e0 d22b1dfc ee655240 bffff000 c0141ec8 c15cd660 c013e95c 
Call Trace:
 [<c017cca4>] pid_revalidate+0x14/0xc0
 [<c0159754>] do_lookup+0x44/0x80
 [<c0159cc5>] link_path_walk+0x535/0xa20
 [<c0141ec8>] find_extend_vma+0x18/0x70
 [<c013e95c>] follow_page+0x8c/0xb0
 [<c013ea3c>] get_user_pages+0xbc/0x3d0
 [<c015a406>] path_lookup+0x86/0x1a0
 [<c015a6a9>] __user_walk+0x39/0x70
 [<c0155a95>] vfs_stat+0x15/0x60
 [<c02445dd>] copy_to_user+0x2d/0x40
 [<c0156151>] sys_stat64+0x11/0x30
 [<c014dcbd>] __fput+0x8d/0xf0
 [<c014c6c3>] filp_close+0x43/0x70
 [<c014c744>] sys_close+0x54/0x80
 [<c0105dc7>] syscall_call+0x7/0xb




Could this be related to "Unknown HZ value! (91) Assume 100." which
started showing up with VIA motherboards on 2.5.x (I think) on top or ps
commands.  When I researched it before, It never caused ill, had been
identified as a "kernel bug" but benign. I know nothing more.

ATM, ps also seg faults, here is a corresponding oops,

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000000b4
 printing eip:
c017c78a
*pde = 00000000
Oops: 0000 [#5]
PREEMPT 
CPU:    0
EIP:    0060:[<c017c78a>]    Not tainted
EFLAGS: 00010286   (2.6.7-sta-bk8) 
EIP is at pid_alive+0xa/0x30
eax: 000000b8   ebx: d32b0310   ecx: 00000000   edx: 00000000
esi: 00000000   edi: ef7bb7a0   ebp: d22b1b40   esp: ecc59e4c
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 3456, threadinfo=ecc58000 task=e60ac7c0)
Stack: c017cca4 00000000 d22b1b40 ecc59f18 ef7bb7a0 ecc59ec4 c0159754 d22b1b40 
       ecc59f18 cf499006 cf499009 ecc59ec4 ecc59f18 c0159cc5 ecc59f18 ecc59ecc 
       ecc59ec4 ef7b86e0 d22b1dfc ee655240 bffff000 c0141ec8 c15cd660 c013e95c 
Call Trace:
 [<c017cca4>] pid_revalidate+0x14/0xc0
 [<c0159754>] do_lookup+0x44/0x80
 [<c0159cc5>] link_path_walk+0x535/0xa20
 [<c0141ec8>] find_extend_vma+0x18/0x70
 [<c013e95c>] follow_page+0x8c/0xb0
 [<c013ea3c>] get_user_pages+0xbc/0x3d0
 [<c015a406>] path_lookup+0x86/0x1a0
 [<c015a6a9>] __user_walk+0x39/0x70
 [<c0155a95>] vfs_stat+0x15/0x60
 [<c02445dd>] copy_to_user+0x2d/0x40
 [<c0156151>] sys_stat64+0x11/0x30
 [<c014dcbd>] __fput+0x8d/0xf0
 [<c014c6c3>] filp_close+0x43/0x70
 [<c014c744>] sys_close+0x54/0x80
 [<c0105dc7>] syscall_call+0x7/0xb
Code: 39 82 b4 00 00 00 75 07 8b 82 bc 00 00 00 c3 0f 0b 04 03 72 


config attached. I wrote 25G of zero and killed the dd process, top and
ps still segfault. Thanks all for your help!

// George



-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

--3MwIy2ne0vdjdPXF
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="2.6.7-sta-bk8.config.gz"
Content-Transfer-Encoding: base64

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
UNXHhaVE/B9uWW9SU4MAAA==

--3MwIy2ne0vdjdPXF--

