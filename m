Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbRFLUNE>; Tue, 12 Jun 2001 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbRFLUMy>; Tue, 12 Jun 2001 16:12:54 -0400
Received: from NET.WAU.NL ([137.224.10.12]:17930 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S263193AbRFLUMm>;
	Tue, 12 Jun 2001 16:12:42 -0400
Date: Tue, 12 Jun 2001 22:12:59 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: Re: from dmesg: kernel BUG at inode.c:486
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F52@mail-in.comverse-in.com>; from
 Vassilii.Khachaturov@comverse.com on Tue, Jun 12, 2001 at 03:15:45PM -0400
To: linux-kernel@vger.kernel.org
Message-id: <20010612221259.A26473@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 9:37pm  up 27 days, 46 min,  2 users,  load average: 1.00,
 1.00, 1.00
X-Reverse-Engineered: High priority for sending SMS messages
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F52@mail-in.comverse-in.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is try two, I just read the mailinglist FAQ and used ksymoops to 
translate the symbols. 

Today my girlfriend reported all programs that accessed my 
NFS mounted drive where crashing. Prevously to this, she did 
a lot of deleting and moving around of files on the NFS drive.

I use (Debian Woody) with Linux 2.4.5 on the client:
olivier@aria:~ $ uname -a
Linux aria 2.4.5 #4 Mon May 28 18:19:37 CEST 2001 i686 unknown
The kernel is build by myself using this gcc:
olivier@aria:~ $ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20010319 (Debian prerelease)
I used these .config options (for NFS):
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y

The client is a ABIT BE6 motherboard, PIII450, 256MB ram, 
IBM-DTLA-307045 IDE disk on HPT366 onboard controller running 
udma4, SMC etherpowerII NIC running full duplex 100Mbit, NCR860
scsi board, miro pctv tv card and an old ensoniq soundscape isa 
card.

The server is a very old install, running user-space NFS daemon:
fender:~$ /usr/sbin/rpc.nfsd --version
Universal NFS Server 2.2beta41
The server doesn't show any warning in any logfile.

this is the output from dmesg, used ksymoops to decode the symbols:

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  0000000c Before first symbol
   c:   75 19                     jne    27 <_EIP+0x27> 00000027 Before
first symbol
Code;  0000000e Before first symbol
   e:   68 e8 01 00 00            push   $0x1e8
Code;  00000013 Before first symbol
  13:   68 00 00 00 00            push   $0x0

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: cc703ba0   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c32fdfa4   esp: c32fdeec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1193, stackpage=c32fd000)
Stack: c021b86d c021b8cc 000001e6 cc703ba0 c01409c7 cc703ba0 cceee320
cc703ba0 
       c015e62a cc703ba0 c013e5d6 cceee320 cc703ba0 cceee320 00000000
c013723c 
       cceee320 c32fdf68 c013795a c976eac0 c32fdf68 00000000 c8587000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<c0137f68>] [<c0135276>] 
       [<c0106a7b>] [<c010002b>] 
Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 

>>EIP; c013fffb <clear_inode+33/f4>   <=====
Trace; c01409c7 <iput+137/14c>
Trace; c015e62a <nfs_dentry_iput+22/28>
Trace; c013e5d6 <dput+d6/144>
Trace; c013723c <cached_lookup+48/54>
Trace; c013795a <path_walk+536/78c>
Trace; c0137f68 <__user_walk+3c/58>
Trace; c0135276 <sys_lstat64+16/70>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c013fffb <clear_inode+33/f4>
00000000 <_EIP>:
Code;  c013fffb <clear_inode+33/f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fffd <clear_inode+35/f4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0140000 <clear_inode+38/f4>
   5:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  c0140007 <clear_inode+3f/f4>
   c:   75 19                     jne    27 <_EIP+0x27> c0140022
<clear_inode+5a/f4>
Code;  c0140009 <clear_inode+41/f4>
   e:   68 e8 01 00 00            push   $0x1e8
Code;  c014000e <clear_inode+46/f4>
  13:   68 00 00 00 00            push   $0x0

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: c62eb840   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c7135fa4   esp: c7135eec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1239, stackpage=c7135000)
Stack: c021b86d c021b8cc 000001e6 c62eb840 c01409c7 c62eb840 cf7285e0
c62eb840 
       c015e62a c62eb840 c013e5d6 cf7285e0 c62eb840 cf7285e0 00000000
c013723c 
       cf7285e0 c7135f68 c013795a c976eac0 c7135f68 00000000 c89ac000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<c0137f68>] [<c0135276>] 
       [<c0106a7b>] [<c010002b>] 
Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 

>>EIP; c013fffb <clear_inode+33/f4>   <=====
Trace; c01409c7 <iput+137/14c>
Trace; c015e62a <nfs_dentry_iput+22/28>
Trace; c013e5d6 <dput+d6/144>
Trace; c013723c <cached_lookup+48/54>
Trace; c013795a <path_walk+536/78c>
Trace; c0137f68 <__user_walk+3c/58>
Trace; c0135276 <sys_lstat64+16/70>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c013fffb <clear_inode+33/f4>
00000000 <_EIP>:
Code;  c013fffb <clear_inode+33/f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fffd <clear_inode+35/f4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0140000 <clear_inode+38/f4>
   5:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  c0140007 <clear_inode+3f/f4>
   c:   75 19                     jne    27 <_EIP+0x27> c0140022
<clear_inode+5a/f4>
Code;  c0140009 <clear_inode+41/f4>
   e:   68 e8 01 00 00            push   $0x1e8
Code;  c014000e <clear_inode+46/f4>
  13:   68 00 00 00 00            push   $0x0

kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013fffb>]
EFLAGS: 00010286
eax: 0000001b   ebx: c62ebde0   ecx: 00000001   edx: c025ba84
esi: c025ec60   edi: c976eac0   ebp: c32fdfa4   esp: c32fdeec
ds: 0018   es: 0018   ss: 0018
Process gmc (pid: 1243, stackpage=c32fd000)
Stack: c021b86d c021b8cc 000001e6 c62ebde0 c01409c7 c62ebde0 cf7288e0
c62ebde0 
       c015e62a c62ebde0 c013e5d6 cf7288e0 c62ebde0 cf7288e0 00000000
c013723c 
       cf7288e0 c32fdf68 c013795a c976eac0 c32fdf68 00000000 c55df000
00000000 
Call Trace: [<c01409c7>] [<c015e62a>] [<c013e5d6>] [<c013723c>] [<c013795a>]
[<d8e7dda3>] [<c0137f68>] 
       [<c0135276>] [<c0106a7b>] [<c010002b>] 
Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 

>>EIP; c013fffb <clear_inode+33/f4>   <=====
Trace; c01409c7 <iput+137/14c>
Trace; c015e62a <nfs_dentry_iput+22/28>
Trace; c013e5d6 <dput+d6/144>
Trace; c013723c <cached_lookup+48/54>
Trace; c013795a <path_walk+536/78c>
Trace; d8e7dda3 <END_OF_CODE+8502a84/????>
Trace; c0137f68 <__user_walk+3c/58>
Trace; c0135276 <sys_lstat64+16/70>
Trace; c0106a7b <system_call+33/38>
Trace; c010002b <startup_32+2b/a5>
Code;  c013fffb <clear_inode+33/f4>
00000000 <_EIP>:
Code;  c013fffb <clear_inode+33/f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013fffd <clear_inode+35/f4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0140000 <clear_inode+38/f4>
   5:   f6 83 f4 00 00 00 10      testb  $0x10,0xf4(%ebx)
Code;  c0140007 <clear_inode+3f/f4>
   c:   75 19                     jne    27 <_EIP+0x27> c0140022
<clear_inode+5a/f4>
Code;  c0140009 <clear_inode+41/f4>
   e:   68 e8 01 00 00            push   $0x1e8
Code;  c014000e <clear_inode+46/f4>
  13:   68 00 00 00 00            push   $0x0

I have no idea what this means, to me it looks serious so I decided to
post it on the kernel mailinglist. Is this a real bug? If I have to provide 
more detailed information please tell me what you need and how to get it. I 
had more messages like these, if posting all of them is useful, please tell
me.

thanks,
	Olivier Sessink

