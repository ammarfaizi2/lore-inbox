Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSGHLI3>; Mon, 8 Jul 2002 07:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGHLI1>; Mon, 8 Jul 2002 07:08:27 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:50123 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S316774AbSGHLIQ>;
	Mon, 8 Jul 2002 07:08:16 -0400
Date: Mon, 8 Jul 2002 14:10:30 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: sync() OOPS in 2.4.18
Message-ID: <Pine.GSO.4.43.0207081406330.21356-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suddenly, sync started segfaulting. Some days uptime (previously  2
months, has been stable for 1.5 years). Running 2.4.18 since february,
no problem. But today, sync started oopsing and later dpkg went into D
state. Halt was impossible (oops). Captured this ksymopps output through
ssh (so disk reading worked). AMD Duron 600, ext2 filesystems.

ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 2000105, slice: 1000052
8139too Fast Ethernet driver 0.9.24
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0143fbf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0143fbf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c0215b9c   ecx: c9d32d48   edx: c166d868
esi: c9d32d40   edi: c166d860   ebp: c166d868   esp: d1907f8c
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 15093, stackpage=d1907000)
Stack: c166d800 00000001 bffffaf4 bffffa8c c166d860 c0144276 c166d800 00000000
       c0133427 00000000 d1906000 c0133467 00000000 c0106c6b bffffaf4 00000002
       4013fe68 00000001 bffffaf4 bffffa8c 00000024 0000002b 0000002b 00000024
Call Trace: [<c0144276>] [<c0133427>] [<c0133467>] [<c0106c6b>]
Code: 89 50 04 89 02 8b 03 89 48 04 89 46 08 89 59 04 89 0b 8d 86


>>EIP; c0143fbf <sync_inodes_sb+12f/1e0>   <=====

>>ebx; c0215b9c <inode_in_use+0/8>
>>ecx; c9d32d48 <_end+9a9d1bc/185c0474>
>>edx; c166d868 <_end+13d7cdc/185c0474>
>>esi; c9d32d40 <_end+9a9d1b4/185c0474>
>>edi; c166d860 <_end+13d7cd4/185c0474>
>>ebp; c166d868 <_end+13d7cdc/185c0474>
>>esp; d1907f8c <_end+11672400/185c0474>

Trace; c0144276 <sync_inodes+36/50>
Trace; c0133427 <fsync_dev+17/40>
Trace; c0133467 <sys_sync+7/10>
Trace; c0106c6b <system_call+33/38>

Code;  c0143fbf <sync_inodes_sb+12f/1e0>
00000000 <_EIP>:
Code;  c0143fbf <sync_inodes_sb+12f/1e0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0143fc2 <sync_inodes_sb+132/1e0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0143fc4 <sync_inodes_sb+134/1e0>
   5:   8b 03                     mov    (%ebx),%eax
Code;  c0143fc6 <sync_inodes_sb+136/1e0>
   7:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0143fc9 <sync_inodes_sb+139/1e0>
   a:   89 46 08                  mov    %eax,0x8(%esi)
Code;  c0143fcc <sync_inodes_sb+13c/1e0>
   d:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c0143fcf <sync_inodes_sb+13f/1e0>
  10:   89 0b                     mov    %ecx,(%ebx)
Code;  c0143fd1 <sync_inodes_sb+141/1e0>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0143fbf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0143fbf>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c0215b9c   ecx: c037fdc8   edx: c166d868
esi: c037fdc0   edi: c166d860   ebp: c166d868   esp: d1907f8c
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 15094, stackpage=d1907000)
Stack: c166d800 00000001 bffffaf4 bffffa8c c166d860 c0144276 c166d800 00000000
       c0133427 00000000 d1906000 c0133467 00000000 c0106c6b bffffaf4 00000002
       4013fe68 00000001 bffffaf4 bffffa8c 00000024 0000002b 0000002b 00000024
Call Trace: [<c0144276>] [<c0133427>] [<c0133467>] [<c0106c6b>]
Code: 89 50 04 89 02 8b 03 89 48 04 89 46 08 89 59 04 89 0b 8d 86


>>EIP; c0143fbf <sync_inodes_sb+12f/1e0>   <=====

>>ebx; c0215b9c <inode_in_use+0/8>
>>ecx; c037fdc8 <_end+ea23c/185c0474>
>>edx; c166d868 <_end+13d7cdc/185c0474>
>>esi; c037fdc0 <_end+ea234/185c0474>
>>edi; c166d860 <_end+13d7cd4/185c0474>
>>ebp; c166d868 <_end+13d7cdc/185c0474>
>>esp; d1907f8c <_end+11672400/185c0474>

Trace; c0144276 <sync_inodes+36/50>
Trace; c0133427 <fsync_dev+17/40>
Trace; c0133467 <sys_sync+7/10>
Trace; c0106c6b <system_call+33/38>

Code;  c0143fbf <sync_inodes_sb+12f/1e0>
00000000 <_EIP>:
Code;  c0143fbf <sync_inodes_sb+12f/1e0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0143fc2 <sync_inodes_sb+132/1e0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0143fc4 <sync_inodes_sb+134/1e0>
   5:   8b 03                     mov    (%ebx),%eax
Code;  c0143fc6 <sync_inodes_sb+136/1e0>
   7:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0143fc9 <sync_inodes_sb+139/1e0>
   a:   89 46 08                  mov    %eax,0x8(%esi)
Code;  c0143fcc <sync_inodes_sb+13c/1e0>
   d:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c0143fcf <sync_inodes_sb+13f/1e0>
  10:   89 0b                     mov    %ecx,(%ebx)
Code;  c0143fd1 <sync_inodes_sb+141/1e0>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0143fbf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0143fbf>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c0215b9c   ecx: cf912788   edx: c166d868
esi: cf912780   edi: c166d860   ebp: c166d868   esp: d1905f8c
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 15097, stackpage=d1905000)
Stack: c166d800 00000001 bffffaf4 bffffa8c c166d860 c0144276 c166d800 00000000
       c0133427 00000000 d1904000 c0133467 00000000 c0106cd7 bffffaf4 00000002
       4013fe68 00000001 bffffaf4 bffffa8c ffffffda 0000002b 0000002b 00000024
Call Trace: [<c0144276>] [<c0133427>] [<c0133467>] [<c0106cd7>]
Code: 89 50 04 89 02 8b 03 89 48 04 89 46 08 89 59 04 89 0b 8d 86


>>EIP; c0143fbf <sync_inodes_sb+12f/1e0>   <=====

>>ebx; c0215b9c <inode_in_use+0/8>
>>ecx; cf912788 <_end+f67cbfc/185c0474>
>>edx; c166d868 <_end+13d7cdc/185c0474>
>>esi; cf912780 <_end+f67cbf4/185c0474>
>>edi; c166d860 <_end+13d7cd4/185c0474>
>>ebp; c166d868 <_end+13d7cdc/185c0474>
>>esp; d1905f8c <_end+11670400/185c0474>

Trace; c0144276 <sync_inodes+36/50>
Trace; c0133427 <fsync_dev+17/40>
Trace; c0133467 <sys_sync+7/10>
Trace; c0106cd7 <tracesys+1f/23>

Code;  c0143fbf <sync_inodes_sb+12f/1e0>
00000000 <_EIP>:
Code;  c0143fbf <sync_inodes_sb+12f/1e0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0143fc2 <sync_inodes_sb+132/1e0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0143fc4 <sync_inodes_sb+134/1e0>
   5:   8b 03                     mov    (%ebx),%eax
Code;  c0143fc6 <sync_inodes_sb+136/1e0>
   7:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0143fc9 <sync_inodes_sb+139/1e0>
   a:   89 46 08                  mov    %eax,0x8(%esi)
Code;  c0143fcc <sync_inodes_sb+13c/1e0>
   d:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c0143fcf <sync_inodes_sb+13f/1e0>
  10:   89 0b                     mov    %ecx,(%ebx)
Code;  c0143fd1 <sync_inodes_sb+141/1e0>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0143fbf
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0143fbf>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c0215b9c   ecx: c315b6c8   edx: c166d868
esi: c315b6c0   edi: c166d860   ebp: c166d868   esp: d459bf8c
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 15245, stackpage=d459b000)
Stack: c166d800 00000001 bffffaf4 bffffa8c c166d860 c0144276 c166d800 00000000
       c0133427 00000000 d459a000 c0133467 00000000 c0106c6b bffffaf4 00000002
       4013fe68 00000001 bffffaf4 bffffa8c 00000024 0000002b 0000002b 00000024
Call Trace: [<c0144276>] [<c0133427>] [<c0133467>] [<c0106c6b>]
Code: 89 50 04 89 02 8b 03 89 48 04 89 46 08 89 59 04 89 0b 8d 86


>>EIP; c0143fbf <sync_inodes_sb+12f/1e0>   <=====

>>ebx; c0215b9c <inode_in_use+0/8>
>>ecx; c315b6c8 <_end+2ec5b3c/185c0474>
>>edx; c166d868 <_end+13d7cdc/185c0474>
>>esi; c315b6c0 <_end+2ec5b34/185c0474>
>>edi; c166d860 <_end+13d7cd4/185c0474>
>>ebp; c166d868 <_end+13d7cdc/185c0474>
>>esp; d459bf8c <_end+14306400/185c0474>

Trace; c0144276 <sync_inodes+36/50>
Trace; c0133427 <fsync_dev+17/40>
Trace; c0133467 <sys_sync+7/10>
Trace; c0106c6b <system_call+33/38>

Code;  c0143fbf <sync_inodes_sb+12f/1e0>
00000000 <_EIP>:
Code;  c0143fbf <sync_inodes_sb+12f/1e0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0143fc2 <sync_inodes_sb+132/1e0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0143fc4 <sync_inodes_sb+134/1e0>
   5:   8b 03                     mov    (%ebx),%eax
Code;  c0143fc6 <sync_inodes_sb+136/1e0>
   7:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0143fc9 <sync_inodes_sb+139/1e0>
   a:   89 46 08                  mov    %eax,0x8(%esi)
Code;  c0143fcc <sync_inodes_sb+13c/1e0>
   d:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c0143fcf <sync_inodes_sb+13f/1e0>
  10:   89 0b                     mov    %ecx,(%ebx)
Code;  c0143fd1 <sync_inodes_sb+141/1e0>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax


1 warning issued.  Results may not be reliable.

-- 
Meelis Roos (mroos@linux.ee)

