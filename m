Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290310AbSAaJnA>; Thu, 31 Jan 2002 04:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291005AbSAaJmv>; Thu, 31 Jan 2002 04:42:51 -0500
Received: from service.qbssss.edu.au ([210.9.193.2]:9915 "EHLO
	service.qbssss.edu.au") by vger.kernel.org with ESMTP
	id <S290310AbSAaJmk>; Thu, 31 Jan 2002 04:42:40 -0500
Message-ID: <3C590FDE.F5A24971@bssssq.edu.au>
Date: Thu, 31 Jan 2002 19:35:26 +1000
From: Robert Stuart <rstu@qbssss.edu.au>
Organization: Queensland Board of Senior Secondary School Studies
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-SA i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, willy@linuxcare.com, sfr@canb.auug.org.au
Subject: fs/locks.c oops in 2.4.17 and 2.4.15-pre on samba server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a fileserver that has had two Oopses that are almost identical,
one with 2.4.17 and one with 2.4.15-pre5 (this was running without
problems for weeks).  It is a RedHat machine and both Oopses happened
after starting to use Samba 2.2.2 (samba-2.2.2-8 rpm from rawhide). 
Possibly the changes in locking code from 2.2.1a -> 2.2.2 are hitting a
bug causing this oops.  The machine is also a NFS server.
I have also noticed some kernel syslog "lease timed out" messages.

The box is a HP Netserver E800, dual P3-1G, SCSI drives, 2GB RAM, ext3
fs, SW Raid.

I'm not subscribed to the list, I'd be happy to supply any other
information.


for the 2.4.17 kernel:-----------------------------------------
ksymoops 2.4.1 on i686 2.4.15-E800-p.  Options used
     -v vmlinux (specified)
     -k ksyms.copy (specified)
     -l modules.copy (specified)
     -o /lib/modules/2.4.17-E800/ (specified)
     -m System.map-2.4.17-E800 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01db260, vmlinux
 says c01520d0.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address
0000002d
c0143ce3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0143ce3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d1754000
esi: 00000000   edi: 00000000   ebp: f5cfa0e0   esp: d1755efc
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 31027, stackpage=d1755000)
Stack: f0208ad0 3a251aa1 c011f7ae 0000045d c013cc29 f5cfa0e0 ffffffff
00008801 
       d1755f7c c013e2de f5cfa0e0 00008801 00000000 00000004 dc4be4a0
ee484760 
       f7a05f20 c014535c ee484760 c02d46a0 c01415e0 bfffe2f8 c014118e
00008800 
Call Trace: [<c011f7ae>] [<c013cc29>] [<c013e2de>] [<c014535c>]
[<c01415e0>] 
   [<c014118e>] [<c0132a06>] [<c013cb6e>] [<c0132d56>] [<c0106f6b>] 
Code: 0f b6 43 2d a9 10 00 00 00 74 6b 66 f7 44 24 2c 00 08 0f 85 

>>EIP; c0143ce3 <__get_lease+43/260>   <=====
Trace; c011f7ae <in_group_p+1e/30>
Trace; c013cc29 <vfs_permission+79/120>
Trace; c013e2de <open_namei+3ce/550>
Trace; c014535c <dput+1c/160>
Trace; c01415e0 <filldir64+0/140>
Trace; c014118e <vfs_readdir+7e/d0>
Trace; c0132a06 <filp_open+36/60>
Trace; c013cb6e <getname+5e/a0>
Trace; c0132d56 <sys_open+36/e0>
Trace; c0106f6b <system_call+33/38>
Code;  c0143ce3 <__get_lease+43/260>
00000000 <_EIP>:
Code;  c0143ce3 <__get_lease+43/260>   <=====
   0:   0f b6 43 2d               movzbl 0x2d(%ebx),%eax   <=====
Code;  c0143ce7 <__get_lease+47/260>
   4:   a9 10 00 00 00            test   $0x10,%eax
Code;  c0143cec <__get_lease+4c/260>
   9:   74 6b                     je     76 <_EIP+0x76> c0143d59
<__get_lease+b9/260>
Code;  c0143cee <__get_lease+4e/260>
   b:   66 f7 44 24 2c 00 08      testw  $0x800,0x2c(%esp,1)
Code;  c0143cf5 <__get_lease+55/260>
  12:   0f 85 00 00 00 00         jne    18 <_EIP+0x18> c0143cfb
<__get_lease+5b/260>


1 warning issued.  Results may not be reliable.
-----------------------------------
For the 2.4.15-pre kernel ------------------------>


ksymoops 2.4.1 on i686 2.4.15-E800-p.  Options used
     -v /usr/src/linux-2.4.15-pre/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-E800-p/ (default)
     -m /boot/System.map-2.4.15-E800-p (default)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01c2580, vmlinux
 says c0151c60.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
f88cbf30, /lib/modules/2.4
.15-E800-p/kernel/fs/lockd/lockd.o says f88cb38c.  Ignoring
/lib/modules/2.4.15-E800-p/kernel/
fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
f8914464, /lib/modules/2.4
.15-E800-p/kernel/net/sunrpc/sunrpc.o says f8914144.  Ignoring
/lib/modules/2.4.15-E800-p/kern
el/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
f8914468, /lib/modules/2.
4.15-E800-p/kernel/net/sunrpc/sunrpc.o says f8914148.  Ignoring
/lib/modules/2.4.15-E800-p/ker
nel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
f891446c, /lib/modules/2.4
.15-E800-p/kernel/net/sunrpc/sunrpc.o says f891414c.  Ignoring
/lib/modules/2.4.15-E800-p/kern
el/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
f8914460, /lib/modules/2.4
.15-E800-p/kernel/net/sunrpc/sunrpc.o says f8914140.  Ignoring
/lib/modules/2.4.15-E800-p/kern
el/net/sunrpc/sunrpc.o entry
Unable to handle kernel NULL pointer dereference at virtual address
0000002d
c01438e3
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[__get_lease+67/608]    Not tainted
EIP:    0010:[<c01438e3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: d1368000
esi: 00000000   edi: 00000000   ebp: eea14820   esp: d1369efc
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 20076, stackpage=d1369000)
Stack: f5ec0ec4 3a251aa1 c011f9ae 0000045d c013c829 eea14820 ffffffff
00008801 
       d1369f7c c013dede eea14820 00008801 00000000 00000004 ebc4ff40
cd715a20 
       c3016ee0 c0144f5c cd715a20 c02541d8 c01411e0 bfffe338 c0140d8e
00008800 
Call Trace: [in_group_p+30/48] [vfs_permission+121/288]
[open_namei+974/1360] [dput+28/352] [f
illdir64+0/320] 
Call Trace: [<c011f9ae>] [<c013c829>] [<c013dede>] [<c0144f5c>]
[<c01411e0>] 
   [<c0140d8e>] [<c0132806>] [<c013c76e>] [<c0132b56>] [<c0106f6b>] 
Code: 0f b6 43 2d a9 10 00 00 00 74 6b 66 f7 44 24 2c 00 08 0f 85 

>>EIP; c01438e3 <__get_lease+43/260>   <=====
Trace; c011f9ae <in_group_p+1e/30>
Trace; c013c829 <vfs_permission+79/120>
Trace; c013dede <open_namei+3ce/550>
Trace; c0144f5c <dput+1c/160>
Trace; c01411e0 <filldir64+0/140>
Trace; c0140d8e <vfs_readdir+7e/d0>
Trace; c0132806 <filp_open+36/60>
Trace; c013c76e <getname+5e/a0>
Trace; c0132b56 <sys_open+36/e0>
Trace; c0106f6b <system_call+33/38>
Code;  c01438e3 <__get_lease+43/260>
00000000 <_EIP>:
Code;  c01438e3 <__get_lease+43/260>   <=====
   0:   0f b6 43 2d               movzbl 0x2d(%ebx),%eax   <=====
Code;  c01438e7 <__get_lease+47/260>
   4:   a9 10 00 00 00            test   $0x10,%eax
Code;  c01438ec <__get_lease+4c/260>
   9:   74 6b                     je     76 <_EIP+0x76> c0143959
<__get_lease+b9/260>
Code;  c01438ee <__get_lease+4e/260>
   b:   66 f7 44 24 2c 00 08      testw  $0x800,0x2c(%esp,1)
Code;  c01438f5 <__get_lease+55/260>
  12:   0f 85 00 00 00 00         jne    18 <_EIP+0x18> c01438fb
<__get_lease+5b/260>


6 warnings issued.  Results may not be reliable.



Thanks,

Robert
