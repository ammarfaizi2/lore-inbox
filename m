Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUCXO5h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUCXO5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:57:37 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:30472 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S263735AbUCXO5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:57:31 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
References: <20040323232511.1346842a.akpm@osdl.org>
From: Alexander Hoogerhuis <alexh@boxed.no>
Date: Wed, 24 Mar 2004 15:57:24 +0100
In-Reply-To: <20040323232511.1346842a.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 23 Mar 2004 23:25:11 -0800")
Message-ID: <87smfynvhn.fsf@dorker.boxed.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> [SNIP]
>
 
I'm getting this oops when booting my shiny new HP nc6000 laptop
(PM-1.6 with integrated bluetooth and stuff) with bluetooth enabled:

Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.5
drivers/usb/core/usb.c: registered new driver hci_usb
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
e08c56be
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<e08c56be>]    Not tainted VLI
EFLAGS: 00010282   (2.6.5-rc2-mm2)
EIP is at usb_disable_interface+0x11/0x3f [usbcore]
eax: dea7f000   ebx: 00000000   ecx: c03a1310   edx: deb39080
esi: 00000001   edi: 00000000   ebp: deb65d50   esp: deb65d40
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5147, threadinfo=deb65000 task=deb423b0)
Stack: dea7f000 dea7f000 00000001 00000002 deb65d88 e08c5904 00000001 00000002
       00000001 00000000 00000000 00001388 00000000 ddab4db0 deb39080 00000000
       ddab4b80 ddab4c38 deb65e34 e09419da 00000246 deb65dd8 00000018 00000003
Call Trace:
 [<e08c5904>] usb_set_interface+0x92/0x143 [usbcore]
 [<e09419da>] hci_usb_probe+0x226/0x46e [hci_usb]
 [<c01a675e>] inode_doinit_with_dentry+0x3e/0x59a
 [<e08c0064>] usb_probe_interface+0x56/0x63 [usbcore]
 [<c01fb727>] bus_match+0x35/0x5e
 [<c01fb78f>] device_attach+0x3f/0x8f
 [<c0166129>] dput+0x1c/0x252
 [<c01fb945>] bus_add_device+0x67/0x9f
 [<c01fa9d8>] device_add+0x94/0x128
 [<e08c5c6d>] usb_set_configuration+0x1c9/0x251 [usbcore]
 [<e08c0f87>] usb_new_device+0x23f/0x3ae [usbcore]
 [<c011c8a7>] printk+0x121/0x172
 [<e08c26c3>] hub_port_connect_change+0x172/0x265 [usbcore]
 [<e08c2a3e>] hub_events+0x288/0x2fa [usbcore]
 [<e08c2ae0>] hub_thread+0x30/0xdd [usbcore]
 [<c0118aa1>] default_wake_function+0x0/0xc
 [<e08c2ab0>] hub_thread+0x0/0xdd [usbcore]
 [<c0105269>] kernel_thread_helper+0x5/0xb
                                                                                                                               
Code: 00 00 00 89 d1 c7 44 97 44 00 00 00 00 d3 e0 09 47 3c eb db 89 f8 ff d6
eb d5 55 89 e5 57 31 ff 56 53 83 ec 04 89 45 f0 8b 5a 04 <80> 7b 04 00 74 20
31 f6 8b 43 0c 83
c7 01 0f b6 54 30 02 83 c6


fwiw,
Alexander
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
