Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWKONea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWKONea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966860AbWKONea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:34:30 -0500
Received: from khc.piap.pl ([195.187.100.11]:64183 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S966859AbWKONe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:34:29 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
	<455A938A.4060002@garzik.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 15 Nov 2006 14:34:25 +0100
In-Reply-To: <455A938A.4060002@garzik.org> (Jeff Garzik's message of "Tue, 14 Nov 2006 23:11:54 -0500")
Message-ID: <m3fyckdeam.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> So far, MSI history on x86 has always followed these rules:
> * it works on Intel
> * it doesn't work [well | at all] on AMD/NV

I don't know how does it look when it doesn't work etc. but certainly
both NV Ethernet and HDA seem to work for me and:

$ cat /proc/interrupts 
           CPU0       
  0:     596146   IO-APIC-edge      timer
  1:      15425   IO-APIC-edge      i8042
  8:     103741   IO-APIC-edge      rtc
  9:          0   IO-APIC-fasteoi   acpi
 12:      25168   IO-APIC-edge      i8042
 14:         61   IO-APIC-edge      libata
 15:          0   IO-APIC-edge      libata
 20:          2   IO-APIC-fasteoi   ehci_hcd:usb1
 21:          0   IO-APIC-fasteoi   libata
 22:       4881   IO-APIC-fasteoi   libata
 23:      17010   IO-APIC-fasteoi   libata, ohci_hcd:usb2
279:     598326   PCI-MSI-edge      eth0
280:      21497   PCI-MSI-edge      eth0
281:      20448   PCI-MSI-edge      eth0
282:       4881   PCI-MSI-edge      HDA Intel
NMI:         70 
LOC:     596126 
ERR:          0

$ /sbin/lspci|grep nV 
00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a1)
00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a2)
00:01.2 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a2)
00:06.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)
00:06.1 Audio device: nVidia Corporation MCP55 High Definition Audio (rev a2)
00:08.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:09.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a2)
00:0b.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0c.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)
00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a2)

> Anyway, if you want your master switch, put it there, not in each driver...

Definitely.
-- 
Krzysztof Halasa
