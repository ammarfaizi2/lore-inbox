Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbRAPQ6K>; Tue, 16 Jan 2001 11:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132206AbRAPQ6A>; Tue, 16 Jan 2001 11:58:00 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:56069 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131745AbRAPQ5q>;
	Tue, 16 Jan 2001 11:57:46 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chad Miller <cmiller@surfsouth.com>
Date: Tue, 16 Jan 2001 17:56:34 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb on 2.4.0 / PCI: Failed to allocate...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <12C0E7CE41C0@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 01 at 19:22, Chad Miller wrote:

> I worry about some PCI initialization output (from dmesg):
> 
> # PCI: Probing PCI hardware
> # Unknown bridge resource 0: assuming transparent
> # PCI: Using IRQ router VIA [1106/0686] at 00:07.0
> # PCI: Cannot allocate resource region 0 of device 01:00.0
> # PCI: Failed to allocate resource 0 for Matrox Graphics, Inc. MGA G400 AGP
> [...]
> 
> That `device 01:00.0' is obviously the AGP MGA.  'dmesg' continues later
> with...
> 
> # matroxfb: Matrox Millennium G400 MAX (AGP) detected
> # i2c-core.o: i2c core module
> # i2c-algo-bit.o: i2c bit algorithm module
> # i2c-core.o: driver maven registered.  [...]

What does 'lspci -v' say?

Are you sure that you do not have 'matroxfb: control registers are not
available, matroxfb disabled', or 'matroxfb: video RAM is not available
in PCI address space, matroxfb disabled' messages?

Also, when request_mem_region(ctrl, 16K, "matroxfb MMIO") or
request_mem_region(videoram, 32M, "matroxfb FB") fails (f.e. when
both regions are uninitialized they overlaps, so second request_mem_region
fails), there is a bug that no error message is printed
in such case, as matroxfb assumes that if request_mem_region failed,
it was because of some other driver already controls this hardware.

You should make sure that (1) you have only one VGA in machine and
(2) your BIOS is not buggy. Changing any of these two conditions should
enable matroxfb to run (G400 is not very well supported as second head;
you can experiment with 'memtype' matroxfb option, but...)
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
