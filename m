Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJMXjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTJMXjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:39:11 -0400
Received: from smtp10.hy.skanova.net ([195.67.199.143]:15103 "EHLO
	smtp10.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262110AbTJMXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:39:01 -0400
Date: Mon, 13 Oct 2003 21:26:23 +0200 (CEST)
From: Johan Braennlund <johan_brn@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: USB mass storage oops
Message-ID: <Pine.LNX.4.53.0310132055100.1538@h192n1fls22o1048.bredband.comhem.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with the USB hotplug scripts to automount my Olympus
C-4000 camera when it's plugged in. The kernel is 2.6.0-test6-mm4 and the
system is an Acer Aspire laptop with an Athlon XP 1800+ processor.
Sometimes (but not always), turning the camera off and on several times
without rebooting in between causes an oops. Here's the relevant part of
the syslog:

Oct 13 20:44:49 jupiter kernel: usb 1-1: USB disconnect, address 2
[turning the camera off]
Oct 13 20:45:13 jupiter kernel: hub 1-0:1.0: new USB device on port 1,
assigned address 3
[turning it back on]
Oct 13 20:45:13 jupiter kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Oct 13 20:45:13 jupiter modprobe: FATAL: Module usb_storage already in
kernel.
Oct 13 20:45:13 jupiter scsi.agent[1031]: how to add device type= at
/devices/pci0000:00/0000:00:11.2/usb1/1-1/1-1:1.0/host1/1:0:0:0 ??
Oct 13 20:45:13 jupiter kernel:   Vendor: OLYMPUS   Model: C4100Z/C4000Z
Rev: 1.00
Oct 13 20:45:13 jupiter kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Oct 13 20:45:13 jupiter kernel: SCSI device sda: 32000 512-byte hdwr
sectors (16 MB)
Oct 13 20:45:13 jupiter kernel: sda: Write Protect is off
Oct 13 20:45:13 jupiter kernel: sda: Mode Sense: 00 1c 00 00
Oct 13 20:45:13 jupiter kernel: sda: cache data unavailable
Oct 13 20:45:13 jupiter kernel: sda: assuming drive cache: write through
Oct 13 20:45:13 jupiter kernel: Unable to handle kernel paging request at
virtual address 000bcb5b

Oct 13 20:45:13 jupiter kernel:  printing eip:
[...]


The decoded oops can be found below. I'm not sure I did this right, if not
please tell me what I did wrong. Also, I don't really know which portions
of the .config might be relevant. I'm not posting the whole thing, but if
you need it you can find it at
http://www.physto.se/~jbr/config-2.6.0-test6-mm4

Also, as you see from the logs, the USB address increases every time the
camera is turned on. Is this intentional? From my point of view, it would
be convenient if the camera always ended up at /dev/sda1 (assuming the
absence of other SCSI devices, of course).

Regards,

Johan

# ksymoops -k /proc/kallsyms oops
ksymoops 2.4.9 on i686 2.6.0-test6-mm4.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test6-mm4/ (default)
     -m /boot/System.map-2.6.0-test6-mm4 (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 000bcb5b
cf96ab63
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[_end+257797675/1069994696]    Not tainted VLI
EFLAGS: 00010246
eax: 000bcb17   ebx: c13eef8c   ecx: cf979a64   edx: cf979a60
esi: 00000001   edi: ce55a7e0   ebp: cefe1580   esp: cee25a24
ds: 007b   es: 007b   ss: 0068
Stack: cf979a60 cee24000 c13eef8c cf940328 c13eef8c ce503000 cee24000 cf940300
       cefe1580 cf9429c0 c0160b42 cefe1580 cee25b50 00000000 cefa0c80 00000001
       cee25a90 cefe158c c02e0ee0 00000000 c97e0c80 00000001 cee25b50 ce503000
Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; c13eef8c <_end+105f254/3fc6d2c8>
>>ecx; cf979a64 <_end+f5e9d2c/3fc6d2c8>
>>edx; cf979a60 <_end+f5e9d28/3fc6d2c8>
>>edi; ce55a7e0 <_end+e1caaa8/3fc6d2c8>
>>ebp; cefe1580 <_end+ec51848/3fc6d2c8>
>>esp; cee25a24 <_end+ea95cec/3fc6d2c8>

Code: 10 c7 04 24 60 9a 97 cf e8 4b e9 88 f0 85 c0 0f 84 a5 00 00 00 8b 83
84 02 00 00 a8 02 0f 85 97 00 00 00 8b 43 10 be 01 00 00 00 <8b> 40 44 8b
10 85 d2 74 32 b8 00 e0 ff ff 21 e0 ff 40 14 83 3a
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+2b95/????>
   0:   10 c7                     adc    %al,%bh
Code;  ffffffd7 <__kernel_rt_sigreturn+2b97/????>
   2:   04 24                     add    $0x24,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+2b99/????>
   4:   60                        pusha
Code;  ffffffda <__kernel_rt_sigreturn+2b9a/????>
   5:   9a 97 cf e8 4b e9 88      lcall  $0x88e9,$0x4be8cf97
Code;  ffffffe1 <__kernel_rt_sigreturn+2ba1/????>
   c:   f0 85 c0                  lock test %eax,%eax
Code;  ffffffe4 <__kernel_rt_sigreturn+2ba4/????>
   f:   0f 84 a5 00 00 00         je     ba <_EIP+0xba>
Code;  ffffffea <__kernel_rt_sigreturn+2baa/????>
  15:   8b 83 84 02 00 00         mov    0x284(%ebx),%eax
Code;  fffffff0 <__kernel_rt_sigreturn+2bb0/????>
  1b:   a8 02                     test   $0x2,%al
Code;  fffffff2 <__kernel_rt_sigreturn+2bb2/????>
  1d:   0f 85 97 00 00 00         jne    ba <_EIP+0xba>
Code;  fffffff8 <__kernel_rt_sigreturn+2bb8/????>
  23:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  fffffffb <__kernel_rt_sigreturn+2bbb/????>
  26:   be 01 00 00 00            mov    $0x1,%esi
Code;  00000000 Before first symbol
  2b:   8b 40 44                  mov    0x44(%eax),%eax
Code;  00000003 Before first symbol
  2e:   8b 10                     mov    (%eax),%edx
Code;  00000005 Before first symbol
  30:   85 d2                     test   %edx,%edx
Code;  00000007 Before first symbol
  32:   74 32                     je     66 <_EIP+0x66>
Code;  00000009 Before first symbol
  34:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  0000000e Before first symbol
  39:   21 e0                     and    %esp,%eax
Code;  00000010 Before first symbol
  3b:   ff 40 14                  incl   0x14(%eax)
Code;  00000013 Before first symbol
  3e:   83                        .byte 0x83
Code;  00000014 Before first symbol
  3f:   3a                        .byte 0x3a


2 warnings issued.  Results may not be reliable.

