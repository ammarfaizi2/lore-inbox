Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUE3LI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUE3LI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUE3LI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:08:29 -0400
Received: from lucidpixels.com ([66.45.37.187]:1679 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262538AbUE3LIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:08:22 -0400
Date: Sun, 30 May 2004 07:08:20 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: webcam@smcc.demon.nl
Subject: Turning USB (Philips i740) camera on and off make kernel oops (2.6.5
 SMP).
Message-ID: <Pine.LNX.4.60.0405300651100.16393@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System.map-2.6.5-8: http://209.81.41.149/~jpiszcz/System.map-2.6.5-8.bz2

$ cat oops | ksymoops > oops.out
ksymoops 2.4.9 on i686 2.6.5.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.6.5/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
c019307e
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c019307e>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.5) 
eax: 00000000   ebx: 00000000   ecx: 0000006c   edx: f3d6fb80
esi: c0424ebb   edi: f7010793   ebp: ffffffff   esp: f3509e10
ds: 007b   es: 007b   ss: 0068
Stack: 0000003d 000000d0 f74f6280 f7010780 00000004 f3d6fb80 f8acdc50 f6531994
        00000000 f65319ec c025fbc3 f8acdc1c f65319b8 f65319bc f8acdc00 c025fc2c
        f6531994 f8acdc00 f8acdc38 f6531994 f8ae4a44 c025fc84 00200200 f345d740 
Call Trace:
  [<c025fbc3>] device_bind_driver+0x3b/0x40
  [<c025fc2c>] bus_match+0x64/0x76
  [<c025fc84>] device_attach+0x46/0xad
  [<c025fe33>] bus_add_device+0x5b/0xa0
  [<c025eebc>] device_add+0xa1/0x131
  [<f8ad6449>] usb_set_configuration+0x1d7/0x267 [usbcore]
  [<f8ad0e37>] usb_new_device+0x288/0x3d5 [usbcore]
  [<f8ad2618>] hub_port_connect_change+0x2b8/0x37a [usbcore]
  [<f8ad2ea8>] hub_thread+0x2b4/0x575 [usbcore]
  [<c011c876>] default_wake_function+0x0/0x18
  [<f8ad2bf4>] hub_thread+0x0/0x575 [usbcore]
  [<c01043f5>] kernel_thread_helper+0x5/0xb
Code: f0 ff 48 6c 0f 88 b9 00 00 00 8b 44 24 34 89 44 24 04 89 14


>>EIP; c019307e <sysfs_create_link+121/1d4>   <=====

>>edx; f3d6fb80 <pg0+33857b80/3fae6000>
>>esi; c0424ebb <devices_subsys+1b/58>
>>edi; f7010793 <pg0+36af8793/3fae6000>
>>ebp; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>esp; f3509e10 <pg0+32ff1e10/3fae6000>

Trace; c025fbc3 <device_bind_driver+3b/40>
Trace; c025fc2c <bus_match+64/76>
Trace; c025fc84 <device_attach+46/ad>
Trace; c025fe33 <bus_add_device+5b/a0>
Trace; c025eebc <device_add+a1/131>
Trace; f8ad6449 <pg0+385be449/3fae6000>
Trace; f8ad0e37 <pg0+385b8e37/3fae6000>
Trace; f8ad2618 <pg0+385ba618/3fae6000>
Trace; f8ad2ea8 <pg0+385baea8/3fae6000>
Trace; c011c876 <default_wake_function+0/18>
Trace; f8ad2bf4 <pg0+385babf4/3fae6000>
Trace; c01043f5 <kernel_thread_helper+5/b>

Code;  c019307e <sysfs_create_link+121/1d4>
00000000 <_EIP>:
Code;  c019307e <sysfs_create_link+121/1d4>   <=====
    0:   f0 ff 48 6c               lock decl 0x6c(%eax)   <=====
Code;  c0193082 <sysfs_create_link+125/1d4>
    4:   0f 88 b9 00 00 00         js     c3 <_EIP+0xc3>
Code;  c0193088 <sysfs_create_link+12b/1d4>
    a:   8b 44 24 34               mov    0x34(%esp),%eax
Code;  c019308c <sysfs_create_link+12f/1d4>
    e:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  c0193090 <sysfs_create_link+133/1d4>
   12:   89 14 00                  mov    %edx,(%eax,%eax,1)


1 warning and 1 error issued.  Results may not be reliable.
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using address 2
pwc Philips PCVC740K (ToUCam Pro) USB webcam detected.
drivers/usb/core/usb.c: deregistering driver audio
pwc Registered as /dev/video0.
usbaudio: device 2 audiocontrol interface 1 has 1 input and 0 output 
AudioStream
ing interfaces
usbaudio: device 2 interface 2 altsetting 0 FORMAT_TYPE descriptor not 
found
usbaudio: valid input sample rate 44100
usbaudio: device 2 interface 2 altsetting 1: format 0x00000010 sratelo 
44100 sra
tehi 44100 attributes 0x00
usbaudio: valid input sample rate 22050
usbaudio: device 2 interface 2 altsetting 2: format 0x00000010 sratelo 
22050 sra
tehi 22050 attributes 0x00
usbaudio: valid input sample rate 11025
usbaudio: device 2 interface 2 altsetting 3: format 0x00000010 sratelo 
11025 sra
tehi 11025 attributes 0x00
usbaudio: valid input sample rate 8000
usbaudio: device 2 interface 2 altsetting 4: format 0x00000010 sratelo 
8000 srat
ehi 8000 attributes 0x00
usbaudio: registered dsp 14,35
usbaudio: constructing mixer for Terminal 3 type 0x0101
usbaudio: warning: found 1 of 0 logical channels.
usbaudio: assuming the channel found is the master channel (got a Philips 
camera
?). Should be fine.
usbaudio: registered mixer 14,16
usb_audio_parsecontrol: usb_audio_state at f59dea80
Unable to handle kernel NULL pointer dereference at virtual address 
0000006c
  printing eip:
c019307e
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<c019307e>]    Tainted: P
EFLAGS: 00010246   (2.6.5)
EIP is at sysfs_create_link+0x121/0x1d4
eax: 00000000   ebx: 00000000   ecx: 0000006c   edx: f3d6fb80
esi: c0424ebb   edi: f7010793   ebp: ffffffff   esp: f3509e10
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 24628, threadinfo=f3508000 task=f345d740)
Stack: 0000003d 000000d0 f74f6280 f7010780 00000004 f3d6fb80 f8acdc50 
f6531994
        00000000 f65319ec c025fbc3 f8acdc1c f65319b8 f65319bc f8acdc00 
c025fc2c
        f6531994 f8acdc00 f8acdc38 f6531994 f8ae4a44 c025fc84 00200200 
f345d740
Call Trace:
  [<c025fbc3>] device_bind_driver+0x3b/0x40
  [<c025fc2c>] bus_match+0x64/0x76
  [<c025fc84>] device_attach+0x46/0xad
  [<c025fe33>] bus_add_device+0x5b/0xa0
  [<c025eebc>] device_add+0xa1/0x131
  [<f8ad6449>] usb_set_configuration+0x1d7/0x267 [usbcore]
  [<f8ad0e37>] usb_new_device+0x288/0x3d5 [usbcore]
  [<f8ad2618>] hub_port_connect_change+0x2b8/0x37a [usbcore]
  [<f8ad2ea8>] hub_thread+0x2b4/0x575 [usbcore]
  [<c011c876>] default_wake_function+0x0/0x18
  [<f8ad2bf4>] hub_thread+0x0/0x575 [usbcore]
  [<c01043f5>] kernel_thread_helper+0x5/0xb

Code: f0 ff 48 6c 0f 88 b9 00 00 00 8b 44 24 34 89 44 24 04 89 14



$ cat `which camon`
#!/bin/sh

# Load the usb core.
modprobe usbcore

# Load the initial PWC module.
modprobe pwc size=vga fps=30 mbufs=4 power_save=0 compression=0
#modprobe pwc size=cif fps=30 mbufs=4 power_save=0 compression=0
#modprobe pwc size=sif fps=30 mbufs=4 power_save=0 compression=0

# Force load the decompression module.
#insmod -f /appc/kernel/usb-pwcx-8.2.2/pwcx-i386.o > /dev/null 2>&1
insmod -f /appc/kernel/pwcx-8.4/2.4.23/gcc-3.2/pwcx.o > /dev/null 2>&1

# Setup the audio.
modprobe audio

# Load the USB driver.
modprobe uhci-hcd


# rmmod uhci_hcd
(hangs)
# rmmod -f uhci-hcd
ERROR: Removing 'uhci_hcd': Device or resource busy

