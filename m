Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVHWQDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVHWQDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVHWQDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:03:06 -0400
Received: from 100.Red-83-54-32.pooles.rima-tde.net ([83.54.32.100]:55457 "EHLO
	smoke.zoop.org") by vger.kernel.org with ESMTP id S932111AbVHWQDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:03:05 -0400
Message-ID: <430B48A5.4040702@hiramoto.org>
Date: Tue, 23 Aug 2005 18:02:45 +0200
From: Karl Hiramoto <karl@hiramoto.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: kernel BUG at kernel/workqueue.c:104!
Content-Type: multipart/mixed;
 boundary="------------040307070405000905040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040307070405000905040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,  i get this a lot now when doing:  "rmmod  cp2101 io_edgeport "

I try and do the rmmod, because i loose comunications on the USB to 
RS-232 adapters.


Not sure if i did the ksymoops correctly but here it is:

# ./ksymoops
ksymoops 2.4.9 on i686 2.6.12-gentoo-r9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-gentoo-r9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
./ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:104!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: cp2101 io_edgeport ipv6 nfs lockd sunrpc ohci_hcd 
analog ns558 parport_pc parport pcspkr rtc nvidia via_rhine mii 
snd_via82xx gameport snd_ac97_codec snd_mpu401_uart snd_rawmidi 
i2c_viapro i2c_core ehci_hcd usbserial uhci_hcd lpclinux via_agp agpgart 
usbcore
CPU:    0
EIP:    0060:[<c0125213>]    Tainted: P      VLI
EFLAGS: 00210213   (2.6.12-gentoo-r9)
EIP is at queue_work+0x73/0x80
eax: cc5e7948   ebx: cc5e7944   ecx: 00000001   edx: d6de1000
esi: dffe7960   edi: 00000000   ebp: d6de1000   esp: d6de1eac
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 11256, threadinfo=d6de1000 task=cc84e510)
Stack: 00000002 cdf78000 00000000 ccfa1f20 d2f29df4 e086c1fe cc5e7000 
cdf78000
       00000083 d2f29de0 e0979020 e0979040 e0917134 d2f29de0 d2f29de0 
d2f29df4
       d2f29e18 d2f29df4 c0308667 d2f29df4 c041d290 e0979040 e0979088 
00000000
Call Trace:
 [<e086c1fe>] usb_serial_disconnect+0x8e/0xc0 [usbserial]
 [<e0917134>] usb_unbind_interface+0x84/0x90 [usbcore]
 [<c0308667>] device_release_driver+0x77/0x80
 [<c03086a0>] driver_detach+0x30/0x40
 [<c0308b3c>] bus_remove_driver+0x4c/0x90
 [<c03090f3>] driver_unregister+0x13/0x30
 [<e0917227>] usb_deregister+0x37/0x50 [usbcore]
 [<e097786f>] cp2101_exit+0xf/0x1f [cp2101]
 [<c012ef67>] sys_delete_module+0x167/0x1a0
 [<c0153941>] sys_write+0x51/0x80
 [<c0102dc1>] syscall_call+0x7/0xb
Code: d4 c1 fe ff b8 00 f0 ff ff 21 e0 8b 40 08 a8 08 75 12 89 f8 8b 5c 
24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 e8 6f 5f 2c 00 eb e7 <0f> 0b 
68 00 2d 37 40 c0 eb b4 8d 76 00 83 ec 08 8b 44 24 0c 8b
 <6>note: rmmod[11256] exited with preempt_count 1
scheduling while atomic: rmmod/0x10000001/11256
 [<c03eb176>] schedule+0x5f6/0x600
 [<c0142a9a>] unmap_page_range+0x8a/0xb0
 [<c03eb9fc>] cond_resched+0x2c/0x50
 [<c0142c68>] unmap_vmas+0x1a8/0x200
 [<c01476b3>] exit_mmap+0x83/0x170
 [<c0103ba0>] do_invalid_op+0x0/0xd0
 [<c0112a87>] mmput+0x37/0xb0
 [<c0117630>] do_exit+0xb0/0x3d0
 [<c0103ba0>] do_invalid_op+0x0/0xd0
 [<c01037db>] die+0x18b/0x190
 [<c0103c4e>] do_invalid_op+0xae/0xd0
 [<c030b3c6>] pool_find_page+0x46/0x70
 [<c0125213>] queue_work+0x73/0x80
 [<c030b46b>] dma_pool_free+0x7b/0x112
 [<e091d580>] urb_destroy+0x0/0x10 [usbcore]
 [<e091dbed>] usb_start_wait_urb+0xcd/0xf0 [usbcore]
 [<e0966bf4>] qh_destroy+0x54/0x80 [ehci_hcd]
 [<e0966ba0>] qh_destroy+0x0/0x80 [ehci_hcd]
 [<c0299e1d>] kref_put+0x3d/0xa0
 [<e096b444>] ehci_endpoint_disable+0x124/0x172 [ehci_hcd]
 [<e0966ba0>] qh_destroy+0x0/0x80 [ehci_hcd]
 [<c0102fdb>] error_code+0x4f/0x54
 [<c0125213>] queue_work+0x73/0x80
 [<e086c1fe>] usb_serial_disconnect+0x8e/0xc0 [usbserial]
 [<e0917134>] usb_unbind_interface+0x84/0x90 [usbcore]
 [<c0308667>] device_release_driver+0x77/0x80
 [<c03086a0>] driver_detach+0x30/0x40
 [<c0308b3c>] bus_remove_driver+0x4c/0x90
 [<c03090f3>] driver_unregister+0x13/0x30
 [<e0917227>] usb_deregister+0x37/0x50 [usbcore]
 [<e097786f>] cp2101_exit+0xf/0x1f [cp2101]
 [<c012ef67>] sys_delete_module+0x167/0x1a0
 [<c0153941>] sys_write+0x51/0x80
 [<c0102dc1>] syscall_call+0x7/0xb
kernel BUG at kernel/workqueue.c:104!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0125213>]    Tainted: P      VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210213   (2.6.12-gentoo-r9)
eax: cc5e7948   ebx: cc5e7944   ecx: 00000001   edx: d6de1000
esi: dffe7960   edi: 00000000   ebp: d6de1000   esp: d6de1eac
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 cdf78000 00000000 ccfa1f20 d2f29df4 e086c1fe cc5e7000 
cdf78000
       00000083 d2f29de0 e0979020 e0979040 e0917134 d2f29de0 d2f29de0 
d2f29df4
       d2f29e18 d2f29df4 c0308667 d2f29df4 c041d290 e0979040 e0979088 
00000000
Call Trace:
 [<e086c1fe>] usb_serial_disconnect+0x8e/0xc0 [usbserial]
 [<e0917134>] usb_unbind_interface+0x84/0x90 [usbcore]
 [<c0308667>] device_release_driver+0x77/0x80
 [<c03086a0>] driver_detach+0x30/0x40
 [<c0308b3c>] bus_remove_driver+0x4c/0x90
 [<c03090f3>] driver_unregister+0x13/0x30
 [<e0917227>] usb_deregister+0x37/0x50 [usbcore]
 [<e097786f>] cp2101_exit+0xf/0x1f [cp2101]
 [<c012ef67>] sys_delete_module+0x167/0x1a0
 [<c0153941>] sys_write+0x51/0x80
 [<c0102dc1>] syscall_call+0x7/0xb
Code: d4 c1 fe ff b8 00 f0 ff ff 21 e0 8b 40 08 a8 08 75 12 89 f8 8b 5c 
24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 e8 6f 5f 2c 00 eb e7 <0f> 0b 
68 00 2d 37 40 c0 eb b4 8d 76 00 83 ec 08 8b 44 24 0c 8b


 >>EIP; c0125213 <queue_work+73/80>   <=====

 >>eax; cc5e7948 <pg0+c0da948/3faf1400>
 >>ebx; cc5e7944 <pg0+c0da944/3faf1400>
 >>edx; d6de1000 <pg0+168d4000/3faf1400>
 >>esi; dffe7960 <pg0+1fada960/3faf1400>
 >>ebp; d6de1000 <pg0+168d4000/3faf1400>
 >>esp; d6de1eac <pg0+168d4eac/3faf1400>

Trace; e086c1fe <pg0+2035f1fe/3faf1400>
Trace; e0917134 <pg0+2040a134/3faf1400>
Trace; c0308667 <device_release_driver+77/80>
Trace; c03086a0 <driver_detach+30/40>
Trace; c0308b3c <bus_remove_driver+4c/90>
Trace; c03090f3 <driver_unregister+13/30>
Trace; e0917227 <pg0+2040a227/3faf1400>
Trace; e097786f <pg0+2046a86f/3faf1400>
Trace; c012ef67 <sys_delete_module+167/1a0>
Trace; c0153941 <sys_write+51/80>
Trace; c0102dc1 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01251e8 <queue_work+48/80>
00000000 <_EIP>:
Code;  c01251e8 <queue_work+48/80>
   0:   d4 c1                     aam    $0xffffffc1
Code;  c01251ea <queue_work+4a/80>
   2:   fe                        (bad)
Code;  c01251eb <queue_work+4b/80>
   3:   ff                        (bad)
Code;  c01251ec <queue_work+4c/80>
   4:   b8 00 f0 ff ff            mov    $0xfffff000,%eax
Code;  c01251f1 <queue_work+51/80>
   9:   21 e0                     and    %esp,%eax
Code;  c01251f3 <queue_work+53/80>
   b:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c01251f6 <queue_work+56/80>
   e:   a8 08                     test   $0x8,%al
Code;  c01251f8 <queue_work+58/80>
  10:   75 12                     jne    24 <_EIP+0x24>
Code;  c01251fa <queue_work+5a/80>
  12:   89 f8                     mov    %edi,%eax
Code;  c01251fc <queue_work+5c/80>
  14:   8b 5c 24 08               mov    0x8(%esp),%ebx
Code;  c0125200 <queue_work+60/80>
  18:   8b 74 24 0c               mov    0xc(%esp),%esi
Code;  c0125204 <queue_work+64/80>
  1c:   8b 7c 24 10               mov    0x10(%esp),%edi
Code;  c0125208 <queue_work+68/80>
  20:   83 c4 14                  add    $0x14,%esp
Code;  c012520b <queue_work+6b/80>
  23:   c3                        ret
Code;  c012520c <queue_work+6c/80>
  24:   e8 6f 5f 2c 00            call   2c5f98 <_EIP+0x2c5f98>
Code;  c0125211 <queue_work+71/80>
  29:   eb e7                     jmp    12 <_EIP+0x12>

This decode from eip onwards should be reliable

Code;  c0125213 <queue_work+73/80>
00000000 <_EIP>:
Code;  c0125213 <queue_work+73/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0125215 <queue_work+75/80>
   2:   68 00 2d 37 40            push   $0x40372d00
Code;  c012521a <queue_work+7a/80>
   7:   c0 eb b4                  shr    $0xb4,%bl
Code;  c012521d <queue_work+7d/80>
   a:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0125220 <delayed_work_timer_fn+0/20>
   d:   83 ec 08                  sub    $0x8,%esp
Code;  c0125223 <delayed_work_timer_fn+3/20>
  10:   8b 44 24 0c               mov    0xc(%esp),%eax
Code;  c0125227 <delayed_work_timer_fn+7/20>
  14:   8b                        .byte 0x8b

 [<c03eb176>] schedule+0x5f6/0x600
 [<c0142a9a>] unmap_page_range+0x8a/0xb0
 [<c03eb9fc>] cond_resched+0x2c/0x50
 [<c0142c68>] unmap_vmas+0x1a8/0x200
 [<c01476b3>] exit_mmap+0x83/0x170
 [<c0103ba0>] do_invalid_op+0x0/0xd0
 [<c0112a87>] mmput+0x37/0xb0
 [<c0117630>] do_exit+0xb0/0x3d0
 [<c0103ba0>] do_invalid_op+0x0/0xd0
 [<c01037db>] die+0x18b/0x190
 [<c0103c4e>] do_invalid_op+0xae/0xd0
 [<c030b3c6>] pool_find_page+0x46/0x70
 [<c0125213>] queue_work+0x73/0x80
 [<c030b46b>] dma_pool_free+0x7b/0x112
 [<e091d580>] urb_destroy+0x0/0x10 [usbcore]
 [<e091dbed>] usb_start_wait_urb+0xcd/0xf0 [usbcore]
 [<e0966bf4>] qh_destroy+0x54/0x80 [ehci_hcd]
 [<e0966ba0>] qh_destroy+0x0/0x80 [ehci_hcd]
 [<c0299e1d>] kref_put+0x3d/0xa0
 [<e096b444>] ehci_endpoint_disable+0x124/0x172 [ehci_hcd]
 [<e0966ba0>] qh_destroy+0x0/0x80 [ehci_hcd]
 [<c0102fdb>] error_code+0x4f/0x54
 [<c0125213>] queue_work+0x73/0x80
 [<e086c1fe>] usb_serial_disconnect+0x8e/0xc0 [usbserial]
 [<e0917134>] usb_unbind_interface+0x84/0x90 [usbcore]
 [<c0308667>] device_release_driver+0x77/0x80
 [<c03086a0>] driver_detach+0x30/0x40
 [<c0308b3c>] bus_remove_driver+0x4c/0x90
 [<c03090f3>] driver_unregister+0x13/0x30
 [<e0917227>] usb_deregister+0x37/0x50 [usbcore]
 [<e097786f>] cp2101_exit+0xf/0x1f [cp2101]
 [<c012ef67>] sys_delete_module+0x167/0x1a0
 [<c0153941>] sys_write+0x51/0x80
 [<c0102dc1>] syscall_call+0x7/0xb




1 warning and 1 error issued.  Results may not be reliable.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 3000+
stepping        : 0
cpu MHz         : 2166.530
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4292.60

#tunnel2 ksymoops-2.4.9 # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:0b.0 Communication controller: GESYTEC GmBH: Unknown device 0002 
(rev 01)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 
[GeForce4 MX 4000 AGP 8x] (rev c1)


#uname -a
Linux #tunnel2 2.6.12-gentoo-r9 #1 Mon Aug 22 07:46:49 EDT 2005 i686 AMD 
Athlon(TM) XP 3000+ AuthenticAMD GNU/Linux



-- 

---
Karl Hiramoto <karl@hiramoto.org>
US VOIP: (1) 603.966.4448
Spain Casa  (34) 951.273.347
Spain Mobil (34) 617.463.826
Yahoo_IM = karl_hiramoto   jabber.org=karl_hiramoto
------
-
Experience is what you get when you didn't get what you wanted.


--------------040307070405000905040109
Content-Type: text/x-vcard; charset=utf-8;
 name="karl.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="karl.vcf"

begin:vcard
fn:Karl Hiramoto
n:Hiramoto;Karl
email;internet:karl@hiramoto.org
tel;work:(1) 603-966-4448
tel;home:(+34) 952.827.554
tel;cell:(+34) 617.463.826
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------040307070405000905040109--
