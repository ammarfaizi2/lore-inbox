Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281331AbRKEUum>; Mon, 5 Nov 2001 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281332AbRKEUug>; Mon, 5 Nov 2001 15:50:36 -0500
Received: from [202.73.165.5] ([202.73.165.5]:384 "EHLO maravillo.q-linux.com")
	by vger.kernel.org with ESMTP id <S281331AbRKEUu0>;
	Mon, 5 Nov 2001 15:50:26 -0500
Date: Tue, 6 Nov 2001 04:50:14 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Cc: mike.maravillo@q-linux.com
Subject: 2.4.13-ac6: videodev/__release_region oops!
Message-ID: <20011106045014.A1361@maravillo.q-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# lsmod
Module                  Size  Used by
tuner                   8368   1  (autoclean)
bttv                   58864   0  (autoclean)
videodev                4672   3  (autoclean) [bttv]
i2c-algo-bit            7008   1  (autoclean) [bttv]
i2c-core               13440   0  (autoclean) [tuner bttv
i2c-algo-bit]
ipchains               31456   0 
ide-scsi                7808   0 
scsi_mod               51744   1  [ide-scsi]
ide-cd                 27248   0 
cdrom                  28192   0  [ide-cd]
nls_iso8859-1           2832   4  (autoclean)
nls_cp437               4352   4  (autoclean)
vfat                    9520   4  (autoclean)
fat                    30592   0  (autoclean) [vfat]
md                     49664   0  (unused)

# lsmod | xargs rmmod
rmmod: module Module is not loaded
rmmod: module Size is not loaded
rmmod: module Used is not loaded
rmmod: module by is not loaded
tuner: Device or resource busy
rmmod: module 8368 is not loaded
rmmod: module 1 is not loaded
rmmod: module (autoclean) is not loaded
xargs: rmmod: terminated by signal 11

Unable to handle kernel paging request at virtual address 80008004
c0118012
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0118012>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 80008000   ebx: c0002014   ecx: 80008000   edx: 80008000
esi: ec000fff   edi: ec000000   ebp: c5c6d000   esp: c4d3ff50
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 1289, stackpage=c4d3f000)
Stack: d0130000 00001000 c1430800 d0129062 c0239ff8 ec000000 00001000 02430800 
       c1430800 d012dae0 00000000 c01b663e c1430800 d0123000 c5c6d000 d012949a 
       d012dae0 c011589e d0123000 c5c6d000 00000000 c0114cfc d0123000 00000000 
Call Trace: [<d0130000>] [<d0129062>] [<d012dae0>] [<c01b663e>] [<d012949a>] 
   [<d012dae0>] [<c011589e>] [<c0114cfc>] [<c0106dd3>] 
Code: 8b 42 04 39 f8 77 f0 8b 4a 08 39 f1 72 e9 83 7a 0c 00 78 05 

>>EIP; c0118012 <__release_region+22/70>   <=====
Trace; d0130000 <[videodev].bss.end+edc1/24e21>
Trace; d0129062 <[videodev].bss.end+7e23/24e21>
Trace; d012dae0 <[videodev].bss.end+c8a1/24e21>
Trace; c01b663e <pci_unregister_driver+2e/50>
Trace; d012949a <[videodev].bss.end+825b/24e21>
Trace; d012dae0 <[videodev].bss.end+c8a1/24e21>
Trace; c011589e <free_module+1e/b0>
Trace; c0114cfc <sys_delete_module+11c/1e0>
Trace; c0106dd3 <system_call+33/40>
Code;  c0118012 <__release_region+22/70>
00000000 <_EIP>:
Code;  c0118012 <__release_region+22/70>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  c0118015 <__release_region+25/70>
   3:   39 f8                     cmp    %edi,%eax
Code;  c0118017 <__release_region+27/70>
   5:   77 f0                     ja     fffffff7 <_EIP+0xfffffff7> c0118009 <__release_region+19/70>
Code;  c0118019 <__release_region+29/70>
   7:   8b 4a 08                  mov    0x8(%edx),%ecx
Code;  c011801c <__release_region+2c/70>
   a:   39 f1                     cmp    %esi,%ecx
Code;  c011801e <__release_region+2e/70>
   c:   72 e9                     jb     fffffff7 <_EIP+0xfffffff7> c0118009 <__release_region+19/70>
Code;  c0118020 <__release_region+30/70>
   e:   83 7a 0c 00               cmpl   $0x0,0xc(%edx)
Code;  c0118024 <__release_region+34/70>
  12:   78 05                     js     19 <_EIP+0x19> c011802b <__release_region+3b/70>

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
