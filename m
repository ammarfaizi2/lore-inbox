Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274039AbRISLzw>; Wed, 19 Sep 2001 07:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274040AbRISLzn>; Wed, 19 Sep 2001 07:55:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:25078 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S274039AbRISLz1>; Wed, 19 Sep 2001 07:55:27 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: Andy Grover <agrover@groveronline.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Direct PCI access broken in 2.4.10-pre
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Sep 2001 12:55:19 +0100
Message-ID: <30185.1000900519@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.10-pre3 and later fail to boot on my Compaq XL box. It claims that PCI 
isn't supported. This board doesn't use the PCI BIOS because the entry 
point is in high memory.

'cvs up -r v2_4_10-pre2 arch/i386/boot/pci-pc.c' fixes it.

A happy boot with the old pci-pc.c:
PCI: BIOS32 entry (0xc00fa000) in high memory, cannot use.
PCI: Using configuration type 2
PCI: Probing PCI hardware

An unhappy boot with the new one:
PCI: BIOS32 entry (0xc00fa000) in high memory, cannot use.
PCI: System does not support PCI

An unhappy boot with the new one and 'pci=conf2':
PCI: Using configuration type 2
PCI: Probing PCI hardware
PCI: device 00:01.0 has unknown header type 7f, ignoring.
PCI: device 00:02.0 has unknown header type 7f, ignoring.
PCI: device 00:03.0 has unknown header type 7f, ignoring.
PCI: device 00:04.0 has unknown header type 7f, ignoring.
PCI: device 00:05.0 has unknown header type 7f, ignoring.
PCI: device 00:06.0 has unknown header type 7f, ignoring.
PCI: device 00:07.0 has unknown header type 7f, ignoring.
PCI: device 00:08.0 has unknown header type 7f, ignoring.
PCI: device 00:09.0 has unknown header type 7f, ignoring.
PCI: device 00:0a.0 has unknown header type 7f, ignoring.
PCI: device 00:0e.2 has unknown header type 7f, ignoring.
PCI: device 00:0e.3 has unknown header type 7f, ignoring.
PCI: device 00:0e.4 has unknown header type 7f, ignoring.
PCI: device 00:0e.5 has unknown header type 7f, ignoring.
PCI: device 00:0e.6 has unknown header type 7f, ignoring.
PCI: device 00:0e.7 has unknown header type 7f, ignoring.
PCI: Cannot allocate resource region 0 of device 00:0e.0
PCI: Cannot allocate resource region 1 of device 00:0e.1
PCI: Cannot allocate resource region 2 of device 00:0e.1
PCI: Cannot allocate resource region 3 of device 00:0e.1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
 <deadlock>

--
dwmw2


