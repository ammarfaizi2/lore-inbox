Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUCIWOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUCIWOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:14:24 -0500
Received: from www.npw.net ([193.96.40.17]:6041 "EHLO mail.npw.net")
	by vger.kernel.org with ESMTP id S262235AbUCIWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:14:02 -0500
Message-ID: <404E41A7.80707@npw.net>
Date: Tue, 09 Mar 2004 23:13:59 +0100
From: Philipp Baer <phbaer@npw.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel oops
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have a strage problem with the kernel version 2.6.3. Whensoever
chkrootkit is run, the following kernel oops is thrown:

===
Unable to handle kernel paging request at virtual address a4805165
~ printing eip:
c017d43f
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c017d43f>]    Not tainted
EFLAGS: 00010286
EIP is at proc_pid_stat+0x8f/0x420
eax: 00000000   ebx: a4805101   ecx: c9b19000   edx: 69040406
esi: c6a739a0   edi: c9b24700   ebp: c9b0c000   esp: c9b0defc
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 20866, threadinfo=c9b0c000 task=c7743380)
Stack: c0137ef9 c1119bf8 00000000 c1119bf8 c03502f4 00000000 4002a080
53000000
~       00000000 00000000 00000000 00000000 00000000 00000000 00000000
c035051c
~       00000000 000000d0 c6ef5360 c6a739a0 ca60d760 4002a080 000003ff
c017a7ad
Call Trace:
~ [<c0137ef9>] buffered_rmqueue+0xd9/0x170
~ [<c017a7ad>] proc_info_read+0x4d/0x140
~ [<c014e55c>] vfs_read+0x8c/0xd0
~ [<c014e74d>] sys_read+0x2d/0x50
~ [<c010a8e7>] syscall_call+0x7/0xb

Code: 0f bf 43 64 0f bf 5b 66 c1 e0 14 09 d8 01 d0 89 c1 c1 e9 14
~ <6>note: ps[20866] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
~ [<c011a05a>] schedule+0x5aa/0x5b0
~ [<c013ff25>] unmap_page_range+0x35/0x60
~ [<c014013f>] unmap_vmas+0x1ef/0x240
~ [<c0143e26>] exit_mmap+0x66/0x180
~ [<c011b8d4>] mmput+0x64/0x80
~ [<c011f613>] do_exit+0x153/0x410
~ [<c010bee3>] die+0xc3/0xd0
~ [<c01180d4>] do_page_fault+0x1d4/0x51c
~ [<c0165617>] alloc_inode+0x17/0x150
~ [<c017b1ce>] proc_pid_make_inode+0x8e/0xc0
~ [<c017b72b>] proc_pident_lookup+0xeb/0x210
~ [<c017b884>] proc_tid_base_lookup+0x14/0x20
~ [<c0117f00>] do_page_fault+0x0/0x51c
~ [<c010b8ad>] error_code+0x2d/0x40
~ [<c017d43f>] proc_pid_stat+0x8f/0x420
~ [<c0137ef9>] buffered_rmqueue+0xd9/0x170
~ [<c017a7ad>] proc_info_read+0x4d/0x140
~ [<c014e55c>] vfs_read+0x8c/0xd0
~ [<c014e74d>] sys_read+0x2d/0x50
~ [<c010a8e7>] syscall_call+0x7/0xb
===

Systems (a bit outdated, ok...)
Pentium MMX 200, Intel 430TX, IDE, vanilla 2.6.3
Pentium MMX 233, Via Apollo VP2, IDE, vanilla 2.6.3
Pentium II 450, Intel 440BX, SCSI, vanilla 2.6.3

All with noACPI, PREEMPT, APIC and Debian Sid.

It seems that's something to do with preemtion... that's
all I can guess. Kernels <= 2.6.2 are doing very well
(with PREEMPT enabled)

Any hints?


ciao, phb

- --
Philipp Baer <phbaer@npw.net> [http://www.npw.net/]
gnupg-fingerprint: 16C7 84E8 5C5F C3D6 A8F1  A4DC E4CB A9A9 F5FA FF5D

``Only two things are infinite, the universe and human stupidity,
and I'm not sure about the former.'' -- A. Einstein

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFATkGm5MupqfX6/10RAsABAKDPH1smxy3T+oetiFrXZsB5B84J9gCg03aj
tu0GsCENIRsEXCgkVmCPlTc=
=g3Lh
-----END PGP SIGNATURE-----
