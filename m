Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUAYLvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 06:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUAYLvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 06:51:40 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51929 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264095AbUAYLvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 06:51:33 -0500
Date: Sun, 25 Jan 2004 12:51:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc in BK: Oops loading parport_pc.
Message-ID: <20040125115129.GA10387@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Loading the parport_pc modules crashes in 2.6.2-rc; I have recently done
a "bk pull" and enabled some PNP options, among them ISA PNP.

Find attached the gzipped config and a decoded oops. Does ksymoops 2.4
(using 2.4.8) understand Kernel 2.6 kallsyms? Doesn't seem so. 2.4.9
segfaults for me, haven't yet figured why.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Description: decoded oops when autoloading parport_pc
Content-Disposition: attachment; filename=x2

ksymoops 2.4.8 on i686 2.6.2-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (specified)
     -o /lib/modules/2.6.2-rc1/ (default)
     -m /boot/System.map-2.6.2-rc1 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address d5bd0d48
c01e2c86
*pde = 12b6f067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01e2c86>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: c03c1ac0   ebx: c03c1a64   ecx: d5bd0d48   edx: d5ca8c88
esi: c03c1aac   edi: d5ca8c6c   ebp: d16adee0   esp: d16adec8
ds: 007b   es: 007b   ss: 0068
Stack: c03c1ac8 00000042 c03c1ac8 d5ca8c6c ffffffea 00000000 d16adefc c01e2ce8 
       d5ca8c6c 00000000 d5ca8c6c d5ca8c6c c03c1a60 d16adf18 c0239e0c d5ca8c6c 
       d5ca5a64 d5ca8c40 d5ca8cc0 d5ca8d20 d16adf34 c023a2c1 d5ca8c54 d5c9b708 
Call Trace:
 [<c01e2ce8>] kobject_register+0x28/0x60
 [<c0239e0c>] bus_add_driver+0x4c/0xc0
 [<c023a2c1>] driver_register+0x31/0x40
 [<c0213a31>] pnp_register_driver+0x41/0x80
 [<d5bcd1ec>] parport_pc_init+0x2c/0xc4 [parport_pc]
 [<d5c6ffc7>] parport_parse_dmas+0x37/0x40 [parport]
 [<d5ca44c8>] init_module+0xa8/0x170 [parport_pc]
 [<c0137db0>] sys_init_module+0x110/0x210
 [<c010b1cf>] syscall_call+0x7/0xb
Code: 89 11 89 4a 04 8b 47 28 8b 18 8d 4b 48 89 c8 ba ff ff 00 00 


>>EIP; c01e2c86 <kobject_add+d6/110>   <=====

>>eax; c03c1ac0 <pnp_bus_type+60/100>
>>ebx; c03c1a64 <pnp_bus_type+4/100>
>>ecx; d5bd0d48 <_end+1573f2e0/3fb6c598>
>>edx; d5ca8c88 <_end+15817220/3fb6c598>
>>esi; c03c1aac <pnp_bus_type+4c/100>
>>edi; d5ca8c6c <_end+15817204/3fb6c598>
>>ebp; d16adee0 <_end+1121c478/3fb6c598>
>>esp; d16adec8 <_end+1121c460/3fb6c598>

Trace; c01e2ce8 <kobject_register+28/60>
Trace; c0239e0c <bus_add_driver+4c/c0>
Trace; c023a2c1 <driver_register+31/40>
Trace; c0213a31 <pnp_register_driver+41/80>
Trace; d5bcd1ec <_end+1573b784/3fb6c598>
Trace; d5c6ffc7 <_end+157de55f/3fb6c598>
Trace; d5ca44c8 <_end+15812a60/3fb6c598>
Trace; c0137db0 <sys_init_module+110/210>
Trace; c010b1cf <syscall_call+7/b>

Code;  c01e2c86 <kobject_add+d6/110>
00000000 <_EIP>:
Code;  c01e2c86 <kobject_add+d6/110>   <=====
   0:   89 11                     mov    %edx,(%ecx)   <=====
Code;  c01e2c88 <kobject_add+d8/110>
   2:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  c01e2c8b <kobject_add+db/110>
   5:   8b 47 28                  mov    0x28(%edi),%eax
Code;  c01e2c8e <kobject_add+de/110>
   8:   8b 18                     mov    (%eax),%ebx
Code;  c01e2c90 <kobject_add+e0/110>
   a:   8d 4b 48                  lea    0x48(%ebx),%ecx
Code;  c01e2c93 <kobject_add+e3/110>
   d:   89 c8                     mov    %ecx,%eax
Code;  c01e2c95 <kobject_add+e5/110>
   f:   ba ff ff 00 00            mov    $0xffff,%edx


1 error issued.  Results may not be reliable.

--SLDf9lqlvOQaIe6s
Content-Type: application/x-gunzip
Content-Description: gzipped configuration of same kernel
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
ybxNvRXZGs0YNnhbRnrcennO+T9C4MU9QYkAAA==

--SLDf9lqlvOQaIe6s--
