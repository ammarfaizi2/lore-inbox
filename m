Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267269AbSKPMzN>; Sat, 16 Nov 2002 07:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbSKPMzN>; Sat, 16 Nov 2002 07:55:13 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:18200
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267269AbSKPMzM>; Sat, 16 Nov 2002 07:55:12 -0500
Date: Sat, 16 Nov 2002 08:04:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: ambx1@neo.rr.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>
Subject: 2.5.47 serial/parallel getting registered twice.
Message-ID: <Pine.LNX.4.44.0211160743370.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	having CONFIG_ISAPNP on results in serial being registered twice, 
perhaps the drivers/pnp layer should be cooperating with generic driver 
api? This ends up breaking serial port polling.

Serial: 8250/16550 driver $Revision: 1.1.1.1 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: pnp: match found with the PnP device '00:0c' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'parport_pc' has been registered
pnp: pnp: match found with the PnP device '00:0b' and the driver 
'parport_pc'
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)

without CONFIG_ISAPNP:
Serial: 8250/16550 driver $Revision: 1.1.1.1 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)

-- 
function.linuxpower.ca

