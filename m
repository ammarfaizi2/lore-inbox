Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbREWRLA>; Wed, 23 May 2001 13:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbREWRKu>; Wed, 23 May 2001 13:10:50 -0400
Received: from mrelay.cc.umr.edu ([131.151.1.89]:1038 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S263170AbREWRKo>;
	Wed, 23 May 2001 13:10:44 -0400
Message-ID: <F349BC4F5799D411ACE100D0B706B3BB768D16@umr-mail03.cc.umr.edu>
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: lot's of oops's on 2.4.4 in d_lookup/cached_lookup
Date: Wed, 23 May 2001 12:10:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a system monitoring box, running 2.4.4 with a few patches (ide,
inode-nr_unused, max-readahead, knfsd, and a couple of basic tuning opts w/o
code changes). Basically, the server runs anywhere from a few hours to a few
days, but always seems to get to a point where it gets tons of the following
type of oops. It is almost ALWAYS in d_lookup. It's not always the same
script, but generally is one of a set of scripts that get run repeatedly
every few minutes. check-all is a shell script that just runs a set of local
commands (/local/sysmon/check-XXXX.pl hostname args). 

The machine is running afs, but the call traces don't appear to be in afs
code.

Any ideas on what might be causing this?

Machines been checked with memtest86 all-tests, and came out clean. It's a
PIII-500 w/ 512MB, drives are on a promise ultra100, but drives are ultra66.

Please cc replies.

-- Nathan

May 23 10:53:44 sysmon kernel: Unable to handle kernel paging request at
virtual address 96000000
May 23 10:53:44 sysmon kernel: c01409f0
May 23 10:53:44 sysmon kernel: *pde = 00000000
May 23 10:53:44 sysmon kernel: Oops: 0000
May 23 10:53:44 sysmon kernel: CPU:    0
May 23 10:53:44 sysmon kernel: EIP:    0010:[d_lookup+100/260]
May 23 10:53:44 sysmon kernel: EIP:    0010:[<c01409f0>]
May 23 10:53:44 sysmon kernel: EFLAGS: 00010293
May 23 10:53:44 sysmon kernel: eax: c19a2108   ebx: 95ffffe8   ecx: 00000010
edx: c1980000
May 23 10:53:44 sysmon kernel: esi: 0022f9f5   edi: d582dcb0   ebp: 96000000
esp: d582dc4c
May 23 10:53:44 sysmon kernel: ds: 0018   es: 0018   ss: 0018
May 23 10:53:44 sysmon kernel: Process check-all (pid: 7409,
stackpage=d582d000)
May 23 10:53:44 sysmon kernel: Stack: 0022f9f5 c1890320 d582dcb0 cee07cad
c19a2108 cee07ca9 0022f9f5 00000003 
May 23 10:53:44 sysmon kernel:        c0138894 c1890320 d582dcb0 0022f9f5
c0138cf8 c1890320 d582dcb0 00000004 
May 23 10:53:44 sysmon kernel:        d582dd50 c1890320 dfcb8b20 cee07ca8
d582c000 00000001 d582c000 00000001 
May 23 10:53:44 sysmon kernel: Call Trace: [cached_lookup+16/84]
[path_walk+548/2076] [vfs_follow_link+251/376] [ext2_follow_link+23/28]
[path_walk+905/2076] [open_exec+39/196] [load_script+411/480] 
May 23 10:53:44 sysmon kernel: Call Trace: [<c0138894>] [<c0138cf8>]
[<c013b58b>] [<c0152dfb>] [<c0138e5d>] [<c0136eab>] [<c01445bb>] 
May 23 10:53:44 sysmon kernel:        [<c0144420>] [<c0122802>] [<c0128980>]
[<c0129935>] [<c01375ed>] [<c013787c>] [<c0137893>] [<c0105933>] 
May 23 10:53:44 sysmon kernel:        [<c0106be3>] 
May 23 10:53:44 sysmon kernel: Code: 8b 6d 00 8b 74 24 18 39 73 48 75 7c 8b
74 24 24 39 73 0c 75 

>>EIP; c01409f0 <d_lookup+64/104>   <=====
Trace; c0138894 <cached_lookup+10/54>
Trace; c0138cf8 <path_walk+224/81c>
Trace; c013b58b <vfs_follow_link+fb/178>
Trace; c0152dfb <ext2_follow_link+17/1c>
Trace; c0138e5d <path_walk+389/81c>
Trace; c0136eab <open_exec+27/c4>
Trace; c01445bb <load_script+19b/1e0>
Trace; c0144420 <load_script+0/1e0>
Trace; c0122802 <do_generic_file_read+57a/588>
Trace; c0128980 <free_shortage+1c/104>
Trace; c0129935 <__alloc_pages+cd/2c0>
Trace; c01375ed <search_binary_handler+65/17c>
Trace; c013787c <do_execve+178/1e8>
Trace; c0137893 <do_execve+18f/1e8>
Trace; c0105933 <sys_execve+2f/60>
Trace; c0106be3 <system_call+33/40>
Code;  c01409f0 <d_lookup+64/104>
00000000 <_EIP>:
Code;  c01409f0 <d_lookup+64/104>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c01409f3 <d_lookup+67/104>
   3:   8b 74 24 18               mov    0x18(%esp,1),%esi
Code;  c01409f7 <d_lookup+6b/104>
   7:   39 73 48                  cmp    %esi,0x48(%ebx)
Code;  c01409fa <d_lookup+6e/104>
   a:   75 7c                     jne    88 <_EIP+0x88> c0140a78
<d_lookup+ec/104>
Code;  c01409fc <d_lookup+70/104>
   c:   8b 74 24 24               mov    0x24(%esp,1),%esi
Code;  c0140a00 <d_lookup+74/104>
  10:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  c0140a03 <d_lookup+77/104>
  13:   75 00                     jne    15 <_EIP+0x15> c0140a05
<d_lookup+79/104>


------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
