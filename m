Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTIXT7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 15:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIXT7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 15:59:41 -0400
Received: from letku14.adsl.netsonic.fi ([194.29.195.14]:2956 "EHLO
	tupa.firmament.fi") by vger.kernel.org with ESMTP id S261433AbTIXT7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 15:59:37 -0400
Date: Wed, 24 Sep 2003 22:59:08 +0300
To: linux-kernel@vger.kernel.org
Subject: smbd oopses 2.4.22
Message-ID: <20030924195908.GB19818@riihi.firmament.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: =?iso-8859-1?Q?Taneli_V=E4h=E4kangas?= <taneli@firmament.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I've got a problem with smbd that oopses. The computer
in question is a 2xPII-350 (SMP kernel) and samba shares live
on /dev/hda3 and /dev/HOME/home (LVM vg of /dev/hdb1 and
/dev/hdb2, totaling approx. 150G, files are approx. 700 MB each).
The computer also exports /dev/hda3 on NFS, which works well even
after the oops.

The machine has been working very well for a year or so, the
2.4.22 kernel and LVM are new things. Previously it had 2.4.21,
for several months with no problems.

I don't know if there was much traffic over samba when it oopsed,
probably not. The oops was repeated almost 300 times, the dump is
from the first one (well, they looked all very similar). No
modules were loaded.

More info is available by request.

ksymoops 2.4.5 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22-1 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Sep 23 13:16:30 riihi kernel: Unable to handle kernel paging request at virtual address 148b9e52
Sep 23 13:16:30 riihi kernel: c013b787
Sep 23 13:16:30 riihi kernel: *pde = 00000000
Sep 23 13:16:30 riihi kernel: Oops: 0000
Sep 23 13:16:30 riihi kernel: CPU:    0
Sep 23 13:16:30 riihi kernel: EIP:    0010:[<c013b787>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 23 13:16:30 riihi kernel: EFLAGS: 00010202
Sep 23 13:16:30 riihi kernel: eax: c474c0cf   ebx: 00000400   ecx: 148b9d96   edx: d0d7fac0
Sep 23 13:16:30 riihi kernel: esi: d0d7fac0   edi: fffffff7   ebp: bfffd54c   esp: c2d51fb4
Sep 23 13:16:30 riihi kernel: ds: 0018   es: 0018   ss: 0018
Sep 23 13:16:30 riihi kernel: Process smbd (pid: 29743, stackpage=c2d51000)
Sep 23 13:16:30 riihi kernel: Stack: c2d50000 000002b8 00000000 c01088c3 00000016 bfffd58c 00000400 000002b8 
Sep 23 13:16:30 riihi kernel:        00000000 bfffd54c 000000b5 0000002b 0000002b 000000b5 4010fe43 00000023 
Sep 23 13:16:30 riihi kernel:        00000256 bfffd520 0000002b 
Sep 23 13:16:30 riihi kernel: Call Trace:    [<c01088c3>]
Sep 23 13:16:30 riihi kernel: Code: 83 b9 bc 00 00 00 00 74 36 8b 81 ac 00 00 00 f6 40 2c 40 74 


>>EIP; c013b787 <sys_pwrite+2f/115>   <=====

>>eax; c474c0cf <END_OF_CODE+42fb8cf/????>
>>ecx; 148b9d96 Before first symbol
>>edx; d0d7fac0 <END_OF_CODE+1092f2c0/????>
>>esi; d0d7fac0 <END_OF_CODE+1092f2c0/????>
>>edi; fffffff7 <END_OF_CODE+3fbaf7f7/????>
>>ebp; bfffd54c Before first symbol
>>esp; c2d51fb4 <END_OF_CODE+29017b4/????>

Trace; c01088c3 <system_call+33/38>

Code;  c013b787 <sys_pwrite+2f/115>
00000000 <_EIP>:
Code;  c013b787 <sys_pwrite+2f/115>   <=====
   0:   83 b9 bc 00 00 00 00      cmpl   $0x0,0xbc(%ecx)   <=====
Code;  c013b78e <sys_pwrite+36/115>
   7:   74 36                     je     3f <_EIP+0x3f> c013b7c6 <sys_pwrite+6e/115>
Code;  c013b790 <sys_pwrite+38/115>
   9:   8b 81 ac 00 00 00         mov    0xac(%ecx),%eax
Code;  c013b796 <sys_pwrite+3e/115>
   f:   f6 40 2c 40               testb  $0x40,0x2c(%eax)
Code;  c013b79a <sys_pwrite+42/115>
  13:   74 00                     je     15 <_EIP+0x15> c013b79c <sys_pwrite+44/115>

Sep 23 13:16:31 riihi kernel:  <1>Unable to handle kernel paging request at virtual address a80424d0

1 warning issued.  Results may not be reliable.

What is going wrong?

	Taneli

