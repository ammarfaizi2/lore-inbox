Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262630AbREZKkh>; Sat, 26 May 2001 06:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbREZKk1>; Sat, 26 May 2001 06:40:27 -0400
Received: from [213.128.193.148] ([213.128.193.148]:31757 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262630AbREZKkT>;
	Sat, 26 May 2001 06:40:19 -0400
Date: Sat, 26 May 2001 14:37:24 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: jerdfelt@valinux.com, linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: USB oops on SMP, 2.4.5 kernel, and other problems
Message-ID: <20010526143724.A302@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   All stuff below is from 2.4.5 kernel
   I experienced different problems with USB drivers on my SMP system.
   here is what I have:
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2

   I tried both uhci and usb-uhci driver.
   First of all, when I insert USB device into USB bus, I got a lot of messages
   about it is not accepting new address(not just 2 such messages like on other
   UP machine I have, when device is not ready). Though device in fact is
   accepting the address. (I run Linux on this device, so I see both sides of
   link). If I plug/unplug device for several times, it eventually works.
   But if I try to rmmod uhci/usb-uhci driver when device kernel thinks that
   device is not accepting an address, I'm getting an oops.
   (In fact I have this same oops on insertion of usb-uhci and on removal of
   uhci):
usb-uhci version:
usb-uhci.c: $Revision: 1.259 $ time 11:02:12 May 26 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 19
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
usb-uhci.c: USB Universal Host Controller Interface driver
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 2
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c01a3162
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a3162>]
EFLAGS: 00010246
eax: 00000000   ebx: d7ea54e4   ecx: c021e4dd   edx: c021e4dc
esi: d7a9de60   edi: d7ebba00   ebp: d7ea54a0   esp: d7375ef4
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 217, stackpage=d7375000)
Stack: 00000007 c023a240 c021e42c 00000000 00000025 d7ebba40 d7ebbb24 00000002
       d7ebba00 c01a42fc c021e8a7 d7ebba00 c01a5f9c ffffffff d7844a04 d7844ae8
       c1669400 d7844a00 c01a42e0 d7844ae8 00000018 0000000e d7ea55a0 d8835000
Call Trace: [<c01a42fc>] [<c01a5f9c>] [<c01a42e0>] [<d8835000>] [<d8833d8a>] [<c019f19f>] [<d8830000>]
       [<d883426a>] [<d8835000>] [<c0118a9e>] [<d8830000>] [<c0117e62>] [<d8830000>] [<c0106e0b>]

Code: 8b 40 0c 8b 50 04 89 5e 1c c7 04 24 08 00 00 00 8b 87 bc 00
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: get_port_status(2) failed (err = -19)
hub.c: get_port_status(2) failed (err = -19)
hub.c: get_port_status(2) failed (err = -19)
hub.c: get_port_status(2) failed (err = -19)
hub.c: get_port_status(2) failed (err = -19)
hub.c: Cannot enable port 2 of hub 1, disabling port.
hub.c: Maybe the USB cable is bad?
hub.c: cannot disable port 2 of hub 1 (err = -19)
hub.c: get_hub_status failed
>>EIP; c01a3162 <call_policy+162/1f0>   <=====
Trace; c01a42fc <usb_disconnect+fc/130>
Trace; c01a5f9c <hub_disconnect+1c/80>
Trace; c01a42e0 <usb_disconnect+e0/130>
Trace; d8835000 <.data.end+6bc9/????>
Trace; d8833d8a <.data.end+5953/????>
Trace; c019f19f <pci_unregister_driver+2f/50>
Trace; d8830000 <.data.end+1bc9/????>
Trace; d883426a <.data.end+5e33/????>
Trace; d8835000 <.data.end+6bc9/????>
Trace; c0118a9e <free_module+1e/d0>
Trace; d8830000 <.data.end+1bc9/????>
Trace; c0117e62 <sys_delete_module+132/270>
Trace; d8830000 <.data.end+1bc9/????>
Trace; c0106e0b <system_call+33/38>
Code;  c01a3162 <call_policy+162/1f0>
00000000 <_EIP>:
Code;  c01a3162 <call_policy+162/1f0>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c01a3165 <call_policy+165/1f0>
   3:   8b 50 04                  mov    0x4(%eax),%edx
Code;  c01a3168 <call_policy+168/1f0>
   6:   89 5e 1c                  mov    %ebx,0x1c(%esi)
Code;  c01a316b <call_policy+16b/1f0>
   9:   c7 04 24 08 00 00 00      movl   $0x8,(%esp,1)
Code;  c01a3172 <call_policy+172/1f0>
  10:   8b 87 bc 00 00 00         mov    0xbc(%edi),%eax

uhci version:
uhci.c: USB UHCI at I/O 0xc400, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xc800, IRQ 19
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
uhci.c: USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 3
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 3
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c01a3162
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01a3162>]
EFLAGS: 00010246
eax: 00000000   ebx: d70be9a4   ecx: c021e4dd   edx: c021e4dc
esi: d708b340   edi: d723f400   ebp: d70be960   esp: d6281f08
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 827, stackpage=d6281000)
Stack: 00000007 c023a240 c021e42c 00000000 00000025 d723f440 d723f524 00000003
       d723f400 c01a42fc c021e8a7 d723f400 c01a5f9c ffffffff d62d5e04 d62d5ee8
       d68a6620 d62d5e00 c01a42e0 d62d5ee8 00000018 0000000e d70be860 d883bec0
Call Trace: [<c01a42fc>] [<c01a5f9c>] [<c01a42e0>] [<d883bec0>] [<d883a8eb>] [<c019f19f>] [<d8836000>]
       [<d883aa6a>] [<d883bec0>] [<c0118a9e>] [<d8836000>] [<c0117e62>] [<d8836000>] [<c0106e0b>]

Code: 8b 40 0c 8b 50 04 89 5e 1c c7 04 24 08 00 00 00 8b 87 bc 00
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
>>EIP; c01a3162 <call_policy+162/1f0>   <=====
Trace; c01a42fc <usb_disconnect+fc/130>
Trace; c01a5f9c <hub_disconnect+1c/80>
Trace; c01a42e0 <usb_disconnect+e0/130>
Trace; d883bec0 <END_OF_CODE+da89/????>
Trace; d883a8eb <END_OF_CODE+c4b4/????>
Trace; c019f19f <pci_unregister_driver+2f/50>
Trace; d8836000 <.data.end+7bc9/????>
Trace; d883aa6a <END_OF_CODE+c633/????>
Trace; d883bec0 <END_OF_CODE+da89/????>
Trace; c0118a9e <free_module+1e/d0>
Trace; d8836000 <.data.end+7bc9/????>
Trace; c0117e62 <sys_delete_module+132/270>
Trace; d8836000 <.data.end+7bc9/????>
Trace; c0106e0b <system_call+33/38>
Code;  c01a3162 <call_policy+162/1f0>
00000000 <_EIP>:
Code;  c01a3162 <call_policy+162/1f0>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c01a3165 <call_policy+165/1f0>
   3:   8b 50 04                  mov    0x4(%eax),%edx
Code;  c01a3168 <call_policy+168/1f0>
   6:   89 5e 1c                  mov    %ebx,0x1c(%esi)
Code;  c01a316b <call_policy+16b/1f0>
   9:   c7 04 24 08 00 00 00      movl   $0x8,(%esp,1)
Code;  c01a3172 <call_policy+172/1f0>
  10:   8b 87 bc 00 00 00         mov    0xbc(%edi),%eax

As you can see, oops appear in the same place both times, it is in
drivers/usb/usb.c::call_policy(), line number 834 (dev->actconfig appears to be
NULL).
So I made this patch to it:
   
--- drivers/usb/usb.c.orig	Sat May 26 13:44:10 2001
+++ drivers/usb/usb.c	Sat May 26 13:46:01 2001
@@ -830,7 +830,7 @@
 			    dev->descriptor.bDeviceClass,
 			    dev->descriptor.bDeviceSubClass,
 			    dev->descriptor.bDeviceProtocol) + 1;
-	if (dev->descriptor.bDeviceClass == 0) {
+	if (dev->descriptor.bDeviceClass == 0 && dev->actconfig != 0) {
 		int alt = dev->actconfig->interface [0].act_altsetting;
 
 		/* a simple/common case: one config, one interface, one driver

After this I got another oops on removal (this tiem I played only with uhci
driver):

uhci.c: USB UHCI at I/O 0xc400, IRQ 19
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xc800, IRQ 19
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
uhci.c: USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 3
usb.c: USB disconnect on device 1
usb.c: USB disconnect on device 3
usb.c: USB bus 1 deregistered
pci_pool_destroy 00:07.2/uhci_qh, d6219000 busy
pci_pool_destroy 00:07.2/uhci_td, d621a000 busy
usb.c: USB disconnect on device 1
usb.c: USB bus 2 deregistered
kmem_cache_destroy: Can't free all objects d7eb3a58
uhci: not all urb_priv's were freed
usb_control/bulk_msg: timeout
Unable to handle kernel paging request at virtual address d883be7c
 printing eip:
c01a3429
*pde = 17ebc067
*pte = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[usb_unlink_urb+25/48]
EIP:    0010:[<c01a3429>]
EFLAGS: 00010286
eax: d883be6c   ebx: ffffff92   ecx: 00000082   edx: d720da40
esi: d7eba000   edi: d7ebbe9c   ebp: 00000000   esp: d7ebbe70
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 8, stackpage=d7ebb000)
Stack: d720da40 c01a35ac d720da40 c021e5a0 d7ebbeac d7ebbe9c ffffffff 00000001
       d7ebbea0 d7ebbea0 d7ebbe94 00000001 d7ebbea0 d7ebbea0 00000000 00000000
       d7eba000 d7ebbea0 d7ebbea0 d7761200 80000000 d689ac20 00000000 c01a364f
Call Trace: [usb_start_wait_urb+316/384] [usb_internal_control_msg+95/112] [usb_control_msg+129/160] [usb_set_address+41/48] [usb_new_device+29/464] [usb_hub_port_connect_change+539/784] [usb_hub_port_connect_change+583/784]
Call Trace: [<c01a35ac>] [<c01a364f>] [<c01a36e1>] [<c01a44a9>] [<c01a4efd>] [<c01a657b>] [<c01a65a7>]
       [usb_hub_events+292/704] [usb_hub_thread+69/112] [prepare_namespace+0/16] [kernel_thread+38/48] [usb_hub_thread+0/112]
Code: ff 50 10 59 c3 89 f6 b8 ed ff ff ff c3 8d 76 00 8d bc 27 00

So it seems, whenewer we have some not yet fully initialized devices, we cannot
unload host controller driver because of some pending URBs or something.

Perhaps this long letter will help someone to fix a problem.
(and if someone have a fix that will let my device to be detected right away 
like on an UP system, feel free to send me a patch to try ;) )

Bye,
    Oleg
