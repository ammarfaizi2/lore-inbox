Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTIEL7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTIEL7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:59:14 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:55525 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261217AbTIEL7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:59:06 -0400
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1450)
From: Sven Dowideit <svenud@ozemail.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Tom Marshall <tommy@home.tig-grr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030827135940.A31850@flint.arm.linux.org.uk>
References: <200308270056.33190.daniel.ritz@gmx.ch>
	 <20030827135940.A31850@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1062798822.631.11.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 07:53:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 22:59, Russell King wrote:
> I've just created http://pcmcia.arm.linux.org.uk/ to document the
> currently known problems and to contain patches for them.
> 
ok, I've built and booted linux 2.5.70 to 2.5.75, and it seems that the
detecting the aironet card as a memory_cs device happens in 2.5.74

_but_ I did come across a number of other weirdnesses on the way.
1. 2.5.71 was missing a #include <linux/cpu.h> in flow.c
2. when i patched 2.5.70 to 2.5.71 and then 2.5.72 somehow SMP became
enabled, and this stopped pcmcia from working at all
3. my /etc/defaults/pcmcia contained the line PCIC-i82365, which seemed
not tp cause 2.5.70 any problems, but after that i had to change that to
yenta before pcmicia started successfully

I assume the next step is to apply the 2.5.74 patch in pieces ?

cheers
Sven

-----------------
from dmesg 2.5.73

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 9 for device 00:02.0
PCI: Sharing IRQ 9 with 00:05.0
PCI: Sharing IRQ 9 with 01:00.0
Yenta IRQ list 00b8, PCI irq9
Socket status: 30000006
PCI: Found IRQ 9 for device 00:02.1
Yenta IRQ list 00b8, PCI irq9
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
bad: scheduling while atomic!
Call Trace:
 [<c0117666>] schedule+0x3b6/0x3c0
 [<e0852bea>] sendcommand+0xaa/0xe0 [airo]
 [<e0852b0c>] issuecommand+0x5c/0x90 [airo]
 [<e08530ca>] PC4500_accessrid+0x4a/0x90 [airo]
 [<e0853177>] PC4500_readrid+0x67/0x120 [airo]
 [<c0175118>] padzero+0x28/0x30

-----------------
dmesg from 2.5.74

Yenta IRQ list 0000, PCI irq9
Socket status: 30000006
PCI: Found IRQ 9 for device 0000:00:02.1
ti113x: Routing card interrupts to PCI
Yenta IRQ list 0000, PCI irq9
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.


----------------
the differences between the 2 .config files

root@sven:/usr/src/2.5# diff linux-2.5.73/.config linux-2.5.74/.config
174d173
< CONFIG_BINFMT_AOUT=m
175a175
> CONFIG_BINFMT_AOUT=m
178a179,183
> # Generic Driver Options
> #
> # CONFIG_FW_LOADER is not set
> 
> #
350d354
< # CONFIG_SCSI_NCR53C7xx is not set
352d355
< # CONFIG_SCSI_NCR53C8XX is not set
711d713
< # CONFIG_MOUSE_PS2_SYNAPTICS is not set
747a750
> # CONFIG_I2C_PROSAVAGE is not set
758a762
> # CONFIG_I2C_ALI1535 is not set
774a779
> # CONFIG_SENSORS_LM78 is not set
1266a1272
> # CONFIG_USB_AX8817X is not set




