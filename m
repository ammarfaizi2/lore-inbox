Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTDOOTY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbTDOOTY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:19:24 -0400
Received: from franka.aracnet.com ([216.99.193.44]:56239 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261528AbTDOOTV 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:19:21 -0400
Date: Tue, 15 Apr 2003 07:31:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 585] New: Oops in usb_dump_interface after rmmod ov511
Message-ID: <48700000.1050417069@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=585

           Summary: Oops in usb_dump_interface after rmmod ov511
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: kees.bakker@xs4all.nl


Hardware Environment:
Problem Description:

Steps to reproduce:
# modprobe ov511
# rmmod ov511
# cat /proc/bus/usb/devices

Part of syslog:
Apr 13 20:26:46 iris kernel:  printing eip:
Apr 13 20:26:46 iris kernel: c027dd35
Apr 13 20:26:46 iris kernel: Oops: 0000 [#1]
Apr 13 20:26:46 iris kernel: CPU:    0
Apr 13 20:26:46 iris kernel: EIP:
0060:[usb_dump_interface_descriptor+85/176]    Not tainted
Apr 13 20:26:46 iris kernel: EFLAGS: 00010282
Apr 13 20:26:46 iris kernel: EIP is at
usb_dump_interface_descriptor+0x55/0xb0 Apr 13 20:26:46 iris kernel: eax:
e09e9640   ebx: d51d9e40   ecx: c036459b   edx: c036118b
Apr 13 20:26:46 iris kernel: esi: d456e0cd   edi: d0ef0680   ebp: 00000000  
esp: d595fd80
Apr 13 20:26:46 iris kernel: ds: 007b   es: 007b   ss: 0068
Apr 13 20:26:46 iris kernel: Process cat (pid: 4583, threadinfo=d595e000
task=d0d51280)
Apr 13 20:26:46 iris kernel: Stack: 000000ff d456ff00 d456e0a6 d456ff00
c01b4b07 d456e0a6 2ba91f5a c03547cc 
Apr 13 20:26:46 iris kernel:        d595fdd4 c01b4b2f d0ef0680 d456e0cd
d51d9e40 c027ddc5 d456e0cd d456ff00 
Apr 13 20:26:46 iris kernel:        d0ef0680 00000000 d0ef0680 00000001
d456e0cd d456ff00 c027df14 00000002 
Apr 13 20:26:46 iris kernel: Call Trace:
Apr 13 20:26:46 iris kernel:  [vsprintf+39/48] vsprintf+0x27/0x30
Apr 13 20:26:46 iris kernel:  [sprintf+31/48] sprintf+0x1f/0x30
Apr 13 20:26:46 iris kernel:  [usb_dump_interface+53/128]
usb_dump_interface+0x35/0x80
Apr 13 20:26:46 iris kernel:  [usb_dump_config+148/224]
usb_dump_config+0x94/0xe0 Apr 13 20:26:46 iris kernel:
[usb_dump_desc+170/192] usb_dump_desc+0xaa/0xc0 Apr 13 20:26:46 iris
kernel:  [usb_device_dump+296/832] usb_device_dump+0x128/0x340 Apr 13
20:26:46 iris kernel:  [usb_device_dump+603/832] usb_device_dump+0x25b/0x340
Apr 13 20:26:46 iris kernel:  [usb_device_dump+603/832]
usb_device_dump+0x25b/0x340 Apr 13 20:26:46 iris kernel:
[usb_device_read+194/272] usb_device_read+0xc2/0x110 Apr 13 20:26:46 iris
kernel:  [vfs_read+188/304] vfs_read+0xbc/0x130 Apr 13 20:26:46 iris
kernel:  [sys_read+62/96] sys_read+0x3e/0x60 Apr 13 20:26:46 iris kernel:
[syscall_call+7/11] syscall_call+0x7/0xb Apr 13 20:26:46 iris kernel: 
Apr 13 20:26:46 iris kernel: Code: 8b 50 04 89 54 24 24 0f b6 43 07 89 44
24 20 0f b6 43 06 89

