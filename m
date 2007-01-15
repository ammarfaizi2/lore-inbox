Return-Path: <linux-kernel-owner+w=401wt.eu-S932319AbXAONXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbXAONXx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXAONXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:23:53 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:35089 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbXAONXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:23:51 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rfdAIV21bl7NBwpZaFoqCN35Sar6OkBpzRJ+3VbsZbTcGnmP4+/Uh3v/f8SWxk6dMzgSFwYlCfYshJ/YaZvi+BzwiWN1w+EqzFjbAXXrUrPqawFrOa7JtPNrZJGXqwYfe+LnTi6xmzXSD861iDgFwVmNlhlPyRhZM4uJiwRNT7M=
Message-ID: <1b270aae0701150523u34036b11mace1cb229ca26219@mail.gmail.com>
Date: Mon, 15 Jan 2007 14:23:50 +0100
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.6.19 and 2.6.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OOPS in 2.6.19 and also 2.6.19.2. Both 2.6.18.3 and 2.6.18.6 are fine.

Exact steps how to reproduce:

#> /etc/init.d/nfs stop
#> umount <PARTITION>
#> reiserfsck -f -q <PARTITION>

All were compiled with gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)
from CentOS 4.4
Machine is a Dual Xeon 3GHz w/ 4GB RAM and 2GB/2GB user/kernel split
and uses reiserfs for all data partitions.
nfsd and reiserfs are built as a module.

If you'll need more info I'll happily try to provide it but it's a
production system and also I could do this trace only on a running
2.6.18.6
Please see ksymoops dump:

ksymoops 2.4.11 on i686 2.6.18.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.19.2/ (specified)
     -m /usr/src/linux-2.6.19.2/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
2048MB HIGHMEM available.
2048MB LOWMEM available.
e1000: 0000:03:04.0: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:d1:ae:48
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:03:04.1: e1000_probe: (PCI-X:100MHz:64-bit) 00:04:23:d1:ae:49
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex

BUG: unable to handle kernel paging request at virtual address 40000830
f8e27304
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<f8e27304>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202   (2.6.19.2 #5)
eax: ee9e3f3f   ebx: 4000082c   ecx: 00000000   edx: f8e69a60
esi: 79ed7040   edi: 00000000   ebp: aff861c0   esp: 7b1f5f38
ds: 007b   es: 007b   ss: 0068
Stack: 00000005 f8e273d8 f8e36024 f8e273e3 00000000 781248b1 404d46da 000000ed
       aff83550 00000206 7b1f5f7c aff861c0 7b1f5f90 fffffffc 781249f5 ffffffff
       ffffffff 00000001 00000000 781132d7 00010000 00000000 00000001 00000001
Call Trace:
 [<f8e273d8>] do_cache_clean+0x0/0x33 [sunrpc]
 [<f8e273e3>] do_cache_clean+0xb/0x33 [sunrpc]
 [<781248b1>] run_workqueue+0x72/0xb0
 [<781249f5>] worker_thread+0x106/0x138
 [<781132d7>] default_wake_function+0x0/0xc
 [<781132d7>] default_wake_function+0x0/0xc
 [<781248ef>] worker_thread+0x0/0x138
 [<781272f0>] kthread+0x7d/0xa1
 [<78127273>] kthread+0x0/0xa1
 [<7810343b>] kernel_thread_helper+0x7/0x10
Code: f8 0f 8d eb 00 00 00 8d 42 0c e8 aa dc 3f 7f a1 60 70 e3 f8 8b 50 08 a1 64
 70 e3 f8 8d 34 82 8b 1e 85 db 74 69 8b 15 60 70 e3 f8 <8b> 43 04 39 42 44 7e 04
 40 89 42 44 8b 43 04 3b 05 80 88 2d 78


>>EIP; f8e27304 <pg0+80b3c304/87d13400>   <=====

>>eax; ee9e3f3f <pg0+766f8f3f/87d13400>
>>ebx; 4000082c <phys_startup_32+3ff0082c/78000000>
>>edx; f8e69a60 <pg0+80b7ea60/87d13400>
>>esi; 79ed7040 <pg0+1bec040/87d13400>
>>ebp; aff861c0 <pg0+37c9b1c0/87d13400>
>>esp; 7b1f5f38 <pg0+2f0af38/87d13400>

Trace; f8e273d8 <pg0+80b3c3d8/87d13400>
Trace; f8e273e3 <pg0+80b3c3e3/87d13400>
Trace; 781248b1 <run_workqueue+72/b0>
Trace; 781249f5 <worker_thread+106/138>
Trace; 781132d7 <default_wake_function+0/c>
Trace; 781132d7 <default_wake_function+0/c>
Trace; 781248ef <worker_thread+0/138>
Trace; 781272f0 <kthread+7d/a1>
Trace; 78127273 <kthread+0/a1>
Trace; 7810343b <kernel_thread_helper+7/10>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  f8e272d9 <pg0+80b3c2d9/87d13400>
00000000 <_EIP>:
Code;  f8e272d9 <pg0+80b3c2d9/87d13400>
   0:   f8                        clc
Code;  f8e272da <pg0+80b3c2da/87d13400>
   1:   0f 8d eb 00 00 00         jge    f2 <_EIP+0xf2>
Code;  f8e272e0 <pg0+80b3c2e0/87d13400>
   7:   8d 42 0c                  lea    0xc(%edx),%eax
Code;  f8e272e3 <pg0+80b3c2e3/87d13400>
   a:   e8 aa dc 3f 7f            call   7f3fdcb9 <_EIP+0x7f3fdcb9>
Code;  f8e272e8 <pg0+80b3c2e8/87d13400>
   f:   a1 60 70 e3 f8            mov    0xf8e37060,%eax
Code;  f8e272ed <pg0+80b3c2ed/87d13400>
  14:   8b 50 08                  mov    0x8(%eax),%edx
Code;  f8e272f0 <pg0+80b3c2f0/87d13400>
  17:   a1 64 70 e3 f8            mov    0xf8e37064,%eax
Code;  f8e272f5 <pg0+80b3c2f5/87d13400>
  1c:   8d 34 82                  lea    (%edx,%eax,4),%esi
Code;  f8e272f8 <pg0+80b3c2f8/87d13400>
  1f:   8b 1e                     mov    (%esi),%ebx
Code;  f8e272fa <pg0+80b3c2fa/87d13400>
  21:   85 db                     test   %ebx,%ebx
Code;  f8e272fc <pg0+80b3c2fc/87d13400>
  23:   74 69                     je     8e <_EIP+0x8e>
Code;  f8e272fe <pg0+80b3c2fe/87d13400>
  25:   8b 15 60 70 e3 f8         mov    0xf8e37060,%edx

This decode from eip onwards should be reliable

Code;  f8e27304 <pg0+80b3c304/87d13400>
00000000 <_EIP>:
Code;  f8e27304 <pg0+80b3c304/87d13400>   <=====
   0:   8b 43 04                  mov    0x4(%ebx),%eax   <=====
Code;  f8e27307 <pg0+80b3c307/87d13400>
   3:   39 42 44                  cmp    %eax,0x44(%edx)
Code;  f8e2730a <pg0+80b3c30a/87d13400>
   6:   7e 04                     jle    c <_EIP+0xc>
Code;  f8e2730c <pg0+80b3c30c/87d13400>
   8:   40                        inc    %eax
Code;  f8e2730d <pg0+80b3c30d/87d13400>
   9:   89 42 44                  mov    %eax,0x44(%edx)
Code;  f8e27310 <pg0+80b3c310/87d13400>
   c:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  f8e27313 <pg0+80b3c313/87d13400>
   f:   3b 05 80 88 2d 78         cmp    0x782d8880,%eax

EIP: [<f8e27304>] cache_clean+0xe8/0x1bc [sunrpc] SS:ESP 0068:7b1f5f38
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; f8e27304 <pg0+80b3c304/87d13400>   <=====


1 warning and 1 error issued.  Results may not be reliable.

Please include me on CC:

Cheers,
M
