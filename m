Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFPNBl>; Sun, 16 Jun 2002 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSFPNBl>; Sun, 16 Jun 2002 09:01:41 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:1234 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316210AbSFPNBj>; Sun, 16 Jun 2002 09:01:39 -0400
Date: Sun, 16 Jun 2002 09:03:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020616130301.GA1124@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops occured after rebooting into 2.5.21, compiling a kernel,
then init 6.

flushing ide devices: hda <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0199a8b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0199a8b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c02c1944   ebx: c02c192c   ecx: 00000000   edx: 00000000
esi: c025cc60   edi: 00000001   ebp: 00000001   esp: d01fde58
ds: 0018   es: 0018   ss: 0018
Stack: c02c192c c02c17d4 c0199d0e c02c192c c02c17d0 c01c6b1c c02c192c c02c17d0
       c01c072b c02c17d0 c025c77c 00000000 00000001 bffffd54 c011910e c025c77c
       00000001 00000000 d01fc000 080498c0 fee1dead c01193ee c02a1b48 00000001
Call Trace: [<c0199d0e>] [<c01c6b1c>] [<c01c072b>] [<c011910e>] [<c01193ee>]
   [<c01dbaa3>] [<c01d7ab5>] [<c01ffaac>] [<c01ffdb9>] [<c01d0e57>] [<c013c264>]
   [<c013ccfc>] [<c013b016>] [<c012c654>] [<c012b6f5>] [<c012b745>] [<c01069f7>]
Code: 89 4a 04 89 11 89 43 18 89 40 04 83 7e 38 00 74 09 53 8b 46


>>EIP; c0199a8b <device_detach+23/4c>   <=====

>>eax; c02c1944 <ide_hwifs+2a4/3d90>
>>ebx; c02c192c <ide_hwifs+28c/3d90>
>>esi; c025cc60 <idedisk_devdrv+0/60>
>>esp; d01fde58 <END_OF_CODE+ff35f3c/????>

Trace; c0199d0e <put_device+4a/7c>
Trace; c01c6b1c <idedisk_cleanup+1c/60>
Trace; c01c072b <ata_sys_notify+9f/d4>
Trace; c011910e <notifier_call_chain+1e/38>
Trace; c01193ee <sys_reboot+c2/1d0>
Trace; c01dbaa3 <rtmsg_ifinfo+6f/74>
Trace; c01d7ab5 <dev_change_flags+f1/fc>
Trace; c01ffaac <devinet_ioctl+348/6b4>
Trace; c01ffdb9 <devinet_ioctl+655/6b4>
Trace; c01d0e57 <sock_destroy_inode+13/18>
Trace; c013c264 <destroy_inode+2c/4c>
Trace; c013ccfc <generic_forget_inode+c4/cc>
Trace; c013b016 <dput+126/144>
Trace; c012c654 <fput+bc/e0>
Trace; c012b6f5 <filp_close+59/64>
Trace; c012b745 <sys_close+45/58>
Trace; c01069f7 <syscall_call+7/b>

Code;  c0199a8b <device_detach+23/4c>
00000000 <_EIP>:
Code;  c0199a8b <device_detach+23/4c>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0199a8e <device_detach+26/4c>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c0199a90 <device_detach+28/4c>
   5:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  c0199a93 <device_detach+2b/4c>
   8:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c0199a96 <device_detach+2e/4c>
   b:   83 7e 38 00               cmpl   $0x0,0x38(%esi)
Code;  c0199a9a <device_detach+32/4c>
   f:   74 09                     je     1a <_EIP+0x1a> c0199aa5 <device_detach+3d/4c>
Code;  c0199a9c <device_detach+34/4c>
  11:   53                        push   %ebx
Code;  c0199a9d <device_detach+35/4c>
  12:   8b 46 00                  mov    0x0(%esi),%eax


-- 
Randy Hron

