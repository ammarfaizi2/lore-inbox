Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUF2Irr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUF2Irr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUF2Irq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:47:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:2223 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265649AbUF2Iqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:46:46 -0400
Date: Tue, 29 Jun 2004 10:46:45 +0200 (MEST)
From: "Sebastian Slota" <SSlota@gmx.net>
To: George Georgalis <george@galis.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20040625213433.GB6502@trot.local>
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
X-Priority: 3 (Normal)
X-Authenticated: #576762
Message-ID: <29181.1088498805@www29.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm breaking the testing for some 3 months, I'm writing a work and I'm short
of time...

so far:
Tried Kernel with bk8:
 
root@t-rex root # cat /proc/mdstat
Personalities : [raid0] [raid5] [multipath]
md1 : active raid5 sdc3[2] sdb3[1] sda3[0]
261730816 blocks level 5, 128k chunk, algorithm 2 [3/3] [UUU]

md0 : active raid0 sdc2[2] sdb2[1] sda2[0]
73256064 blocks 128k chunks

unused devices: <none>

root@t-rex root # hdparm -tT /dev/md0

/dev/md0:
Timing buffer-cache reads: 3896 MB in 2.01 seconds = 1935.71 MB/sec
Timing buffered disk reads: 274 MB in 3.02 seconds = 90.68 MB/sec
root@t-rex root # hdparm -tT /dev/md1

/dev/md1:
Timing buffer-cache reads: 3760 MB in 2.00 seconds = 1879.35 MB/sec
Timing buffered disk reads: 206 MB in 3.01 seconds = 68.49 MB/secc 

Copy a DVD to HD, both went OK!
copy data from an ATA HD ( hda ) broke.

I read from ppl they're running linux on some older hardware, maybe thats
why it doesnt work... but ~25mb/s is nothing for me...
Also I hear about some patches to limit the speed to ~30MB/s.

I hope its kidding!

Back to M$. there it works.

S.


> On Thu, Jun 24, 2004 at 02:46:39PM -0400, Ricky Beam wrote:
> >On Thu, 24 Jun 2004, George Georgalis wrote:
> >...
> >>has caused pdflush to block IO, any access to /mnt and the process
> >>does not return. other than the pdflush load of ~99% the box seems to
> >>function normally. 2.6.7-bk6, seagate drive
> >
> >-bk6 is not new enough.  bk7 has the necessary max_sectors fix.  You
> >may need to add your drive model to the sil_blacklist in
> >drivers/scsi/sata_sil.c.
> 
> Okay, 2.6.7-bk8 has written 8Gb to the sda4 with SATA_SIL and still
> going strong! "dd if=/dev/zero of=/mnt/zero-`date +%s`"
> 
> However at about 3Gb (if that is relevant) top segfaulted with a
> non critical oops. top will not restart, but the box is otherwise
> functioning well considering the write load.
> 
> Is there any way to determine the drive model without first connecting
> with the other sata driver (as hdc) and using hdparm?
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 000000b4
>  printing eip:
> c017c78a
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c017c78a>]    Not tainted
> EFLAGS: 00010286   (2.6.7-sta-bk8) 
> EIP is at pid_alive+0xa/0x30
> eax: 000000b8   ebx: d32b0310   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: ef7bb7a0   ebp: d22b1b40   esp: db473e4c
> ds: 007b   es: 007b   ss: 0068
> Process top (pid: 489, threadinfo=db472000 task=e60ac7c0)
> Stack: c017cca4 00000000 d22b1b40 db473f18 ef7bb7a0 db473ec4 c0159754
> d22b1b40 
>        db473f18 eaa1f006 eaa1f009 db473ec4 db473f18 c0159cc5 db473f18
> db473ecc 
>        db473ec4 ef7b86e0 d22b1dfc ee655240 bffff000 c0141ec8 c15cd660
> c013e95c 
> Call Trace:
>  [<c017cca4>] pid_revalidate+0x14/0xc0
>  [<c0159754>] do_lookup+0x44/0x80
>  [<c0159cc5>] link_path_walk+0x535/0xa20
>  [<c0141ec8>] find_extend_vma+0x18/0x70
>  [<c013e95c>] follow_page+0x8c/0xb0
>  [<c013ea3c>] get_user_pages+0xbc/0x3d0
>  [<c015a406>] path_lookup+0x86/0x1a0
>  [<c015a6a9>] __user_walk+0x39/0x70
>  [<c0155a95>] vfs_stat+0x15/0x60
>  [<c02445dd>] copy_to_user+0x2d/0x40
>  [<c0156151>] sys_stat64+0x11/0x30
>  [<c014dcbd>] __fput+0x8d/0xf0
>  [<c014c6c3>] filp_close+0x43/0x70
>  [<c014c744>] sys_close+0x54/0x80
>  [<c0105dc7>] syscall_call+0x7/0xb
> 
> 
> 
> 
> Could this be related to "Unknown HZ value! (91) Assume 100." which
> started showing up with VIA motherboards on 2.5.x (I think) on top or ps
> commands.  When I researched it before, It never caused ill, had been
> identified as a "kernel bug" but benign. I know nothing more.
> 
> ATM, ps also seg faults, here is a corresponding oops,
> 
>  <1>Unable to handle kernel NULL pointer dereference at virtual address
> 000000b4
>  printing eip:
> c017c78a
> *pde = 00000000
> Oops: 0000 [#5]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c017c78a>]    Not tainted
> EFLAGS: 00010286   (2.6.7-sta-bk8) 
> EIP is at pid_alive+0xa/0x30
> eax: 000000b8   ebx: d32b0310   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: ef7bb7a0   ebp: d22b1b40   esp: ecc59e4c
> ds: 007b   es: 007b   ss: 0068
> Process ps (pid: 3456, threadinfo=ecc58000 task=e60ac7c0)
> Stack: c017cca4 00000000 d22b1b40 ecc59f18 ef7bb7a0 ecc59ec4 c0159754
> d22b1b40 
>        ecc59f18 cf499006 cf499009 ecc59ec4 ecc59f18 c0159cc5 ecc59f18
> ecc59ecc 
>        ecc59ec4 ef7b86e0 d22b1dfc ee655240 bffff000 c0141ec8 c15cd660
> c013e95c 
> Call Trace:
>  [<c017cca4>] pid_revalidate+0x14/0xc0
>  [<c0159754>] do_lookup+0x44/0x80
>  [<c0159cc5>] link_path_walk+0x535/0xa20
>  [<c0141ec8>] find_extend_vma+0x18/0x70
>  [<c013e95c>] follow_page+0x8c/0xb0
>  [<c013ea3c>] get_user_pages+0xbc/0x3d0
>  [<c015a406>] path_lookup+0x86/0x1a0
>  [<c015a6a9>] __user_walk+0x39/0x70
>  [<c0155a95>] vfs_stat+0x15/0x60
>  [<c02445dd>] copy_to_user+0x2d/0x40
>  [<c0156151>] sys_stat64+0x11/0x30
>  [<c014dcbd>] __fput+0x8d/0xf0
>  [<c014c6c3>] filp_close+0x43/0x70
>  [<c014c744>] sys_close+0x54/0x80
>  [<c0105dc7>] syscall_call+0x7/0xb
> Code: 39 82 b4 00 00 00 75 07 8b 82 bc 00 00 00 c3 0f 0b 04 03 72 
> 
> 
> config attached. I wrote 25G of zero and killed the dd process, top and
> ps still segfault. Thanks all for your help!
> 
> // George
> 
> 
> 
> -- 
> George Georgalis, Architect and administrator, Linux services. IXOYE
> http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
> Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631
> 

-- 
"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

