Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbTCZTwx>; Wed, 26 Mar 2003 14:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbTCZTww>; Wed, 26 Mar 2003 14:52:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:4294 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262397AbTCZTwt>;
	Wed, 26 Mar 2003 14:52:49 -0500
Date: Wed, 26 Mar 2003 11:54:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 509] New: NULL pointer when rmmod faulty driver
Message-ID: <1451130000.1048708440@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=509

           Summary: NULL pointer when rmmod faulty driver
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: bugzilla@pointdefence.net


Distribution:
downloaded and built with gcc 3.2.1
Hardware Environment:
Intel 586
Software Environment:
glibc 1.2.10
module-init-tools version 0.9.10
Problem Description:
I'm removing a usb driver which has failed. when I remove the usb cable before
rmmod the driver

Mar 26 20:23:33 localhost modprobe: FATAL: Module /dev/video0 not found. 
Mar 26 20:27:14 localhost kernel: drivers/usb/host/uhci-hcd.c: 1000: host
controller halted. very bad
Mar 26 20:27:14 localhost kernel: usb 1-1: USB disconnect, address 2
Mar 26 20:27:14 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000008f
Mar 26 20:27:14 localhost kernel:  printing eip:
Mar 26 20:27:14 localhost kernel: ce8c2a3c
Mar 26 20:27:14 localhost kernel: *pde = 00000000
Mar 26 20:27:14 localhost kernel: Oops: 0000
Mar 26 20:27:14 localhost kernel: CPU:    0
Mar 26 20:27:14 localhost kernel: EIP:    0060:[<ce8c2a3c>]    Tainted: GF 
Mar 26 20:27:14 localhost kernel: EFLAGS: 00010206
Mar 26 20:27:14 localhost kernel: EIP is at qc_usb_disconnect+0x98/0x268 [quickcam]
Mar 26 20:27:14 localhost kernel: eax: ce8d07c0   ebx: 00000077   ecx: ce8c29a4
  edx: ca38b3e0
Mar 26 20:27:14 localhost kernel: esi: ce8d07d8   edi: ce8d07c0   ebp: c13edeb0
  esp: c13ede50
Mar 26 20:27:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 20:27:14 localhost kernel: Process khubd (pid: 4, threadinfo=c13ec000
task=cdfab240)
Mar 26 20:27:14 localhost kernel: Stack: c6f0b160 c13ede68 c016a099 cdfec4b0
c13121a0 c13121a0 c13ede7c c016b0d3 
Mar 26 20:27:14 localhost kernel:        c13121a0 c6f0b160 c6f0b160 c13ede94
c01683d0 ce8d0844 ce8d0844 c02e8bde 
Mar 26 20:27:14 localhost kernel:        ca38b3e0 00000077 c0186009 c6f0b980
ca38b3e0 ca38b3f8 ce8d07d8 ca38b3f8 
Mar 26 20:27:14 localhost kernel: Call Trace:
Mar 26 20:27:14 localhost kernel:  [<c016a099>] destroy_inode+0x59/0x60
Mar 26 20:27:14 localhost kernel:  [<c016b0d3>] iput+0x63/0x90
Mar 26 20:27:14 localhost kernel:  [<c01683d0>] dput+0x30/0x170
Mar 26 20:27:14 localhost kernel:  [<ce8d0844>] qc_usb_driver+0x84/0xa0 [quickcam]
Mar 26 20:27:14 localhost kernel:  [<ce8d0844>] qc_usb_driver+0x84/0xa0 [quickcam]
Mar 26 20:27:14 localhost kernel:  [<c02e8bde>] usb_device_remove+0xde/0x120
Mar 26 20:27:14 localhost kernel:  [<c0186009>] hash_and_remove+0x69/0xb0
Mar 26 20:27:14 localhost kernel:  [<ce8d07d8>] qc_usb_driver+0x18/0xa0 [quickcam]
Mar 26 20:27:14 localhost kernel:  [<c0250e56>] device_release_driver+0x66/0x70
Mar 26 20:27:14 localhost kernel:  [<c0250fef>] bus_remove_device+0x7f/0xd0
Mar 26 20:27:14 localhost kernel:  [<c025013c>] device_del+0x7c/0xc0
Mar 26 20:27:14 localhost kernel:  [<c0250194>] device_unregister+0x14/0x22
Mar 26 20:27:14 localhost kernel:  [<c02e9637>] usb_disconnect+0x97/0x100
Mar 26 20:27:14 localhost kernel:  [<c02ec06f>]
usb_hub_port_connect_change+0x33f/0x350
Mar 26 20:27:14 localhost kernel:  [<c02eb938>] usb_hub_port_status+0x68/0xb0
Mar 26 20:27:14 localhost kernel:  [<c02ec398>] usb_hub_events+0x318/0x3a0
Mar 26 20:27:14 localhost kernel:  [<c02ec455>] usb_hub_thread+0x35/0xf0
Mar 26 20:27:14 localhost kernel:  [<c011c930>] default_wake_function+0x0/0x20
Mar 26 20:27:14 localhost kernel:  [<c02ec420>] usb_hub_thread+0x0/0xf0
Mar 26 20:27:14 localhost kernel:  [<c010826d>] kernel_thread_helper+0x5/0x18
Mar 26 20:27:14 localhost kernel: 
Mar 26 20:27:14 localhost kernel: Code: 8b 43 18 85 c0 75 39 83 ec 0c 8d 44 24
2c 50 e8 90 cf 84 f1 

Then when I try to rmmod the driver I get

Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Tainted: GF 
EFLAGS: 00010246
EIP is at 0x0
eax: 00000000   ebx: c042b9d8   ecx: c042b9d8   edx: 00000000
esi: 00000880   edi: ce8d1860   ebp: c3fe5fbc   esp: c3fe5f58
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 13369, threadinfo=c3fe4000 task=c92aa7a0)
Stack: c01321eb c03b087b 00000077 0000003b 00000000 00000000 63697571 6d61636b 
       c3fe5f00 00000046 c04dbb48 00000046 c3fe4000 c3fe4000 00000000 c3fe5fbc 
       c010bd78 00000000 c3fe5fc4 c0429124 00429124 c04a9900 bffff768 bffff97a 
Call Trace:
 [<c01321eb>] sys_delete_module+0x1cb/0x220
 [<c010bd78>] do_IRQ+0x108/0x130
 [<c010a563>] syscall_call+0x7/0xb

Code:  Bad EIP value.

Steps to reproduce:

is this a kernel problem??


