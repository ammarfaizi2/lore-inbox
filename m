Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFEIlf>; Wed, 5 Jun 2002 04:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSFEIlf>; Wed, 5 Jun 2002 04:41:35 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:27794 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S313416AbSFEIlc>;
	Wed, 5 Jun 2002 04:41:32 -0400
Date: Wed, 5 Jun 2002 10:41:31 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre9 Oops in find_inode()
Message-ID: <20020605084131.GD10536@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I've got the following Oops today. The server is K7 850,
1.1GB RAM (so highmem is enabled), 3c985B (Tigon II) Gigabit NIC,
IDE drives. The system has one ext2 and one ext3 volume, the ext2 one
is located on LVM logical volume. Server runs variety of tasks, but
the most intensive one is FTP server (ProFTPd using sendfile()).
Both ext2 and ext3 volume has been forced fsck'd during the last boot.
The HW problem is unlikely (this server worked more-on-less reliably
during at least a year).  More details available on request.

	The Oops follows:

ksymoops 2.3.4 on i686 2.4.19-pre9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre9/ (default)
     -m /lib/modules/2.4.19-pre9/System.map (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000028
c01425ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01425ba>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: f7d00000   ebx: 00000000   ecx: 00000011   edx: 00000585
esi: 00000000   edi: 0008c86a   ebp: f7d02c28   esp: dd0ffe98
ds: 0018   es: 0018   ss: 0018
Process updatedb (pid: 9128, stackpage=dd0ff000)
Stack: e6188940 f7d02c28 0008c86a f74eca00 c01429c1 f74eca00 0008c86a f7d02c28 
       00000000 00000000 c0161db6 ee070b80 e6188940 c0161df3 e6188940 ee070b80 
       ee070b80 e78f47c0 c0164782 f74eca00 0008c86a 00000000 00000000 b0c52be2 
Call Trace: [<c01429c1>] [<c0161db6>] [<c0161df3>] [<c0164782>] [<c0138b8d>] 
   [<c0139311>] [<c01388dd>] [<c0139933>] [<c01367e4>] [<c0109ccc>] [<c010877f>] 
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24 

>>EIP; c01425ba <find_inode+1a/50>   <=====
Trace; c01429c1 <iget4+41/c0>
Trace; c0161db6 <ext2_inode_by_name+16/60>
Trace; c0161df3 <ext2_inode_by_name+53/60>
Trace; c0164782 <ext2_lookup+42/70>
Trace; c0138b8d <real_lookup+4d/c0>
Trace; c0139311 <link_path_walk+611/890>
Trace; c01388dd <getname+5d/a0>
Trace; c0139933 <__user_walk+33/50>
Trace; c01367e4 <sys_lstat64+14/70>
Trace; c0109ccc <do_IRQ+9c/b0>
Trace; c010877f <system_call+33/38>
Code;  c01425ba <find_inode+1a/50>
00000000 <_EIP>:
Code;  c01425ba <find_inode+1a/50>   <=====
   0:   39 7e 28                  cmp    %edi,0x28(%esi)   <=====
Code;  c01425bd <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425bf <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425c3 <find_inode+23/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01425c9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425cb <find_inode+2b/50>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000028 printing eip:
c01425ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01425ba>]    Not tainted
EFLAGS: 00010217
eax: f7d00000   ebx: 00000000   ecx: 00000011   edx: 00000585
esi: 00000000   edi: 0048c84a   ebp: f7d02c28   esp: d3303e98
ds: 0018   es: 0018   ss: 0018
Process proftpd (pid: 6838, stackpage=d3303000)
Stack: d20f2e40 f7d02c28 0048c84a f74eca00 c01429c1 f74eca00 0048c84a f7d02c28 
       00000000 00000000 c0161db6 e32cfa40 d20f2e40 c0161df3 d20f2e40 e32cfa40 
       e32cfa40 e5da6540 c0164782 f74eca00 0048c84a 00000000 00000000 44e3f8e6 
Call Trace: [<c01429c1>] [<c0161db6>] [<c0161df3>] [<c0164782>] [<c0138b8d>] 
   [<c0139311>] [<c01388dd>] [<c0139933>] [<c01367e4>] [<c0109ccc>] [<c010877f>] 
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24 

>>EIP; c01425ba <find_inode+1a/50>   <=====
Trace; c01429c1 <iget4+41/c0>
Trace; c0161db6 <ext2_inode_by_name+16/60>
Trace; c0161df3 <ext2_inode_by_name+53/60>
Trace; c0164782 <ext2_lookup+42/70>
Trace; c0138b8d <real_lookup+4d/c0>
Trace; c0139311 <link_path_walk+611/890>
Trace; c01388dd <getname+5d/a0>
Trace; c0139933 <__user_walk+33/50>
Trace; c01367e4 <sys_lstat64+14/70>
Trace; c0109ccc <do_IRQ+9c/b0>
Trace; c010877f <system_call+33/38>
Code;  c01425ba <find_inode+1a/50>
00000000 <_EIP>:
Code;  c01425ba <find_inode+1a/50>   <=====
   0:   39 7e 28                  cmp    %edi,0x28(%esi)   <=====
Code;  c01425bd <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425bf <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425c3 <find_inode+23/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01425c9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425cb <find_inode+2b/50>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c01425ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01425ba>]    Not tainted
EFLAGS: 00010217
eax: f7d00000   ebx: 00000000   ecx: 00000011   edx: 00000585
esi: 00000000   edi: 016ec7b7   ebp: f7d02c28   esp: e3481e98
ds: 0018   es: 0018   ss: 0018
Process find (pid: 4310, stackpage=e3481000)
Stack: cee59ec0 f7d02c28 016ec7b7 f74eca00 c01429c1 f74eca00 016ec7b7 f7d02c28 
       00000000 00000000 c0161db6 c8164b00 cee59ec0 c0161df3 cee59ec0 c8164b00 
       c8164b00 f2509ec0 c0164782 f74eca00 016ec7b7 00000000 00000000 cb15fc13 
Call Trace: [<c01429c1>] [<c0161db6>] [<c0161df3>] [<c0164782>] [<c0138b8d>] 
   [<c0139311>] [<c01388dd>] [<c0139933>] [<c01367e4>] [<c010877f>] 
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24 

>>EIP; c01425ba <find_inode+1a/50>   <=====
Trace; c01429c1 <iget4+41/c0>
Trace; c0161db6 <ext2_inode_by_name+16/60>
Trace; c0161df3 <ext2_inode_by_name+53/60>
Trace; c0164782 <ext2_lookup+42/70>
Trace; c0138b8d <real_lookup+4d/c0>
Trace; c0139311 <link_path_walk+611/890>
Trace; c01388dd <getname+5d/a0>
Trace; c0139933 <__user_walk+33/50>
Trace; c01367e4 <sys_lstat64+14/70>
Trace; c010877f <system_call+33/38>
Code;  c01425ba <find_inode+1a/50>
00000000 <_EIP>:
Code;  c01425ba <find_inode+1a/50>   <=====
   0:   39 7e 28                  cmp    %edi,0x28(%esi)   <=====
Code;  c01425bd <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425bf <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425c3 <find_inode+23/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01425c9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425cb <find_inode+2b/50>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

Unable to handle kernel paging request at virtual address 3db113c3
c01425ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01425ba>]    Not tainted
EFLAGS: 00010203
eax: f7d00000   ebx: 3db1139b   ecx: 00000011   edx: 00000585
esi: 3db1139b   edi: 012ec7d7   ebp: f7d02c28   esp: ebda7e98
ds: 0018   es: 0018   ss: 0018
Process proftpd (pid: 23472, stackpage=ebda7000)
Stack: e915e1c0 f7d02c28 012ec7d7 f74eca00 c01429c1 f74eca00 012ec7d7 f7d02c28 
       00000000 00000000 c0161db6 d5b8e080 e915e1c0 c0161df3 e915e1c0 d5b8e080 
       d5b8e080 dde8d140 c0164782 f74eca00 012ec7d7 00000000 00000000 21ca9f39 
Call Trace: [<c01429c1>] [<c0161db6>] [<c0161df3>] [<c0164782>] [<c0138b8d>] 
   [<c0139311>] [<c01388dd>] [<c0139933>] [<c01367e4>] [<c010877f>] 
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24 

>>EIP; c01425ba <find_inode+1a/50>   <=====
Trace; c01429c1 <iget4+41/c0>
Trace; c0161db6 <ext2_inode_by_name+16/60>
Trace; c0161df3 <ext2_inode_by_name+53/60>
Trace; c0164782 <ext2_lookup+42/70>
Trace; c0138b8d <real_lookup+4d/c0>
Trace; c0139311 <link_path_walk+611/890>
Trace; c01388dd <getname+5d/a0>
Trace; c0139933 <__user_walk+33/50>
Trace; c01367e4 <sys_lstat64+14/70>
Trace; c010877f <system_call+33/38>
Code;  c01425ba <find_inode+1a/50>
00000000 <_EIP>:
Code;  c01425ba <find_inode+1a/50>   <=====
   0:   39 7e 28                  cmp    %edi,0x28(%esi)   <=====
Code;  c01425bd <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425bf <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425c3 <find_inode+23/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01425c9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425cb <find_inode+2b/50>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

Unable to handle kernel paging request at virtual address a6ba0f1f
c01425ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01425ba>]    Not tainted
EFLAGS: 00010297
eax: f7d00000   ebx: a6ba0ef7   ecx: 00000011   edx: 00000585
esi: a6ba0ef7   edi: 0140c7ce   ebp: f7d02c28   esp: ce0c1e98
ds: 0018   es: 0018   ss: 0018
Process proftpd (pid: 15522, stackpage=ce0c1000)
Stack: d2f85640 f7d02c28 0140c7ce f74eca00 c01429c1 f74eca00 0140c7ce f7d02c28 
       00000000 00000000 c0161db6 ea5c78c0 d2f85640 c0161df3 d2f85640 ea5c78c0 
       ea5c78c0 dccab240 c0164782 f74eca00 0140c7ce 00000000 00000000 94401d41 
Call Trace: [<c01429c1>] [<c0161db6>] [<c0161df3>] [<c0164782>] [<c0138b8d>] 
   [<c0139311>] [<c01388dd>] [<c0139933>] [<c01367e4>] [<c010877f>] 
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24 

>>EIP; c01425ba <find_inode+1a/50>   <=====
Trace; c01429c1 <iget4+41/c0>
Trace; c0161db6 <ext2_inode_by_name+16/60>
Trace; c0161df3 <ext2_inode_by_name+53/60>
Trace; c0164782 <ext2_lookup+42/70>
Trace; c0138b8d <real_lookup+4d/c0>
Trace; c0139311 <link_path_walk+611/890>
Trace; c01388dd <getname+5d/a0>
Trace; c0139933 <__user_walk+33/50>
Trace; c01367e4 <sys_lstat64+14/70>
Trace; c010877f <system_call+33/38>
Code;  c01425ba <find_inode+1a/50>
00000000 <_EIP>:
Code;  c01425ba <find_inode+1a/50>   <=====
   0:   39 7e 28                  cmp    %edi,0x28(%esi)   <=====
Code;  c01425bd <find_inode+1d/50>
   3:   75 f1                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425bf <find_inode+1f/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01425c3 <find_inode+23/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01425c9 <find_inode+29/50>
   f:   75 e5                     jne    fffffff6 <_EIP+0xfffffff6> c01425b0 <find_inode+10/50>
Code;  c01425cb <find_inode+2b/50>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


1 warning issued.  Results may not be reliable.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
