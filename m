Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUIQW1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUIQW1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUIQW0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:26:16 -0400
Received: from outbound04.telus.net ([199.185.220.223]:30958 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id S269077AbUIQWYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:24:31 -0400
Subject: [2.6.9-rc2-bk] Network-related panic on boot
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095459971.8786.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 16:26:11 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently built 2.6.9-rc2-bk3.  It throws a panic on boot. 
2.6.9-rc2-bk2 boots OK.
The error message I get (copied by hand) is:
Enabling local filesystem quotas:                          [ OK ]
Enabling swap space:                                       [ OK ]
INIT: Entering runlevel: 5                                 [ OK ]
Entering non-interactive startup
Applying Intel IA32 Microcode update:                      [ OK ]
Starting sysstat:                                          [ OK ]
Starting readahead_early:                                  [ OK ]
Checking for new hardware------------[ cut here ]------------
kernel BUG at net/ipv4/fib_semantics.c:1039!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: sis900 sg scsi_mod usblp ohci_hcd usbcore thermal
processor fan button battery asus_acpi ac
CPU:    0
EIP:    0060:[<c029d318>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc2-bk3)
EIP is at fib_sync_down+0x1b9/0x1c6
eax: ffffffff   ebx: 00000000   ecx: c03375a0   edx: 00000000
esi: 00000000   edi: 00000006   ebp: f796c138   esp: f79cfe38
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2389, threadinfo=f79ce000 task=f7859560)
Stack: 00000000 00000000 f796c138 ffffffff 00000000 f796c000 f796c000
00000006
       f796c138 c029b7ba 00000000 f796c000 00000002 c033a55c c029b8dd
f796c000
       00000002 c033a55c f796c000 c0124c58 c033a55c 00000006 f796c000
f796c000
Call Trace:
 [<c029b7ba>] fib_disable_ip+0x23/0x4a
 [<c029b8dd>] fib_netdev_event+0x8a/0x99
 [<c0124c58>] notifier_call_chain+0x27/0x3e
 [<c025c505>] unregister_netdevice+0x15b/0x270
 [<c021e398>] unregister_netdev+0x18/0x24
 [<f8ad594e>] sis900_remove+0x85/0xc3 [sis900]
 [<c01bf5f9>] pci_device_remove+0x3b/0x3d
 [<c02078b5>] device_release_driver+0x64/0x66
 [<c02078d7>] driver_detatch+0x20/0x2e
 [<c0207ce4>] bus_remove_driver+0x4c/0x84
 [<c02081ac>] driver_unregister+0x13/0x28
 [<c01bf81d>] pci_unregister_driver+0x16/0x26
 [<f8ad567b>] sis900_cleanup_module+0xf/0x13 [sis900]
 [<c012d36a>] sys_delete_module+0x153/0x183
 [<c0142e77>] do_munmap+0x142/0x17f
 [<c0104019>] sysenter_past_esp+0x52/0x71
Code: 4f 5c e9 78 ff ff ff e8 47 0f 01 00 eb e7 0f 0b 2a 04 17 a3 2d c0
e9 16 ff ff ff 83 48 1c 01 83 44 24 10 01 8b 11 e9 b9 fe ff ff <0f> 0b
0f 04 17 a3 2d c0 e9 77 fe f ff 55 57 56 53 83 ec 10 8b
                                                                                
Updating /etc/fstab                                        [ OK ]
Applying iptables firewall rules:                          [ OK ]
Setting network parameters:                                [ OK ]
Bringing up loopback interface:

...and that's where everything stops.  If (you really want) I can send
the jpegs the digital camera made of the error.  I have a Soyo MB, with
a SiS chipset, the SiS 900 is the integrated 10/100 ethernet controller,
which lspci (from 2.6.9-rc2-bk2) shows as:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645 Host &
Memory & AGP Controller (rev 02)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI
bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS961 [MuTIOL
Media IO]
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI
Fast Ethernet (rev 90)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 02)
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3)

I am running FC2 (updated with yum and up2date).

If you need more information, please reply.
TIA,
Bob

