Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUA3Ri4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUA3Riz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:38:55 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6350 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263015AbUA3Rg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:36:58 -0500
Date: Fri, 30 Jan 2004 18:36:56 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: khubd crash on scanner disconnect
Message-ID: <20040130173656.GA4570@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just caught this khubd NULL dereference simply by unplugging my
scanner. Kernel is a current 2.6.2-rc2 from BK, PNP enabled:

usb 1-1: USB disconnect, address 2
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
 printing eip:
c0299a9c
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0299a9c>]    Not tainted
EFLAGS: 00010282
EIP is at disconnect_scanner+0x2c/0x5f
eax: ffffffff   ebx: d3d25094   ecx: c03d76d8   edx: 00000030
esi: 00000000   edi: d3cb28c0   ebp: d3dc1e24   esp: d3dc1e14
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=d3dc0000 task=d3f8e040)
Stack: d3d25080 c03d76d8 d3d25080 c03d7740 d3dc1e40 c02824f6 d3d25080 d3d25080 
       d3d25094 d3d25094 c03d7760 d3dc1e58 c023b456 d3d25094 d3d250c0 d3cb28fc 
       d3cb28e8 d3dc1e74 c02993ec d3d25094 d3d25080 d3cb28fc c03d766c 00000000 
Call Trace:
 [<c02824f6>] usb_unbind_interface+0x76/0x80
 [<c023b456>] device_release_driver+0x66/0x70
 [<c02993ec>] destroy_scanner+0x7c/0xe0
 [<c01e3225>] kobject_cleanup+0x95/0xa0
 [<c02824f6>] usb_unbind_interface+0x76/0x80
 [<c023b456>] device_release_driver+0x66/0x70
 [<c023b5cd>] bus_remove_device+0x6d/0xb0
 [<c023a394>] device_del+0x74/0xd0
 [<c0288a20>] usb_disable_device+0x90/0xc0
 [<c0282fd4>] usb_disconnect+0xd4/0x120
 [<c028562f>] hub_port_connect_change+0x22f/0x350
 [<c0285041>] hub_port_status+0x41/0xb0
 [<c02859c6>] hub_events+0x276/0x330
 [<c0285ad3>] hub_thread+0x53/0x110
 [<c011f6c0>] default_wake_function+0x0/0x20
 [<c0285a80>] hub_thread+0x0/0x110
 [<c01092a9>] kernel_thread_helper+0x5/0xc

Code: 80 7e 1e 00 75 16 85 f6 74 21 8d 46 3c 8b 5d f8 8b 75 fc 89 

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
