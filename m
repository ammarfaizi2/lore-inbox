Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbRFLSpy>; Tue, 12 Jun 2001 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFLSpo>; Tue, 12 Jun 2001 14:45:44 -0400
Received: from puffin.external.hp.com ([192.25.206.4]:51207 "EHLO
	puffin.external.hp.com") by vger.kernel.org with ESMTP
	id <S263020AbRFLSpc>; Tue, 12 Jun 2001 14:45:32 -0400
Date: Tue, 12 Jun 2001 18:44:28 -0600
From: Grant Grundler <grundler@puffin.external.hp.com>
Message-Id: <200106130044.SAA18081@puffin.external.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.4 PCI /proc output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The /proc/bus/pci/devices data looks correct.
/proc/bus/pci/0[01]/* entries look correct.
The /proc/bus/pci/0[23]/* entries don't match "devices" data
and looks wrong.

The host machine is a HP LXR8000 (4x 500Mhz PIII, 2GB RAM, ~8 PCI slots).

Eg for 02/6.0 lspci -v says:
02:06.0 Non-VGA unclassified device: Digital Equipment Corporation DECchip 21154
        Flags: fast devsel
	I/O ports at <ignored> [disabled]
	Memory at <ignored> (type 3, non-prefetchable) [disabled]
	Memory at <ignored> (type 3, non-prefetchable) [disabled]
	Memory at <ignored> (low-1M, non-prefetchable) [disabled]
	Memory at <ignored> (32-bit, prefetchable) [disabled]

(This is a 64-bit PCI-PCI bridge)

od -Ax -x /proc/bus/pci/02/06.0
000000 0000 0000 1000 1000 0000 0000 0040 0000
000010 0000 0000 020b 4011 1000 000b 0157 0210
000020 0007 0100 8008 0080 4001 0000 4004 fe40
000030 0000 0000 0004 fe40 0000 0000 0000 0000
000040 0000 0000 0000 0000 0000 0000 0000 0000
*
000100

/proc/bus/pci/devices for 02/06.0 says:
0230    10110026        0       00000000        00000000        00000000
00000000        00000000        00000000        00000000        00000000
00000000        00000000        00000000        00000000        00000000
00000000

Full output for lspci -t, lspci -v, /proc/bus/pci/0?/*, and devices is
available at ftp://gsyprf10.external.hp.com/pub/244_pci/. If more info
is desired, send me mail.  

I didn't see anything obviously wrong with proc_bus_pci_read() in
drivers/pci/proc.c.  My first guess is the *ppos parameter is fubar
but I'm not able to test this theory.  My excuse is the LXR8000 doesn't
reboot reliably and is 10000km away (I'm in Germany instead of California).
If this isn't already fixed in 2.4.5 (or .6), I'll look at it
in July when I get back. 

grant

Grant Grundler
parisc PCI|IOMMU|SMP hacker
+1 408-447-7253
