Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTJPNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTJPNG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:06:57 -0400
Received: from pool-141-154-145-186.wma.east.verizon.net ([141.154.145.186]:23936
	"EHLO pool-141-154-145-186.wma.east.verizon.net") by vger.kernel.org
	with ESMTP id S262887AbTJPNGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:06:55 -0400
Date: Thu, 16 Oct 2003 09:06:52 -0400
From: Eric Buddington <eric@pool-141-154-145-186.wma.east.verizon.net>
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com
Subject: Badness with modprobe for 3c509B
Message-ID: <20031016090652.A4776@pool-141-154-145-186.wma.east.verizon.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6.0-tset7 with squashfs patch

On an old 486 machine, I get the following error while modprobing 3c509.
All hardware used is elderly and a possible source of errors.

This error is repeatable (4 of 4 tries).

-------------------- dmesg -----------------------
smc-ultra.c: Presently autoprobing (not recommended) for a single card.
divert: not allocating divert_blk for non-ethernet device eth0
smc-ultra.c: No ISAPnP cards found, trying standard ones...
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC Ultra at 0x300, 00 00 C0 35 16 7B, IRQ 10 memory 0xcc000-0xcffff.
pnp: Device 00:01.00 activated.
divert: allocating divert_blk for eth1
eth1: 3c5x9 found at 0x220, 10baseT port, address  00 20 af 69 50 1e, IRQ 5.
3c509.c:1.19b 08Nov2002 becker@scyld.com
http://www.scyld.com/network/3c509.html
Badness in kobject_get at lib/kobject.c:430
Call Trace:
 [<c021cf7c>] kobject_get+0x3c/0x50
 [<c027f22a>] get_bus+0x1a/0x40
 [<c027f0a3>] bus_add_driver+0x13/0xa0
 [<c027f4ff>] driver_register+0x2f/0x40
 [<c02c1d36>] mca_register_driver+0x16/0x30
 [<c280fa8e>] el3_init_module+0x9e/0xc1 [3c509]
 [<c0138208>] sys_init_module+0x108/0x240
 [<c010a267>] syscall_call+0x7/0xb

Badness in kobject_get at lib/kobject.c:430
Call Trace:
 [<c021cf7c>] kobject_get+0x3c/0x50
 [<c021cb79>] kobject_init+0x29/0x50
 [<c021cda7>] kobject_register+0x17/0x50
 [<c027f0c9>] bus_add_driver+0x39/0xa0
 [<c027f4ff>] driver_register+0x2f/0x40
 [<c02c1d36>] mca_register_driver+0x16/0x30
 [<c280fa8e>] el3_init_module+0x9e/0xc1 [3c509]
 [<c0138208>] sys_init_module+0x108/0x240
 [<c010a267>] syscall_call+0x7/0xb

Unable to handle kernel NULL pointer dereference at virtual address 00000048
 printing eip:
c021cd2a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c021cd2a>]    Not tainted
EFLAGS: 00010246
EIP is at kobject_add+0xea/0x150
eax: 00000048   ebx: 00000000   ecx: 00000000   edx: ffff0001
esi: 00000048   edi: c2825b00   ebp: c1cadf38   esp: c1cadf28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 18, threadinfo=c1cac000 task=c1eda180)
Stack: 00000000 c2825b00 ffffffea c2825ae8 c1cadf50 c021cdad c2825b00 c2825b00 
       c2825b00 c04199c0 c1cadf74 c027f0c9 c2825b00 c2825b00 c2823744 00000000 
       c03dc350 c2825c00 c1cac000 c1cadf90 c027f4ff c2825ae8 69af2000 c2811e50 
Call Trace:
 [<c021cdad>] kobject_register+0x1d/0x50
 [<c027f0c9>] bus_add_driver+0x39/0xa0
 [<c027f4ff>] driver_register+0x2f/0x40
 [<c02c1d36>] mca_register_driver+0x16/0x30
 [<c280fa8e>] el3_init_module+0x9e/0xc1 [3c509]
 [<c0138208>] sys_init_module+0x108/0x240
 [<c010a267>] syscall_call+0x7/0xb

Code: 0f c1 10 85 d2 0f 85 b2 05 00 00 8b 45 f0 85 c0 74 34 8b 47 
 
