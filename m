Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWHDIWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHDIWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWHDIWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:22:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:36065 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030193AbWHDIWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:22:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W7Qy7/NBui2EOMnYo7NczZTKKZPdr/R58DwqZ5LirJDHxzNlnDbuwX6Zt1ty8a+ecwYVuX1aWRcondyF4WwcW9OtxKyIuZ8wY/o/gzxiKMNI//1S+mYs2HXM7V1baofUgpkZZsf6gz4cKqBKU4lHltV5HXwcqtn/Zn8Ps1dkWxw=
Message-ID: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
Date: Fri, 4 Aug 2006 10:22:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: xfs-masters@oss.sgi.com, nathans@sgi.com, xfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit a BUG that looks XFS related.

The machine is running 2.6.18-rc3-git3

(more info below the BUG messages)


BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000078
 printing eip:
c01e64d7
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: sky2 piix ide_core eeprom
CPU:    0
EIP:    0060:[<c01e64d7>]    Not tainted VLI
EFLAGS: 00010293   (2.6.18-rc3-git3 #1)
EIP is at xfs_btree_init_cursor+0x12e/0x16b
eax: eb6e6690   ebx: 00000000   ecx: eb6e6690   edx: 0000008c
esi: 00000000   edi: 00000000   ebp: f76d0800   esp: d5ffad20
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 24769, ti=d5ffa000 task=f3ef7ab0 task.ti=d5ffa000)
Stack: cd88a150 00000000 00000019 0000001f 00000000 c01ca335 00000007 00000000
       00000000 00000000 c6d49e10 f76d0800 00000013 00000007 00000000 cd88a150
       ecc90bb4 00000060 00000006 eebd9a80 0000008c 00000009 c87faf1c 00000000
Call Trace:
 [<c01ca335>] xfs_free_ag_extent+0x44/0x667
 [<c01cb775>] xfs_free_extent+0xda/0xf4
 [<c01dce50>] xfs_bmap_finish+0x107/0x185
 [<c021b0d9>] xfs_remove+0x2a8/0x456
 [<c0226035>] xfs_vn_unlink+0x23/0x53
 [<c016513b>] vfs_unlink+0x88/0x8c
 [<c01651d4>] do_unlinkat+0x95/0xfb
 [<c0102ae3>] syscall_call+0x7/0xb
 [<b7eb705d>] 0xb7eb705d
 [<c01ca335>] xfs_free_ag_extent+0x44/0x667
 [<c01cb775>] xfs_free_extent+0xda/0xf4
 [<c021f362>] kmem_zone_alloc+0x50/0xb9
 [<c0205526>] xfs_log_reserve+0x6c/0xc7
 [<c021f3f1>] kmem_zone_zalloc+0x26/0x51
 [<c01dce50>] xfs_bmap_finish+0x107/0x185
 [<c021b0d9>] xfs_remove+0x2a8/0x456
 [<c0226035>] xfs_vn_unlink+0x23/0x53
 [<c0214fe5>] xfs_dir_lookup_int+0xa3/0xfa
 [<c01fb1ac>] xfs_iunlock+0x7b/0x84
 [<c0372666>] __mutex_lock_slowpath+0x159/0x1d7
 [<c016c22d>] d_splice_alias+0xb5/0xc2
 [<c016513b>] vfs_unlink+0x88/0x8c
 [<c01651d4>] do_unlinkat+0x95/0xfb
 [<c0111296>] do_page_fault+0x12f/0x4e1
 [<c0102ae3>] syscall_call+0x7/0xb
Code: 83 86 01 00 00 84 c0 74 98 8b 53 14 0f b6 c0 c1 e0 03 0f b7 92
7c 02 00 00 66 29 c2 eb 83 8b 47 78 8b 58 18 0f cb e9 0f ff ff ff <8b>
47 78 8b 5c b0 1c eb f0 8b 44 24 24 85 c0 75 23 8b 44 24 20
EIP: [<c01e64d7>] xfs_btree_init_cursor+0x12e/0x16b SS:ESP 0068:d5ffad20
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000078
 printing eip:
c01e64d7
*pde = 00000000
Oops: 0000 [#2]
SMP
Modules linked in: sky2 piix ide_core eeprom
CPU:    0
EIP:    0060:[<c01e64d7>]    Not tainted VLI
EFLAGS: 00010293   (2.6.18-rc3-git3 #1)
EIP is at xfs_btree_init_cursor+0x12e/0x16b
eax: eb6e6118   ebx: 00000000   ecx: eb6e6118   edx: 0000008c
esi: 00000000   edi: 00000000   ebp: f76d0800   esp: d1e25d20
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 24954, ti=d1e25000 task=f33b7030 task.ti=d1e25000)
Stack: cd49c980 00000000 00000019 00000005 00000000 c01ca335 00000001 00000000
       00000000 00000000 c7ffde10 f76d0800 00000013 00000001 00000000 cd49c980
       e085e4b4 00000060 00000006 ed757dc0 0000008c 00000009 c87fabd4 00000000
Call Trace:
 [<c01ca335>] xfs_free_ag_extent+0x44/0x667
 [<c01cb775>] xfs_free_extent+0xda/0xf4
 [<c01dce50>] xfs_bmap_finish+0x107/0x185
 [<c021b0d9>] xfs_remove+0x2a8/0x456
 [<c0226035>] xfs_vn_unlink+0x23/0x53
 [<c016513b>] vfs_unlink+0x88/0x8c
 [<c01651d4>] do_unlinkat+0x95/0xfb
 [<c0102ae3>] syscall_call+0x7/0xb
 [<b7f2405d>] 0xb7f2405d
 [<c01ca335>] xfs_free_ag_extent+0x44/0x667
 [<c01cb775>] xfs_free_extent+0xda/0xf4
 [<c021f362>] kmem_zone_alloc+0x50/0xb9
 [<c0205526>] xfs_log_reserve+0x6c/0xc7
 [<c021f3f1>] kmem_zone_zalloc+0x26/0x51
 [<c01dce50>] xfs_bmap_finish+0x107/0x185
 [<c021b0d9>] xfs_remove+0x2a8/0x456
 [<c0226035>] xfs_vn_unlink+0x23/0x53
 [<c0214fe5>] xfs_dir_lookup_int+0xa3/0xfa
 [<c01fb1ac>] xfs_iunlock+0x7b/0x84
 [<c0372666>] __mutex_lock_slowpath+0x159/0x1d7
 [<c016c22d>] d_splice_alias+0xb5/0xc2
 [<c016513b>] vfs_unlink+0x88/0x8c
 [<c01651d4>] do_unlinkat+0x95/0xfb
 [<c0111296>] do_page_fault+0x12f/0x4e1
 [<c0102ae3>] syscall_call+0x7/0xb
Code: 83 86 01 00 00 84 c0 74 98 8b 53 14 0f b6 c0 c1 e0 03 0f b7 92
7c 02 00 00 66 29 c2 eb 83 8b 47 78 8b 58 18 0f cb e9 0f ff ff ff <8b>
47 78 8b 5c b0 1c eb f0 8b 44 24 24 85 c0 75 23 8b 44 24 20
EIP: [<c01e64d7>] xfs_btree_init_cursor+0x12e/0x16b SS:ESP 0068:d1e25d20


# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6388.63

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3192.358
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6384.44


# scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux server 2.6.18-rc3-git3 #1 SMP Thu Aug 3 13:28:08 CEST 2006 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
xfsprogs               2.6.20
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         sky2 piix ide_core eeprom


The box has 28 XFS filesystems of various sizes (each between 50GB and
3.5TB) mounted. These filesystems are on LVM2 and each physical volume
that LVM2 sees is made up of a RAID1 mirror of two disks created by a
3ware ATA-RAID controller.


Any hints as to how I can resolve this problem would be very welcome.
It would also be nice to know if I should expect filesystem corruption
from this.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
