Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288902AbSAFWsM>; Sun, 6 Jan 2002 17:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288936AbSAFWsD>; Sun, 6 Jan 2002 17:48:03 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:29446 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S288902AbSAFWrw>;
	Sun, 6 Jan 2002 17:47:52 -0500
Date: Sun, 6 Jan 2002 23:46:33 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [2nd Oops] 2.4.17, looks ext3 related
Message-ID: <20020106224633.GA725@asterix>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more oopses occured this evening after a  strange behaviour:

A few hours ago i noticed that the system load was stable around 1, but
according to top no process was responsible. I just ignored it but 
then vim got stuck when quitting it inside a xterm. What followed were 3
oopses of different processes (see ksymoops decoding below).

Somewhere between the 2nd and the 3rd oops (i'm NOT exactly shure when) the 
system load went up to around 7. Again no, process seemed responsible.

This was when also a simple login shell (but not on all VC's) got stuck.
I shutdown and restarted the system at this point.

For system details see MSGID <20020105144005.GA20619@obelix.gallien.de>

Bye, Stefan

>From /var/log/message :

Jan  6 19:58:46 asterix kernel:  printing eip:
Jan  6 19:58:46 asterix kernel: c012ea98
Jan  6 19:58:46 asterix kernel: Oops: 0000
Jan  6 19:58:46 asterix kernel: CPU:    0
Jan  6 19:58:46 asterix kernel: EIP:    0010:[get_hash_table+104/144]
Not tainted
Jan  6 19:58:46 asterix kernel: EFLAGS: 00010202
Jan  6 19:58:46 asterix kernel: eax: c1e40000   ebx: 00000004   ecx:
0000c14a   edx: 0000c14a
Jan  6 19:58:46 asterix kernel: esi: 0000000a   edi: 00002102   ebp:
00080d14   esp: f6997df0
Jan  6 19:58:46 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 19:58:46 asterix kernel: Process qmgr (pid: 360,
stackpage=f6997000)
Jan  6 19:58:46 asterix kernel: Stack: 00002102 00001000 00080d14
00000000 00000800 c012f158 00002102 00080d14
Jan  6 19:58:46 asterix kernel:        00001000 00000000 00000000
00000000 c014c6b4 00002102 00080d14 00001000
Jan  6 19:58:46 asterix kernel:        00000000 f6997f18 f6604300
00000000 f6997e9c 00000000 e9604200 00000000
Jan  6 19:58:46 asterix kernel: Call Trace: [getblk+24/64]
[ext3_getblk+180/608] [journal_stop+405/432] [ext3_dirty_inode+147/208]
[ext3_bread+35/128]
Jan  6 19:58:46 asterix kernel:    [ext3_readdir+150/912]
[permission+42/48] [vfs_readdir+91/128] [filldir64+0/368]
[sys_getdents64+79/272] [filldir64+0/368]
Jan  6 19:58:46 asterix kernel:    [sys_fcntl64+128/144]
[system_call+51/56]
Jan  6 19:58:46 asterix kernel:
Jan  6 19:58:46 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44
24 20 75 e9 66 39 7a 0c 75
Jan  6 20:26:42 asterix -- MARK --

Ksymoops decoded :

ksymoops 2.4.1 on i686 2.4.17-a1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-a1/ (default)
     -m /boot/System.map-2.4.17-a1 (specified)

Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says fa8927d0, /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o says fa891c40.  Ignoring /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says fa885924, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885604.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says fa885928, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885608.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says fa88592c, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88560c.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says fa885920, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885600.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Jan  6 19:58:46 asterix kernel: c012ea98
Jan  6 19:58:46 asterix kernel: Oops: 0000
Jan  6 19:58:46 asterix kernel: CPU:    0
Jan  6 19:58:46 asterix kernel: EIP:    0010:[get_hash_table+104/144]    Not tainted
Jan  6 19:58:46 asterix kernel: EFLAGS: 00010202
Jan  6 19:58:46 asterix kernel: eax: c1e40000   ebx: 00000004   ecx: 0000c14a   edx: 0000c14a
Jan  6 19:58:46 asterix kernel: esi: 0000000a   edi: 00002102   ebp: 00080d14   esp: f6997df0
Jan  6 19:58:46 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 19:58:46 asterix kernel: Process qmgr (pid: 360, stackpage=f6997000)
Jan  6 19:58:46 asterix kernel: Stack: 00002102 00001000 00080d14 00000000 00000800 c012f158 00002102 00080d14
Jan  6 19:58:46 asterix kernel:        00001000 00000000 00000000 00000000 c014c6b4 00002102 00080d14 00001000
Jan  6 19:58:46 asterix kernel:        00000000 f6997f18 f6604300 00000000 f6997e9c 00000000 e9604200 00000000
Jan  6 19:58:46 asterix kernel: Call Trace: [getblk+24/64] [ext3_getblk+180/608] [journal_stop+405/432] [ext3_dirty_inode+147/208] [ext3_bread+35/128]
Jan  6 19:58:46 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44 24 20 75 e9 66 39 7a 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
   3:   75 f3                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  00000005 Before first symbol
   5:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  00000009 Before first symbol
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  0000000d Before first symbol
   d:   75 e9                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  0000000f Before first symbol
   f:   66 39 7a 0c               cmp    %di,0xc(%edx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


5 warnings issued.  Results may not be reliable.

-----------------------------------------------------

2nd Oops from /var/log/messages:

Jan  6 20:26:42 asterix -- MARK --
Jan  6 21:57:31 asterix kernel:  <1>Unable to handle kernel paging
request at virtual address 0000c14e
Jan  6 21:57:31 asterix kernel:  printing eip:
Jan  6 21:57:31 asterix kernel: c012ea98
Jan  6 21:57:31 asterix kernel: Oops: 0000
Jan  6 21:57:31 asterix kernel: CPU:    0
Jan  6 21:57:31 asterix kernel: EIP:    0010:[get_hash_table+104/144]
Not tainted
Jan  6 21:57:31 asterix kernel: EFLAGS: 00010202
Jan  6 21:57:31 asterix kernel: eax: c1e40000   ebx: 00000004   ecx:
0000c14a   edx: 0000c14a
Jan  6 21:57:31 asterix kernel: esi: 0000000a   edi: 00002102   ebp:
00020c51   esp: f4f05df0
Jan  6 21:57:31 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 21:57:31 asterix kernel: Process find (pid: 3039,
stackpage=f4f05000)
Jan  6 21:57:31 asterix kernel: Stack: 00002102 00001000 00020c51
00000000 00000800 c012f158 00002102 00020c51
Jan  6 21:57:31 asterix kernel:        00001000 00000000 00000000
00000000 c014c6b4 00002102 00020c51 00001000
Jan  6 21:57:31 asterix kernel:        00000000 f4f05f18 e56f2c40
00000000 0002000b 00000004 0000a5a0 c012f158
Jan  6 21:57:31 asterix kernel: Call Trace: [getblk+24/64]
[ext3_getblk+180/608] [getblk+24/64] [ext3_get_inode_loc+280/384]
[ext3_read_inode+22/704]
Jan  6 21:57:31 asterix kernel:    [ext3_read_inode+424/704]
[ext3_bread+35/128] [ext3_readdir+150/912] [vfs_permission+121/256]
[permission+42/48] [vfs_readdir+91/128]
Jan  6 21:57:31 asterix kernel:    [filldir64+0/368]
[sys_getdents64+79/272] [filldir64+0/368] [sys_fcntl64+128/144]
[system_call+51/56]
Jan  6 21:57:31 asterix kernel:
Jan  6 21:57:31 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44
24 20 75 e9 66 39 7a 0c 75
Jan  6 22:10:51 asterix -- MARK --

and its ksymoops decoding:

ksymoops 2.4.1 on i686 2.4.17-a1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-a1/ (default)
     -m /boot/System.map-2.4.17-a1 (specified)

Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says fa8927d0, /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o says fa891c40.  Ignoring /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says fa885924, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885604.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says fa885928, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885608.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says fa88592c, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88560c.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says fa885920, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885600.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Jan  6 21:57:31 asterix kernel:  <1>Unable to handle kernel paging request at virtual address 0000c14e
Jan  6 21:57:31 asterix kernel: c012ea98
Jan  6 21:57:31 asterix kernel: Oops: 0000
Jan  6 21:57:31 asterix kernel: CPU:    0
Jan  6 21:57:31 asterix kernel: EIP:    0010:[get_hash_table+104/144]    Not tainted
Jan  6 21:57:31 asterix kernel: EFLAGS: 00010202
Jan  6 21:57:31 asterix kernel: eax: c1e40000   ebx: 00000004   ecx: 0000c14a   edx: 0000c14a
Jan  6 21:57:31 asterix kernel: esi: 0000000a   edi: 00002102   ebp: 00020c51   esp: f4f05df0
Jan  6 21:57:31 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 21:57:31 asterix kernel: Process find (pid: 3039, stackpage=f4f05000)
Jan  6 21:57:31 asterix kernel: Stack: 00002102 00001000 00020c51 00000000 00000800 c012f158 00002102 00020c51
Jan  6 21:57:31 asterix kernel:        00001000 00000000 00000000 00000000 c014c6b4 00002102 00020c51 00001000
Jan  6 21:57:31 asterix kernel:        00000000 f4f05f18 e56f2c40 00000000 0002000b 00000004 0000a5a0 c012f158
Jan  6 21:57:31 asterix kernel: Call Trace: [getblk+24/64] [ext3_getblk+180/608] [getblk+24/64] [ext3_get_inode_loc+280/384] [ext3_read_inode+22/704]
Jan  6 21:57:31 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44 24 20 75 e9 66 39 7a 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
   3:   75 f3                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  00000005 Before first symbol
   5:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  00000009 Before first symbol
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  0000000d Before first symbol
   d:   75 e9                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  0000000f Before first symbol
   f:   66 39 7a 0c               cmp    %di,0xc(%edx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


5 warnings issued.  Results may not be reliable.

---------------------------------------------------------------

3rd oops followed (not so) shortly after:

Jan  6 22:50:51 asterix -- MARK --
Jan  6 22:51:59 asterix kernel:  <1>Unable to handle kernel paging
request at virtual address 0000c14e
Jan  6 22:51:59 asterix kernel:  printing eip:
Jan  6 22:51:59 asterix kernel: c012ea98
Jan  6 22:51:59 asterix kernel: Oops: 0000
Jan  6 22:51:59 asterix kernel: CPU:    0
Jan  6 22:51:59 asterix kernel: EIP:    0010:[get_hash_table+104/144]
Not tainted
Jan  6 22:51:59 asterix kernel: EFLAGS: 00210202
Jan  6 22:51:59 asterix kernel: eax: c1e40000   ebx: 00000004   ecx:
0000c14a   edx: 0000c14a
Jan  6 22:51:59 asterix kernel: esi: 0000000a   edi: 00002103   ebp:
00001e58   esp: f754de34
Jan  6 22:51:59 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 22:51:59 asterix kernel: Process kjournald (pid: 82,
stackpage=f754d000)
Jan  6 22:51:59 asterix kernel: Stack: 00002103 00001000 00001e58
00000000 00000800 c012f158 00002103 00001e58
Jan  6 22:51:59 asterix kernel:        00001000 f7ea0c00 ecb36d50
eb5da140 c0157c33 00002103 00001e58 00001000
Jan  6 22:51:59 asterix kernel:        e4efef40 00001e58 c01554bd
f7ea0c00 f7ea0c50 f7ea0c00 f7ea0c00 00000000
Jan  6 22:51:59 asterix kernel: Call Trace: [getblk+24/64]
[journal_get_descriptor_buffer+51/80]
[journal_commit_transaction+1293/3568] [schedule+704/752]
[kjournald+267/416]
Jan  6 22:51:59 asterix kernel:    [commit_timeout+0/16]
[kernel_thread+40/64]
Jan  6 22:51:59 asterix kernel:
Jan  6 22:51:59 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44
24 20 75 e9 66 39 7a 0c 75

ksymoops decoding :

ksymoops 2.4.1 on i686 2.4.17-a1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-a1/ (default)
     -m /boot/System.map-2.4.17-a1 (specified)

Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says fa8927d0, /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o says fa891c40.  Ignoring /lib/modules/2.4.17-a1/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says fa885924, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885604.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says fa885928, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885608.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says fa88592c, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa88560c.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says fa885920, /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o says fa885600.  Ignoring /lib/modules/2.4.17-a1/kernel/net/sunrpc/sunrpc.o entry
Jan  6 22:51:59 asterix kernel:  <1>Unable to handle kernel paging request at virtual address 0000c14e
Jan  6 22:51:59 asterix kernel: c012ea98
Jan  6 22:51:59 asterix kernel: Oops: 0000
Jan  6 22:51:59 asterix kernel: CPU:    0
Jan  6 22:51:59 asterix kernel: EIP:    0010:[get_hash_table+104/144]    Not tainted
Jan  6 22:51:59 asterix kernel: EFLAGS: 00210202
Jan  6 22:51:59 asterix kernel: eax: c1e40000   ebx: 00000004   ecx: 0000c14a   edx: 0000c14a
Jan  6 22:51:59 asterix kernel: esi: 0000000a   edi: 00002103   ebp: 00001e58   esp: f754de34
Jan  6 22:51:59 asterix kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 22:51:59 asterix kernel: Process kjournald (pid: 82, stackpage=f754d000)
Jan  6 22:51:59 asterix kernel: Stack: 00002103 00001000 00001e58 00000000 00000800 c012f158 00002103 00001e58
Jan  6 22:51:59 asterix kernel:        00001000 f7ea0c00 ecb36d50 eb5da140 c0157c33 00002103 00001e58 00001000
Jan  6 22:51:59 asterix kernel:        e4efef40 00001e58 c01554bd f7ea0c00 f7ea0c50 f7ea0c00 f7ea0c00 00000000
Jan  6 22:51:59 asterix kernel: Call Trace: [getblk+24/64] [journal_get_descriptor_buffer+51/80] [journal_commit_transaction+1293/3568] [schedule+704/752] [kjournald+267/416]
Jan  6 22:51:59 asterix kernel: Code: 39 6a 04 75 f3 0f b7 42 08 3b 44 24 20 75 e9 66 39 7a 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6a 04                  cmp    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
   3:   75 f3                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  00000005 Before first symbol
   5:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  00000009 Before first symbol
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  0000000d Before first symbol
   d:   75 e9                     jne    fffffff8 <_EIP+0xfffffff8> fffffff8 <END_OF_CODE+575aab2/????>
Code;  0000000f Before first symbol
   f:   66 39 7a 0c               cmp    %di,0xc(%edx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


5 warnings issued.  Results may not be reliable.
-- 
Today is the first day of the rest of your lossage.
