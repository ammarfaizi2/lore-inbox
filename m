Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTIYERM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIYERM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:17:12 -0400
Received: from tantale.fifi.org ([216.27.190.146]:50308 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261678AbTIYERC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 00:17:02 -0400
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: Oops in vanilla 2.4.22 serial-usb driver
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 24 Sep 2003 21:17:00 -0700
Message-ID: <87llsdy01v.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened at the end of a Palm sync.
The machine went on, but USB is not irresponsive to USB attach/detach
since khubd is dead. The USB low-level driver is UHCI_ALT, compiled
in-kernel.

BTW, is there any way to restart khubd without rebooting?

Phil.

Kernel info:

vanilla 2.4.22 + vfs-lock + lvm-1.0.7 + kmsgdump 0.4.4
Linux ceramic 2.4.22 #1 SMP Tue Sep 16 18:14:44 PDT 2003 i686 unknown

Oops:

Unable to handle kernel NULL pointer dereference at virtual address 000009a4
ed341d05
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<ed341d05>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: dae4bc90   ecx: 00000046   edx: 00000001
esi: 00000002   edi: dae4bc00   ebp: 00000000   esp: e7d1df48
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 10, stackpage=e7d1d000)
Stack: ed342e20 d16591e0 ed342e40 c01f2fd0 ce5eac00 dae4bc00 00000100 00000002 
       e7d2b000 00000001 00000000 ce5eac00 c01f539e e7d2b114 00000001 00000002 
       e7d2b000 e7d1f8a0 00000001 00000001 0000000a c01f565d e7d1f8a0 00000001 
Call Trace:    [<ed342e20>] [<ed342e40>] [<c01f2fd0>] [<c01f539e>] [<c01f565d>]
  [<c01f584b>] [<c0105a54>]
Code: c7 80 a4 09 00 00 00 00 00 00 8d 4b 5c f0 ff 43 5c 0f 8e ae 


>>EIP; ed341d05 <[usbserial]usb_serial_disconnect+6d/1ec>   <=====

>>ebx; dae4bc90 <_end+1aae7f44/284a02b4>
>>edi; dae4bc00 <_end+1aae7eb4/284a02b4>
>>esp; e7d1df48 <_end+279ba1fc/284a02b4>

Trace; ed342e20 <[usbserial]usb_serial_driver+0/0>
Trace; ed342e40 <[usbserial].data.start+20/3c>
Trace; c01f2fd0 <usb_disconnect+88/128>
Trace; c01f539e <usb_hub_port_connect_change+4a/20c>
Trace; c01f565d <usb_hub_events+fd/29c>
Trace; c01f584b <usb_hub_thread+4f/f4>
Trace; c0105a54 <arch_kernel_thread+28/38>

Code;  ed341d05 <[usbserial]usb_serial_disconnect+6d/1ec>
00000000 <_EIP>:
Code;  ed341d05 <[usbserial]usb_serial_disconnect+6d/1ec>   <=====
   0:   c7 80 a4 09 00 00 00      movl   $0x0,0x9a4(%eax)   <=====
Code;  ed341d0c <[usbserial]usb_serial_disconnect+74/1ec>
   7:   00 00 00 
Code;  ed341d0f <[usbserial]usb_serial_disconnect+77/1ec>
   a:   8d 4b 5c                  lea    0x5c(%ebx),%ecx
Code;  ed341d12 <[usbserial]usb_serial_disconnect+7a/1ec>
   d:   f0 ff 43 5c               lock incl 0x5c(%ebx)
Code;  ed341d16 <[usbserial]usb_serial_disconnect+7e/1ec>
  11:   0f 8e ae 00 00 00         jle    c5 <_EIP+0xc5> ed341dca <[usbserial]usb_serial_disconnect+132/1ec>

Module list:

nfsd                   67264  12
visor                  10624   0
usbserial              16224   0 [visor]
microcode               3744   0 (autoclean)
mousedev                3904   1
lvm-mod                59680   9
quota_v2                6376   2
nfs                    69372   5
lockd                  47648   1 [nfsd nfs]
sunrpc                 65396   1 [nfsd nfs lockd]
vfat                    9308   0 (unused)
msdos                   4828   0
fat                    29944   0 [vfat msdos]
isofs                  17408   0 (unused)
udf                    79392   0 (unused)
eeprom                  3520   0 (unused)
mtp008                  8064   0 (unused)
i2c-proc                5952   0 [eeprom mtp008]
i2c-viapro              3848   0 (unused)
i2c-core               12192   0 [eeprom mtp008 i2c-proc i2c-viapro]
syncfb                 12098   0 (unused)
matroxfb_base          19040  63
matroxfb_DAC1064        5312   0 [matroxfb_base]
matroxfb_accel          7264   0 [matroxfb_base matroxfb_DAC1064]
matroxfb_misc          14528   0 [matroxfb_base matroxfb_DAC1064 matroxfb_accel]fbcon-cfb24             4192   0 [matroxfb_accel]
fbcon-cfb8              3264   0 [matroxfb_accel]
fbcon-cfb32             3616   0 [matroxfb_accel]
fbcon-cfb16             3904   0 [matroxfb_accel]
mga_vid                 8256   0
mga                    98576   1
agpgart                17696   3
emu10k1                56512   2
sound                  52940   0 [emu10k1]
ac97_codec             11648   0 [emu10k1]
soundcore               3460   7 [emu10k1 sound]
apm                     9504   0
softdog                 1764   1
loop                    8624   0
floppy                 47072   0
sg                     25092   0 (unused)
sr_mod                 11896   0
cdrom                  26976   0 [sr_mod]
st                     27344   0
3c59x                  25864   1
af_packet              13096   0 (unused)
