Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281478AbRKMEto>; Mon, 12 Nov 2001 23:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281477AbRKMEte>; Mon, 12 Nov 2001 23:49:34 -0500
Received: from rdu162-229-047.nc.rr.com ([24.162.229.47]:53669 "EHLO
	gateway.house") by vger.kernel.org with ESMTP id <S281475AbRKMEt1>;
	Mon, 12 Nov 2001 23:49:27 -0500
Subject: [OOPS] 2.4.14 in USB? Appletalk?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 12 Nov 2001 23:49:34 -0500
Message-Id: <1005626975.3296.2.camel@gromit.house>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oops is from booting a RH 7.2 system after installing 2.4.14 +
ext3.

[root@gromit rothwell]# kgcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

This is an Athlon system, but I compiled a 386 kernel, for use in
another device.

Nov 12 23:30:24 gromit kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000c
Nov 12 23:30:24 gromit kernel: c0229ef5
Nov 12 23:30:24 gromit kernel: *pde = 00000000
Nov 12 23:30:24 gromit kernel: Oops: 0000
Nov 12 23:30:24 gromit kernel: CPU:    0
Nov 12 23:30:24 gromit kernel: EIP:    0010:[call_policy+345/476]    Not
taintedNov 12 23:30:24 gromit kernel: EIP:    0010:[<c0229ef5>]    Not
tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 12 23:30:24 gromit kernel: EFLAGS: 00010246
Nov 12 23:30:24 gromit kernel: eax: 00000000   ebx: cfc031b4   ecx:
00000001   edx: c02b9b7c
Nov 12 23:30:24 gromit kernel: esi: cff33570   edi: cf3bb200   ebp:
cfc03170   esp: cf485f0c
Nov 12 23:30:24 gromit kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 23:30:24 gromit kernel: Process modprobe (pid: 257,
stackpage=cf485000)
Nov 12 23:30:24 gromit kernel: Stack: cf3bb340 cfc156e0 c02eb3fc
00000010 00000007 c02d4900 c02b9acc 00000000 
Nov 12 23:30:24 gromit kernel:        c022af98 c02b9fc7 cf3bb200
cfce6b04 cfc156e0 c02eb3fc 00000001 00000018 
Nov 12 23:30:24 gromit kernel:        cf3bb200 c022af7d cfce6b04
cff7be60 d089fba0 00000000 bfffeb68 00000018 
Nov 12 23:30:24 gromit kernel: Call Trace: [usb_disconnect+220/280]
[usb_disconnect+193/280]
[appletalk:__insmod_appletalk_O/lib/modules/2.4.14/kernel/net/appletal+-164960/96] [appletalk:__insmod_appletalk_O/lib/modules/2.4.14/kernel/net/appletal+-169319/96] [pci_unregister_driver+51/76] 
Nov 12 23:30:24 gromit kernel: Call Trace: [<c022af98>] [<c022af7d>]
[<d089fba0>] [<d089ea99>] [<c020ba5f>] 
Nov 12 23:30:24 gromit kernel:    [<d089efea>] [<d089fba0>] [<c0114c4b>]
[<c0113da7>] [<c0106beb>] 
Nov 12 23:30:24 gromit kernel: Code: 8b 40 0c 8b 50 04 89 5e 1c c7 44 24
10 08 00 00 00 8b 8f d8 

>>EIP; c0229ef5 <call_policy+159/1dc>   <=====
Trace; c022af98 <usb_disconnect+dc/118>
Trace; c022af7d <usb_disconnect+c1/118>
Trace; d089fba0 <[usbcore]usbdev_read+70/1e0>
Trace; d089ea99 <[usbcore]usb_hub_configure+179/260>
Trace; c020ba5f <pci_unregister_driver+33/4c>
Trace; d089efea <[usbcore]usb_hub_port_wait_reset+ba/140>
Trace; d089fba0 <[usbcore]usbdev_read+70/1e0>
Trace; c0114c4b <free_module+1b/a0>
Trace; c0113da7 <sys_delete_module+f3/1b0>
Trace; c0106beb <system_call+33/38>
Code;  c0229ef5 <call_policy+159/1dc>
00000000 <_EIP>:
Code;  c0229ef5 <call_policy+159/1dc>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c0229ef8 <call_policy+15c/1dc>
   3:   8b 50 04                  mov    0x4(%eax),%edx
Code;  c0229efb <call_policy+15f/1dc>
   6:   89 5e 1c                  mov    %ebx,0x1c(%esi)
Code;  c0229efe <call_policy+162/1dc>
   9:   c7 44 24 10 08 00 00      movl   $0x8,0x10(%esp,1)
Code;  c0229f05 <call_policy+169/1dc>
  10:   00 
Code;  c0229f06 <call_policy+16a/1dc>
  11:   8b 8f d8 00 00 00         mov    0xd8(%edi),%ecx

