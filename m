Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUEaOn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUEaOn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUEaOn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:43:59 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:4065 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264641AbUEaOnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:43:53 -0400
Date: Mon, 31 May 2004 16:43:48 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops at get_kobj_path_length with 2.6.5/2.6.6 on boot/resume
Message-ID: <20040531144348.GX26838@khan.acc.umu.se>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've experienced this oops several times with both 2.6.5 and 2.6.6
(Debian-variant of the kernel, have not yet tried the non-Debian
 variant, but I will unless someone can spot something obviously
 wrong helped by this oops-dump...)

The context is usually bootup or resume, possibly also hotplug from
docking station.  The computer is an IBM Thinkpad T40.


Restarting tasks...<6>usb 4-1: USB disconnect, address 2
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01a0486
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01a0486>]    Not tainted
EFLAGS: 00010246   (2.6.6-1-686)
EIP is at get_kobj_path_length+0x26/0x40
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: de909138
esi: 00000001   edi: 00000000   ebp: ffffffff   esp: de7e1dfc
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1720, threadinfo=de7e0000 task=de83a270)
Stack: 0000015b d5176819 d5176800 dfb5b090 c01a0652 c02ec560 de909138 0000015b
       e0b2f040 c01615ed de7e1e3c d5176800 00000000 c02b44a0 e0b29d91 00000000
       c0169f51 de909138 de909130 e0b2efe0 e0b2f040 c01a07f7 c028f726 c02ec560
Call Trace:
 [<c01a0652>] kset_hotplug+0x152/0x290
 [<c01615ed>] lookup_hash+0x1d/0x30
 [<c0169f51>] dput+0x31/0x220
 [<c01a07f7>] kobject_hotplug+0x67/0x70
 [<c01a0b6b>] kobject_del+0x1b/0x40
 [<c01eff40>] class_device_del+0x90/0xc0
 [<e0b24f90>] hci_unregister_dev+0x10/0x90 [bluetooth]
 [<e0a90b75>] hci_usb_disconnect+0x35/0x90 [hci_usb]
 [<e0aa1106>] usb_unbind_interface+0x76/0x80 [usbcore]
 [<c01ef256>] device_release_driver+0x66/0x70
 [<c01ef395>] bus_remove_device+0x55/0xa0
 [<c01ee28d>] device_del+0x5d/0xa0
 [<c01ee2e3>] device_unregister+0x13/0x30
 [<e0aa7360>] usb_disable_device+0x70/0xb0 [usbcore]
 [<e0aa1d24>] usb_disconnect+0x94/0xf0 [usbcore]
 [<e0aa3f41>] hub_port_connect_change+0x281/0x290 [usbcore]
 [<e0aa38e3>] hub_port_status+0x43/0xb0 [usbcore]
 [<e0aa4217>] hub_events+0x2c7/0x340 [usbcore]
 [<e0aa42c5>] hub_thread+0x35/0x100 [usbcore]
 [<c0105f52>] ret_from_fork+0x6/0x14
 [<c01187d0>] default_wake_function+0x0/0x20
 [<e0aa4290>] hub_thread+0x0/0x100 [usbcore]
 [<c01042ad>] kernel_thread_helper+0x5/0x18

Code: f2 ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
