Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTJ0Pus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTJ0Pus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:50:48 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:16070 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262982AbTJ0Puo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:50:44 -0500
Date: Mon, 27 Oct 2003 07:50:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1430] New: SysFS oops when rmmod'ing uhci-hcd	after resuming from suspend 
Message-ID: <605230000.1067269839@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1430

           Summary: SysFS oops when rmmod'ing uhci-hcd after resuming from
                    suspend
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: normal
             Owner: mochel@osdl.org
         Submitter: felipe_alfaro@linuxmail.org


Distribution: 
------------- 
Fedora Core Test 3. 
Nothing special with it, since the problems is reproducible by booting with 
"init=/bin/bash" kernel command line parameter. 
 
Hardware Environment: 
--------------------- 
Packard Bell Chrom@ laptop: 
Pentium III 700 Mhz 
Intel 440BX chipset 
Texas Instruments PCI4450 CardBus bridge 
ATI RAGE Mobility M1 AGP video card with 8MB of DRAM 
3Com 3CCFE575CT 10/100 CardBus NIC 
Microsoft Intellimouse Explorer USB mouse 
 
Please, see attached "lspci" file for more details. 
 
Software Environment: 
--------------------- 
Nothing special 
 
Problem Description: 
-------------------- 
After resuming my laptop from APM suspend, running "rmmod uhci-hcd" causes the 
following oops: 
 
Unable to handle kernel NULL pointer dereference at virtual address 00000000 
 printing eip: 
c017fba6 
*pde = 00000000 
Oops: 0000 [#1] 
CPU:    0 
EIP:    0060:[<c017fba6>]    Not tainted 
EFLAGS: 00010292 
EIP is at sysfs_get_dentry+0x16/0x70 
eax: 00000000   ebx: cf885acc   ecx: ffffffff   edx: 00000000 
esi: cf8f8280   edi: 00000000   ebp: cf885c24   esp: cf54be38 
ds: 007b   es: 007b   ss: 0068 
Process rmmod (pid: 454, threadinfo=cf54a000 task=cf54d900) 
Stack: c015df9d cf54be54 00000000 00000000 c017fbf5 cf810580 cf885acc cf885c00 
       c017fc2a cf8f8280 00000000 cf885acc d0879ec0 c01c33f8 cf8f8280 00000000 
       cf885acc cf885ccc c01c3575 cf885acc cf885b28 cf885acc cf885ccc c01c244d 
Call Trace: 
 [<c015df9d>] lookup_hash+0x1d/0x30 
 [<c017fbf5>] sysfs_get_dentry+0x65/0x70 
 [<c017fc2a>] sysfs_hash_and_remove+0x2a/0x7d 
 [<c01c33f8>] device_release_driver+0x28/0x70 
 [<c01c3575>] bus_remove_device+0x55/0xa0 
 [<c01c244d>] device_del+0x5d/0xa0 
 [<c01c24a3>] device_unregister+0x13/0x30 
 [<d0863d28>] usb_disconnect+0xd8/0xf0 [usbcore] 
 [<d086c119>] usb_hcd_pci_remove+0x89/0x180 [usbcore] 
 [<c01a2acb>] pci_device_remove+0x3b/0x40 
 [<c01c3436>] device_release_driver+0x66/0x70 
 [<c01c346b>] driver_detach+0x2b/0x40 
 [<c01c36ad>] bus_remove_driver+0x3d/0x80 
 [<c01c3ab3>] driver_unregister+0x13/0x28 
 [<c01a2ca6>] pci_unregister_driver+0x16/0x30 
 [<d085506f>] uhci_hcd_cleanup+0xf/0x5e [uhci_hcd] 
 [<c0130299>] sys_delete_module+0x139/0x1b0 
 [<c0144000>] do_munmap+0x80/0x190 
 [<c0109339>] sysenter_past_esp+0x52/0x71 
 
Code: f2 ae f7 d1 49 89 4c 24 0c 31 db 89 d7 49 83 f9 ff 74 24 8d 
 
Steps to reproduce: 
------------------- 
This problem can be always reproduced by performing the following steps: 
 
0. Make sure the Intellimouse USB mouse is plugged. 
1. Boot into 2.6.0-test9 with "init=/bin/bash" 
2. Run "apm -s" 
3. Let the system suspend, then resume it from suspension. 
4. On the command line, run "rmmod uhci-hcd" 
5. The previously described oops will be triggered. 
 
Additional information: 
----------------------- 
Please, see the attached "config" file for information on the configuration 
used to build the kernel.




