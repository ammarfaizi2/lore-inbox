Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTILSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbTILSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:30:20 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:40973
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261809AbTILS1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:27:39 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops during USB unloading, 2.6.0-test{4,5}. sysfs?
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 12 Sep 2003 14:27:36 -0400
Message-ID: <87he3hg8vb.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both test4 and test5, I get the following panic when I attempt to
do a clean shutdown.  It happens every time.  The problem may be in
the sysfs code given where the trace begins.  The error message given
before reboot was that the kernel couldn't handle a NULL pointer
dereference, but for some reason, that didn't make it into
/var/log/messages.

BTW, if I'm not giving you guys enough interesting information about
these problems, please let me know.  There's no such thing as too much
information. :) I can also recompile with frame pointers, if that will
help.

Cheers,
Kyle

Sep  7 20:44:00 nausicaa shutdown[1699]: shutting down for system reboot
Sep  7 20:44:07 nausicaa kernel: ehci_hcd 0000:02:08.2: remove, state 1
Sep  7 20:44:07 nausicaa kernel: usb usb1: USB disconnect, address 1
Sep  7 20:44:07 nausicaa kernel: usb 1-4: USB disconnect, address 2
Sep  7 20:44:07 nausicaa kernel: usb 1-4.1: USB disconnect, address 3
Sep  7 20:44:07 nausicaa kernel: usb 1-4.1.2: USB disconnect, address 4
Sep  7 20:44:07 nausicaa kernel: ehci_hcd 0000:02:08.2: USB bus 1 deregistered
Sep  7 20:44:07 nausicaa kernel: ohci-hcd 0000:00:07.4: remove, state 3
Sep  7 20:44:07 nausicaa kernel: usb usb2: USB disconnect, address 1
Sep  7 20:44:07 nausicaa kernel: ohci-hcd 0000:00:07.4: USB bus 2 deregistered
Sep  7 20:44:07 nausicaa kernel: hub 4-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Sep  7 20:44:07 nausicaa kernel: ohci-hcd 0000:02:08.0: remove, state 3
Sep  7 20:44:07 nausicaa kernel: usb usb3: USB disconnect, address 1
Sep  7 20:44:07 nausicaa kernel: hub 4-0:0: new USB device on port 2, assigned address 2
Sep  7 20:44:07 nausicaa kernel: hub 4-2:0: USB hub found
Sep  7 20:44:07 nausicaa kernel: ohci-hcd 0000:02:08.0: USB bus 3 deregistered
Sep  7 20:44:07 nausicaa kernel: ohci-hcd 0000:02:08.1: remove, state 3
Sep  7 20:44:07 nausicaa kernel: usb usb4: USB disconnect, address 1
Sep  7 20:44:07 nausicaa kernel: usb 4-2: USB disconnect, address 2
Sep  7 20:44:07 nausicaa kernel:  printing eip:
Sep  7 20:44:07 nausicaa kernel: c018ddc5
Sep  7 20:44:07 nausicaa kernel: Oops: 0002 [#1]
Sep  7 20:44:07 nausicaa kernel: CPU:    1
Sep  7 20:44:07 nausicaa kernel: EIP:    0060:[sysfs_hash_and_remove+21/124]    Not tainted
Sep  7 20:44:07 nausicaa kernel: EFLAGS: 00010286
Sep  7 20:44:07 nausicaa kernel: EIP is at sysfs_hash_and_remove+0x15/0x7c
Sep  7 20:44:07 nausicaa kernel: eax: 00000000   ebx: c0311678   ecx: 0000006c   edx: df012574
Sep  7 20:44:07 nausicaa kernel: esi: df012500   edi: dffa1400   ebp: dd91a000   esp: dd91be28
Sep  7 20:44:07 nausicaa kernel: ds: 007b   es: 007b   ss: 0068
Sep  7 20:44:07 nausicaa kernel: Process rmmod (pid: 1973, threadinfo=dd91a000 task=df2e3320)
Sep  7 20:44:07 nausicaa kernel: Stack: c018dd9b dd91be34 c0311678 df012500 c018f36d df012500 c02a7126 df012500 
Sep  7 20:44:07 nausicaa kernel:        c031167c c018f498 df012500 c031167c c031164c d8e8bd58 c01f5f9a d8e8bd7c 
Sep  7 20:44:07 nausicaa kernel:        c031167c c01f59ac d8e8bd58 c02bcba9 d8e8bd7c d8e8bd58 dffa14d0 c01f313a 
Sep  7 20:44:07 nausicaa kernel: Call Trace:
Sep  7 20:44:07 nausicaa kernel:  [sysfs_get_dentry+107/128] sysfs_get_dentry+0x6b/0x80
Sep  7 20:44:07 nausicaa kernel:  [remove_files+45/64] remove_files+0x2d/0x40
Sep  7 20:44:07 nausicaa kernel:  [sysfs_remove_group+40/144] sysfs_remove_group+0x28/0x90
Sep  7 20:44:07 nausicaa kernel:  [dpm_sysfs_remove+26/64] dpm_sysfs_remove+0x1a/0x40
Sep  7 20:44:07 nausicaa kernel:  [device_pm_remove+76/136] device_pm_remove+0x4c/0x88
Sep  7 20:44:07 nausicaa kernel:  [device_del+26/160] device_del+0x1a/0xa0
Sep  7 20:44:07 nausicaa kernel:  [device_unregister+19/48] device_unregister+0x13/0x30
Sep  7 20:44:07 nausicaa kernel:  [usb_disconnect+228/272] usb_disconnect+0xe4/0x110
Sep  7 20:44:07 nausicaa kernel:  [usb_disconnect+252/272] usb_disconnect+0xfc/0x110
Sep  7 20:44:07 nausicaa kernel:  [usb_hcd_pci_remove+127/384] usb_hcd_pci_remove+0x7f/0x180
Sep  7 20:44:07 nausicaa kernel:  [pci_device_remove+59/64] pci_device_remove+0x3b/0x40
Sep  7 20:44:07 nausicaa kernel:  [device_release_driver+100/112] device_release_driver+0x64/0x70
Sep  7 20:44:07 nausicaa kernel:  [driver_detach+32/48] driver_detach+0x20/0x30
Sep  7 20:44:07 nausicaa kernel:  [bus_remove_driver+62/128] bus_remove_driver+0x3e/0x80
Sep  7 20:44:07 nausicaa kernel:  [driver_unregister+19/42] driver_unregister+0x13/0x2a
Sep  7 20:44:07 nausicaa kernel:  [pci_unregister_driver+22/48] pci_unregister_driver+0x16/0x30
Sep  7 20:44:07 nausicaa kernel:  [__crc_agp_memory_reserved+1785107/3492907] ohci_hcd_pci_cleanup+0xf/0x13 [ohci_hcd]
Sep  7 20:44:07 nausicaa kernel:  [sys_delete_module+313/368] sys_delete_module+0x139/0x170
Sep  7 20:44:07 nausicaa kernel:  [sys_munmap+69/112] sys_munmap+0x45/0x70
Sep  7 20:44:07 nausicaa kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep  7 20:44:07 nausicaa kernel: 
Sep  7 20:44:07 nausicaa kernel: Code: f0 ff 48 6c 78 61 89 34 24 8b 44 24 18 89 44 24 04 e8 55 ff 
Sep  7 20:44:07 nausicaa kernel:  <6>hub 4-2:0: 4 ports detected
Sep  7 20:44:07 nausicaa usb.agent[2062]: ... no modules for USB product 409/58/100
