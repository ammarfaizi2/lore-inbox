Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbTCKVFe>; Tue, 11 Mar 2003 16:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261602AbTCKVFe>; Tue, 11 Mar 2003 16:05:34 -0500
Received: from mail-1.tiscali.it ([195.130.225.147]:5242 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S261598AbTCKVFc>;
	Tue, 11 Mar 2003 16:05:32 -0500
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Linux-2.4.20-pre4 with reiserfs
Date: Tue, 11 Mar 2003 22:16:12 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: reiserfs-list@namesys.com
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200303112216.12359.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this oops running the following:

mkreiserfs /dev/hdb3
mount /dev/hdb3 /test
mkdir /test/d
cd /test

`fsx-linux -c 2 linux-2.4.20.tar.bz2' on a console and
`fsstress -d -d -n 10000 -p 10' on a second console.

The oops happened just few seconds after I run `vmstat 1'
on third console.  Reproducible.

ksymoops 2.4.8 on i686 2.4.21-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar 11 21:46:45 odyssey kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000d
Mar 11 21:46:45 odyssey kernel: c0172a60
Mar 11 21:46:45 odyssey kernel: *pde = 00000000
Mar 11 21:46:45 odyssey kernel: Oops: 0000
Mar 11 21:46:45 odyssey kernel: CPU:    0
Mar 11 21:46:45 odyssey kernel: EIP:    0010:[<c0172a60>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 11 21:46:45 odyssey kernel: EFLAGS: 00010256
Mar 11 21:46:45 odyssey kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   
edx: 00000001
Mar 11 21:46:45 odyssey kernel: esi: 00000000   edi: ddf87d7c   ebp: 00000001   
esp: ddf87cf4
Mar 11 21:46:45 odyssey kernel: ds: 0018   es: 0018   ss: 0018
Mar 11 21:46:45 odyssey kernel: Process fsstress (pid: 6617, 
stackpage=ddf87000)
Mar 11 21:46:45 odyssey kernel: Stack: 00000001 ddf87e80 ddf87d7c ddf87e38 
00000001 00001000 c017355a cddb37c0 
Mar 11 21:46:45 odyssey kernel:        ddf87e80 00000001 00000000 ddf87db0 
dc8c4a00 00000037 ddf87df8 ddf87e80 
Mar 11 21:46:45 odyssey kernel:        00000000 00000100 cb577018 ddf87db0 
ddf87d78 00000000 00000001 00000000 
Mar 11 21:46:45 odyssey kernel: Call Trace:    [<c017355a>] [<c01729da>] 
[<c01329c1>] [<c0120343>] [<c0120182>]
Mar 11 21:46:45 odyssey kernel:   [<c01202c1>] [<c0175845>] [<c01729c0>] 
[<c0123cee>] [<c0125b30>] [<c012f986>]
Mar 11 21:46:45 odyssey kernel:   [<c0106d27>]
Mar 11 21:46:45 odyssey kernel: Code: 3b 42 0c 74 2b 8b 44 24 1c 8b 90 ac 00 
00 00 8b 42 30 50 51 


>>EIP; c0172a60 <convert_tail_for_hole+60/110>   <=====

>>edi; ddf87d7c <_end+1dcc0124/2056e408>
>>esp; ddf87cf4 <_end+1dcc009c/2056e408>

Trace; c017355a <reiserfs_get_block+a4a/e40>
Trace; c01729da <reiserfs_get_block_direct_io+1a/40>
Trace; c01329c1 <generic_direct_IO+c1/130>
Trace; c0120343 <mark_dirty_kiobuf+33/60>
Trace; c0120182 <get_user_pages+f2/180>
Trace; c01202c1 <map_user_kiobuf+b1/100>
Trace; c0175845 <reiserfs_direct_io+25/30>
Trace; c01729c0 <reiserfs_get_block_direct_io+0/40>
Trace; c0123cee <generic_file_direct_IO+1ae/230>
Trace; c0125b30 <generic_file_write+670/710>
Trace; c012f986 <sys_write+96/f0>
Trace; c0106d27 <system_call+33/38>

Code;  c0172a60 <convert_tail_for_hole+60/110>
00000000 <_EIP>:
Code;  c0172a60 <convert_tail_for_hole+60/110>   <=====
   0:   3b 42 0c                  cmp    0xc(%edx),%eax   <=====
Code;  c0172a63 <convert_tail_for_hole+63/110>
   3:   74 2b                     je     30 <_EIP+0x30> c0172a90 
<convert_tail_for_hole+90/110>
Code;  c0172a65 <convert_tail_for_hole+65/110>
   5:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  c0172a69 <convert_tail_for_hole+69/110>
   9:   8b 90 ac 00 00 00         mov    0xac(%eax),%edx
Code;  c0172a6f <convert_tail_for_hole+6f/110>
   f:   8b 42 30                  mov    0x30(%edx),%eax
Code;  c0172a72 <convert_tail_for_hole+72/110>
  12:   50                        push   %eax
Code;  c0172a73 <convert_tail_for_hole+73/110>
  13:   51                        push   %ecx


1 warning issued.  Results may not be reliable.

