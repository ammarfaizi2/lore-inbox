Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbTCUHiN>; Fri, 21 Mar 2003 02:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263445AbTCUHiN>; Fri, 21 Mar 2003 02:38:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1666 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263316AbTCUHiI>; Fri, 21 Mar 2003 02:38:08 -0500
Date: Thu, 20 Mar 2003 23:49:04 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 479] New: visor module oops 
Message-ID: <314380000.1048232944@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=479

           Summary: visor module oops
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: fabrice@fma.homelinux.com


Distribution: Mandrake Cooker 
Hardware Environment: Hitachi laptop, Intel USB controller/PIIX4 chipset 
Software Environment: pilot-link/kpilot,nodevfs, nohotplug running 
Problem Description: oops when unloading visor module 
 
Steps to reproduce: 
Plug in your palm (I use a clie T615C). Press the hotsync button. 
Then modprobe visor module. Press cancel on the palm. 
rmmod visor and it rmmod segfault. 
On the other hand, if I modprobe visor first, then press the button, 
then run kpilot, then it works perfectly. 
 
dmesg gives: 
Unable to handle kernel NULL pointer dereference at virtual address 00000004 
 printing eip: 
c01f577b 
*pde = 00000000 
Oops: 0002 
CPU:    0 
EIP:    0060:[<c01f577b>]    Not tainted 
EFLAGS: 00010246 
EIP is at devclass_remove_driver+0x4b/0x90 
eax: d0915c04   ebx: c03605c4   ecx: 00000000   edx: 00000000 
esi: c0360580   edi: d0915bbc   ebp: c42d7f14   esp: c42d7f00 
ds: 007b   es: 007b   ss: 0068 
Process rmmod (pid: 20800, threadinfo=c42d6000 task=c74bd2e0) 
Stack: c030c1ff 00000042 d090fa80 d090fa40 d0915bbc c42d7f30 c01f4fbf d0915bbc  
       00000042 d0915bc8 d0915bbc d0915d60 c42d7f48 c01f53fa d0915bbc 
c0358ab8  
       c0358ab8 00000880 c42d7f54 d09137ce d0915bbc c42d7fbc c012df1e 
c030c008  
Call Trace: 
 [<d090fa80>] usb_serial_bus_type+0x40/0xe0 [usbserial] 
 [<d090fa40>] usb_serial_bus_type+0x0/0xe0 [usbserial] 
 [<d0915bbc>] handspring_device+0x1c/0xe0 [visor] 
 [<c01f4fbf>] bus_remove_driver+0x5f/0xa0 
 [<d0915bbc>] handspring_device+0x1c/0xe0 [visor] 
 [<d0915bc8>] handspring_device+0x28/0xe0 [visor] 
 [<d0915bbc>] handspring_device+0x1c/0xe0 [visor] 
 [<d0915d60>] +0x0/0x100 [visor] 
 [<c01f53fa>] driver_unregister+0x1a/0x44 
 [<d0915bbc>] handspring_device+0x1c/0xe0 [visor] 
 [<d09137ce>] +0x1e/0x30 [visor] 
 [<d0915bbc>] handspring_device+0x1c/0xe0 [visor] 
 [<c012df1e>] sys_delete_module+0x1de/0x240 
 [<c0142317>] sys_munmap+0x57/0x80 
 [<c010948b>] syscall_call+0x7/0xb 
 
Code: 89 4a 04 89 11 89 40 04 89 47 48 89 3c 24 e8 42 fe ff ff 89 
 
I use a vanilla 2.5.65, modules-init-tools 0.9.9.

