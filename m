Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTEFMc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTEFMc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:32:27 -0400
Received: from smtp.inet.fi ([192.89.123.192]:62369 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S262636AbTEFMcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:32:24 -0400
From: Kimmo Sundqvist <rabbit80@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: [2.5.69-mm1] kernel BUG at include/linux/module.h:284! 
Date: Tue, 6 May 2003 15:44:37 +0300
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305061544.37612.rabbit80@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got one like this...

------------[ cut here ]------------
kernel BUG at include/linux/module.h:284!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<f8d4c1e5>]    Not tainted VLI
EFLAGS: 00010246
EIP is at inet6_create+0x191/0x3e0 [ipv6]
eax: 00000000   ebx: f6614000   ecx: 00000002   edx: f8d7ed20
esi: f657ebe0   edi: 0000003a   ebp: f6615f40   esp: f6615f30
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 245, threadinfo=f6614000 task=f78086e0)
Stack: 00000001 f76c14e0 00000028 f8d7d060 ffffff9f c0232b51 f76c14e0 0000003a
       00000000 f8d7f848 c03033dc 00000000 c01211c4 f8d7e494 f7fe7f20 f6f0e4c0
              f8d7e4ec c03033dc f6614000 f8d739e7 f8d07621 0000000a 00000003
0000003a
Call Trace:
 [<f8d7d060>] rawv6_protosw+0x0/0x20 [ipv6]
 [<c0232b51>] sock_create+0x149/0x264
 [<f8d7f848>] __icmpv6_socket+0x0/0x8 [ipv6]
 [<c01211c4>] register_proc_table+0x100/0x118
 [<f8d7e494>] ipv6_net_table+0x0/0x58 [ipv6]
 [<f8d7e4ec>] ipv6_root_table+0x0/0x74 [ipv6]
 [<f8d739e7>] in6addr_loopback+0x3a0b/0x4de4 [ipv6]
 [<f8d07621>] icmpv6_init+0x31/0x140 [ipv6]
 [<f8d7f848>] __icmpv6_socket+0x0/0x8 [ipv6]
 [<f8d7ece0>] +0x0/0x100 [ipv6]
 [<f8d07149>] inet6_init+0xe9/0x2b0 [ipv6]
 [<f8d7d048>] inet6_family_ops+0x0/0x18 [ipv6]
 [<c01308ba>] sys_init_module+0x10e/0x1b0
 [<c0108e1f>] syscall_call+0x7/0xb

    Code: 00 74 08 0f 0b 1e 01 e5 f4 d6 f8 c7 86 2c 01 00 00 e0 ec d7 f8 b8 e0 
ec d7 f8 85 c0 74 38 50 e8 e6 30 3e c7 83 c4 04 85 c0 75 0b <0f> 0b 1c 01 e7 
f3 d6 f8 8d 76 00 ff 43 14 8b 43 10 c1 e0 05 05


*** lspci ***

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / 
HPT370 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)

*** cat /proc/modules ***

ppp_async 9920 1 [unsafe], Live 0xf8d12000
ipv6 214884 0 - Loading 0xf8d4c000
microcode 5600 0 - Live 0xf8d0a000
nls_iso8859_1 4256 1 - Live 0xf8c58000
nls_cp437 5920 1 - Live 0xf8c42000
vfat 13504 1 - Live 0xf8c45000
fat 41120 1 vfat, Live 0xf8c4c000
msr 3424 0 - Live 0xf8940000
minix 30340 0 - Live 0xf898e000
via686a 16580 0 - Live 0xf8963000
i2c_sensor 2848 1 via686a, Live 0xf893e000
hfs 92960 0 - Live 0xf8976000
ppp_synctty 8224 0 - Live 0xf8942000
ppp_generic 27848 4 ppp_async,ppp_synctty, Live 0xf8954000
slhc 6272 1 ppp_generic, Live 0xf8934000
3c59x 30120 1 - Live 0xf894b000
i2c_core 18304 2 via686a,i2c_sensor, Live 0xf8938000

gcc version 2.95.4 20011002 (Debian prerelease)
Linux minjami 2.5.69-mm1 #1 SMP Tue May 6 14:04:44 EEST 2003 i686 unknown

-Kimmo S.
