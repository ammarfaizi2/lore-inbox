Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUKPH45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUKPH45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUKPH45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:56:57 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:60387
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S261931AbUKPH4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:56:20 -0500
Date: Tue, 16 Nov 2004 08:55:48 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@pol.net>
Subject: Re: Linux 2.6.10-rc2 SAVAGEFB startup crash
Message-ID: <20041116075548.GB4014@titan.lahn.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Antonino Daplas <adaplas@pol.net>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

2.6.10-rc2 on Debian i586 crashed during startup.

On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> Summary of changes from v2.6.10-rc1 to v2.6.10-rc2
> ============================================
> Antonino Daplas:
...
>   o fbdev: S3 Savage Framebuffer Driver

Copied by hand:

show_stack+0x7f/0xa0
show_registers+0x156/0x1c0
die+0xc8/0x150
do_page_fault+0x326/0x6a2
error_code+0x2b/0x30
savagefb_create_i2c_busses+0x44/0xf0
savagefb_probe+0xe2/0x460
pci_device_probe_static+0x4d/0x60
__pci_device_probe+0x3c/0x50
pci_device_probe+0x2x/0x50
driver_probe_device+0x2e/0x80
driver_attach+0x5c/0xa0
bus_add_driver+0x95/0xd0
driver_register+0x31/0x40
pci_register_driver+0x64/0x80
savagefb_init+0x39/0x41
do_initcalls+0x2b/0xc0
init+0x28/0x110
kernel_thread_helper+0x5/0x10

(gdb) disassemble savagefb_create_i2c_busses
Dump of assembler code for function savagefb_create_i2c_busses:
0x02b0 <savagefb_create_i2c_busses+0>:  push %ebp
0x02b1 <savagefb_create_i2c_busses+1>:  mov  %esp,%ebp
0x02b3 <savagefb_create_i2c_busses+3>:  sub  $0x8,%esp
0x02b6 <savagefb_create_i2c_busses+6>:  mov  0x8(%ebp),%eax
0x02b9 <savagefb_create_i2c_busses+9>:  mov  0x234(%eax),%edx
0x02bf <savagefb_create_i2c_busses+15>: mov  %edx,0x8(%edx)
0x02c2 <savagefb_create_i2c_busses+18>: mov  0xe0(%eax),%eax
0x02c8 <savagefb_create_i2c_busses+24>: cmp  $0x88,%eax
0x02cd <savagefb_create_i2c_busses+29>: je   0x350 <savagefb_create_i2c_busses+160>
0x02d3 <savagefb_create_i2c_busses+35>: ja   0x340 <savagefb_create_i2c_busses+144>
0x02d5 <savagefb_create_i2c_busses+37>: add  $0xffffff80,%eax
0x02d8 <savagefb_create_i2c_busses+40>: je   0x2f8 <savagefb_create_i2c_busses+72>
0x02da <savagefb_create_i2c_busses+42>: lea  0x0(%esi),%esi
0x02e0 <savagefb_create_i2c_busses+48>: mov  $0x1,%eax
0x02e5 <savagefb_create_i2c_busses+53>: mov  %eax,0x4(%esp)
0x02e9 <savagefb_create_i2c_busses+57>: lea  0x8(%edx),%eax
0x02ec <savagefb_create_i2c_busses+60>: mov  %eax,(%esp)
0x02ef <savagefb_create_i2c_busses+63>: call 0x1c0 <savage_setup_i2c_bus>
0x02f4 <savagefb_create_i2c_busses+68>: mov  %ebp,%esp
0x02f6 <savagefb_create_i2c_busses+70>: pop  %ebp
0x02f7 <savagefb_create_i2c_busses+71>: ret

$ grep 'SAVAGE\|I2C' /boot/config-2.6.10-rc2
# I2C support
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m
# I2C Algorithms
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
# I2C Hardware Bus support
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_ELEKTOR=m
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_SENSOR=m
# Other I2C Chip support
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y

BYtE
Philipp
-- 
/ /  (_)__  __ ____  __ Philipp Hahn
/ /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
