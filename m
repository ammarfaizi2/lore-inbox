Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTGJRR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbTGJRQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:16:01 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:60877 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S269535AbTGJRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:15:12 -0400
Subject: nfs client oops with 2.4.20 / processes stuck in D state
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-yDKVU6QatikZGUYAi9GC"
Message-Id: <1057858191.446.10.camel@bonnie79>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 19:29:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yDKVU6QatikZGUYAi9GC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

 Hi,
 
 recently we had an oops on an nfs client (Dell PE 2450). This machine is
 running Debian GNU/Linux 3.0 with kernel-2.4.20 (+xfs from mid march and
 ptrace patch) compiled with Debian's gcc-2.95.4. Now these processes are
 stuck in D state (lock_p).
 I've attached the decoded oops.
 If more info is needed, please advice.
 
 Christian
 

--=-yDKVU6QatikZGUYAi9GC
Content-Disposition: attachment; filename=bt.txt
Content-Type: text/plain; name=bt.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ksymoops 2.4.5 on i686 2.4.20-xfs-p2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-xfs-p2/ (default)
     -m /boot/System.map-2.4.20-xfs-p2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

1151MB HIGHMEM available.
cpu: 0, clocks: 1324331, slice: 441443
cpu: 1, clocks: 1324331, slice: 441443
e100: selftest OK.
e100: eth1: Intel(R) 8255x Based Network Connection
SGI XFS CVS-2003-03-18_06:00_UTC with ACLs, no debug enabled
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0183441
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0183441>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: d98130c0   ecx: d98130c8   edx: d98130c8
esi: f66ef8fc   edi: f66ef8fc   ebp: d98130c0   esp: f362de44
ds: 0018   es: 0018   ss: 0018
Process gunzip (pid: 32283, stackpage=f362d000)
Stack: 00000000 c0183abc d98130c0 d98130c0 f66b3f00 f66ef8fc d0436220 f362c000 
       f362de64 f362de64 c01832e8 f66ef8fc c1a4f8d0 00000000 d0436220 c1a4f8d0 
       d0436220 c0184ca7 c6d93ba0 d0436220 c1a4f8d0 00000000 00001000 c1a4f8d0 
Call Trace: [<c0183abc>]  [<c01832e8>]  [<c0184ca7>]  [<c0185592>]  [<c012b13e>]  [<c012b795>]  [<c012b9ec>]  [<c012bfdf>]  [<c012be7c>]  [<c017fd2d>]  [<c0139f47>]  [<c0108a03>] 
Code: 8b 00 85 c0 7d 08 0f 0b a9 00 70 39 24 c0 53 e8 0b ff ff ff 


>>EIP; c0183441 <nfs_release_request+89/b4>   <=====

>>ebx; d98130c0 <_end+194e06a4/384cd634>
>>ecx; d98130c8 <_end+194e06ac/384cd634>
>>edx; d98130c8 <_end+194e06ac/384cd634>
>>esi; f66ef8fc <_end+363bcee0/384cd634>
>>edi; f66ef8fc <_end+363bcee0/384cd634>
>>ebp; d98130c0 <_end+194e06a4/384cd634>
>>esp; f362de44 <_end+332fb428/384cd634>

Trace; c0183abc <nfs_try_to_free_pages+10c/120>
Trace; c01832e8 <nfs_create_request+a8/120>
Trace; c0184ca7 <nfs_readpage_async+3f/ec>
Trace; c0185592 <nfs_readpage+72/98>
Trace; c012b13e <page_cache_read+a6/cc>
Trace; c012b795 <generic_file_readahead+105/13c>
Trace; c012b9ec <do_generic_file_read+1f0/464>
Trace; c012bfdf <generic_file_read+83/110>
Trace; c012be7c <file_read_actor+0/e0>
Trace; c017fd2d <nfs_file_read+9d/ac>
Trace; c0139f47 <sys_read+8f/100>
Trace; c0108a03 <system_call+33/38>

Code;  c0183441 <nfs_release_request+89/b4>
00000000 <_EIP>:
Code;  c0183441 <nfs_release_request+89/b4>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0183443 <nfs_release_request+8b/b4>
   2:   85 c0                     test   %eax,%eax
Code;  c0183445 <nfs_release_request+8d/b4>
   4:   7d 08                     jge    e <_EIP+0xe> c018344f <nfs_release_request+97/b4>
Code;  c0183447 <nfs_release_request+8f/b4>
   6:   0f 0b                     ud2a   
Code;  c0183449 <nfs_release_request+91/b4>
   8:   a9 00 70 39 24            test   $0x24397000,%eax
Code;  c018344e <nfs_release_request+96/b4>
   d:   c0 53 e8 0b               rclb   $0xb,0xffffffe8(%ebx)
Code;  c0183452 <nfs_release_request+9a/b4>
  11:   ff                        (bad)  
Code;  c0183453 <nfs_release_request+9b/b4>
  12:   ff                        (bad)  
Code;  c0183454 <nfs_release_request+9c/b4>
  13:   ff 00                     incl   (%eax)


1 warning issued.  Results may not be reliable.

--=-yDKVU6QatikZGUYAi9GC--

