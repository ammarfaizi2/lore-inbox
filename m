Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264589AbTIFH6v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFH6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:58:50 -0400
Received: from pop.isolation-gagneroy.com ([207.253.199.2]:59914 "EHLO
	tank2.questzones.com") by vger.kernel.org with ESMTP
	id S264589AbTIFH6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:58:47 -0400
Message-ID: <006601c3744c$7e0b1d60$8000a8c0@elbasta>
From: "Frederic Trudeau" <ftrudeau@zesolution.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel NULL pointer dereference at virtual address 00000000)
Date: Sat, 6 Sep 2003 03:57:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all.

Im getting the error message "Unable to handle kernel NULL pointer
dereference at virtual address 00000000" when trying to load (ifup eth1)
eth1 with kernel-smp-2.4.20-20.9. It works fine with non-smp package from
RH.

No im not sure if im using the ksymoops tool correctly, but heres the output
:

[root@localhost oops]# ksymoops -v /boot/vmlinux-2.4.20-20.9smp -m
/boot/System.map-2.4.20-20.9smp -o /lib/modules/2.4.20-20.9smp < oops.txt
ksymoops 2.4.5 on i686 2.4.20-20.9smp.  Options used
     -v /boot/vmlinux-2.4.20-20.9smp (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-20.9smp (specified)
     -m /boot/System.map-2.4.20-20.9smp (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aacraid.o) for aacraid
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic79xx.o) for aic79xx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module aacraid to a unique
module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
f8b05260
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<f8b05260>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000100   ebx: 00000000   ecx: 00031988   edx: f770b980
esi: 00000000   edi: 00000000   ebp: 00000000   esp: f54a1e98
ds: 0068   es: 0068   ss: 0068
Process ip (pid: 17610, stackpage=f54a1000)
Stack: c3699400 00001000 f4113000 f770b980 c3699400 00001003 00000000
f8b051dd
       f770b980 14000000 f770b800 f770b800 f770b980 00000000 f8b04a26
f770b980
       f770b800 c020fa86 f770b800 c02123c7 f770b800 f770b800 00001002
c021112a
Call Trace:   [<f8b051dd>] e1000_free_rx_resources [e1000] 0x1d
(0xf54a1eb4))
[<f8b04a26>] e1000_open [e1000] 0x46 (0xf54a1ed0))
[<c020fa86>] dev_open [kernel] 0xa6 (0xf54a1edc))
[<c02123c7>] dev_mc_upload [kernel] 0x37 (0xf54a1ee4))
[<c021112a>] dev_change_flags [kernel] 0x12a (0xf54a1ef4))
[<c020f61e>] dev_get [kernel] 0x1e (0xf54a1f00))
[<c024f130>] devinet_ioctl [kernel] 0x290 (0xf54a1f14))
[<c0207ca0>] sock_ioctl [kernel] 0x40 (0xf54a1f80))
[<c01650b6>] sys_ioctl [kernel] 0xf6 (0xf54a1f94))
[<c01098cf>] system_call [kernel] 0x33 (0xf54a1fc0))
Code: 8b 14 1f 85 d2 74 36 8b 42 70 48 74 0b f0 ff 4a 70 0f 94 c0


>>EIP; f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====

>>ecx; 00031988 Before first symbol
>>edx; f770b980 <_end+3728d080/3838e760>
>>esp; f54a1e98 <_end+35023598/3838e760>

Trace; f8b051dd <[e1000]e1000_free_rx_resources+1d/70>
Trace; f8b04a26 <[e1000]e1000_open+46/60>
Trace; c020fa86 <dev_open+a6/e0>
Trace; c02123c7 <dev_mc_upload+37/80>
Trace; c021112a <dev_change_flags+12a/150>
Trace; c020f61e <dev_get+1e/30>
Trace; c024f130 <devinet_ioctl+290/610>
Trace; c0207ca0 <sock_ioctl+40/80>
Trace; c01650b6 <sys_ioctl+f6/2b0>
Trace; c01098cf <system_call+33/38>

Code;  f8b05260 <[e1000]e1000_clean_rx_ring+30/140>
00000000 <_EIP>:
Code;  f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====
   0:   8b 14 1f                  mov    (%edi,%ebx,1),%edx   <=====
Code;  f8b05263 <[e1000]e1000_clean_rx_ring+33/140>
   3:   85 d2                     test   %edx,%edx
Code;  f8b05265 <[e1000]e1000_clean_rx_ring+35/140>
   5:   74 36                     je     3d <_EIP+0x3d>
Code;  f8b05267 <[e1000]e1000_clean_rx_ring+37/140>
   7:   8b 42 70                  mov    0x70(%edx),%eax
Code;  f8b0526a <[e1000]e1000_clean_rx_ring+3a/140>
   a:   48                        dec    %eax
Code;  f8b0526b <[e1000]e1000_clean_rx_ring+3b/140>
   b:   74 0b                     je     18 <_EIP+0x18>
Code;  f8b0526d <[e1000]e1000_clean_rx_ring+3d/140>
   d:   f0 ff 4a 70               lock decl 0x70(%edx)
Code;  f8b05271 <[e1000]e1000_clean_rx_ring+41/140>
  11:   0f 94 c0                  sete   %al


2 warnings and 6 errors issued.  Results may not be reliable.

===

Please let me know if im missing something, or if you need more info from me
regarding this issue.

Thanks a lot.


