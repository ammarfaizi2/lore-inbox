Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280032AbRKMPGx>; Tue, 13 Nov 2001 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280059AbRKMPGo>; Tue, 13 Nov 2001 10:06:44 -0500
Received: from smtp5.wanadoo.es ([62.37.236.139]:49834 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S280032AbRKMPGd>;
	Tue, 13 Nov 2001 10:06:33 -0500
From: Juan Minaya <jminaya@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 oops when mounting a vfat partition 
Date: Tue, 13 Nov 2001 16:01:46 +0100
Message-ID: <mta2vtou628s0fakmak0m6kvj0visq4jnu@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.4.14, if I mount a certain vfat partition, I receive the following
error message:

FAT: Did not find valid FSINFO signature.
Found signature1 0x4161ff00 signature2 0x61417272 sector=1.

And the same when unmounting. If I then mount it again, there is an oops.
With 2.4.13-ac7 I get the same error messages, but no oops. With 2.2.19
there is no problem.

The oops and the output of ksymoops follows (note that the kernel is
tainted because of vfat, which still doesn't have a license tag):


invalid operand: 0000
CPU:    0
EIP:    0010:[<c016409d>]    Tainted: P
EFLAGS: 00010246
eax: 00002000   ebx: 00000341   ecx: c022eb2c   edx: 00000000
esi: 00000000   edi: ccf5d7e0   ebp: 00000001   esp: cd337ccc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 513, stackpage=cd337000)
Stack: 00000341 ccf5d7e0 00000000 0007dfe0 c01b15e6 00002000 c023b444
cd336000
       c1428e20 00000e6c 00000000 00000000 00000000 00000341 c016472c
c023b424
       00000000 ccf5d7e0 00000001 00000000 00000000 00000001 c016477b
00000000
Call Trace: [<c01b15e6>] [<c016472c>] [<c016477b>] [<c01648c7>] [<c012e689>]
   [<d08179bb>] [<d081ef4b>] [<d081f3e0>] [<c0130bbf>] [<d081f420>]
[<c013e923>]
   [<c013110b>] [<d081f420>] [<c013f655>] [<c013f8db>] [<c013f74d>]
[<c013f978>]
   [<c0106b03>]

Code: 0f 0b 0f b6 47 15 0f b7 4f 14 8b 14 85 20 7d 23 c0 85 d2 75
 Segmentation fault


ksymoops 2.4.3 on i686 2.4.14.  Options used
     -v /home/juan/src/linux/vmlinux (specified)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c016409d>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00002000   ebx: 00000341   ecx: c022eb2c   edx: 00000000
esi: 00000000   edi: ccf5d7e0   ebp: 00000001   esp: cd337ccc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 513, stackpage=cd337000)
Stack: 00000341 ccf5d7e0 00000000 0007dfe0 c01b15e6 00002000 c023b444
cd336000
       c1428e20 00000e6c 00000000 00000000 00000000 00000341 c016472c
c023b424
       00000000 ccf5d7e0 00000001 00000000 00000000 00000001 c016477b
00000000
Call Trace: [<c01b15e6>] [<c016472c>] [<c016477b>] [<c01648c7>] [<c012e689>]
   [<d08179bb>] [<d081ef4b>] [<d081f3e0>] [<c0130bbf>] [<d081f420>]
[<c013e923>]
   [<c013110b>] [<d081f420>] [<c013f655>] [<c013f8db>] [<c013f74d>]
[<c013f978>]
   [<c0106b03>]
Code: 0f 0b 0f b6 47 15 0f b7 4f 14 8b 14 85 20 7d 23 c0 85 d2 75

>>EIP; c016409c <__make_request+7c/5f0>   <=====
Trace; c01b15e6 <clear_user+2e/40>
Trace; c016472c <generic_make_request+11c/12c>
Trace; c016477a <submit_bh+3e/60>
Trace; c01648c6 <ll_rw_block+12a/18c>
Trace; c012e688 <bread+30/64>
Trace; d08179ba <[fat]fat_read_super+13e/88c>
Trace; d081ef4a <[vfat]vfat_read_super+22/88>
Trace; d081f3e0 <[vfat]vfat_dir_inode_operations+0/40>
Trace; c0130bbe <get_sb_bdev+226/2cc>
Trace; d081f420 <[vfat]vfat_fs_type+0/1a>
Trace; c013e922 <set_devname+26/54>
Trace; c013110a <do_kern_mount+ae/13c>
Trace; d081f420 <[vfat]vfat_fs_type+0/1a>
Trace; c013f654 <do_add_mount+20/cc>
Trace; c013f8da <do_mount+13e/158>
Trace; c013f74c <copy_mount_options+4c/9c>
Trace; c013f978 <sys_mount+84/c4>
Trace; c0106b02 <system_call+32/38>
Code;  c016409c <__make_request+7c/5f0>
00000000 <_EIP>:
Code;  c016409c <__make_request+7c/5f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016409e <__make_request+7e/5f0>
   2:   0f b6 47 15               movzbl 0x15(%edi),%eax
Code;  c01640a2 <__make_request+82/5f0>
   6:   0f b7 4f 14               movzwl 0x14(%edi),%ecx
Code;  c01640a6 <__make_request+86/5f0>
   a:   8b 14 85 20 7d 23 c0      mov    0xc0237d20(,%eax,4),%edx
Code;  c01640ac <__make_request+8c/5f0>
  11:   85 d2                     test   %edx,%edx
Code;  c01640ae <__make_request+8e/5f0>
  13:   75 00                     jne    15 <_EIP+0x15> c01640b0
<__make_request+90/5f0>



Please CC: me in your answers as I'm not subscribed to the list. Thank you.

-- 
Juan Minaya  jminaya@bigfoot.com  PGPkeyIDs: RSA:9CC74BF1 DSS/DH:C547D845
