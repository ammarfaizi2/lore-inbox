Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbTDFOkt (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTDFOkt (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:40:49 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:54858 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S262988AbTDFOkp (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 10:40:45 -0400
Date: Sun, 6 Apr 2003 16:52:17 +0200 (CEST)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [sparc64] 2.4.21-pre7 and alsa: unresolved symbol
Message-ID: <Pine.LNX.4.53.0304061640140.7051@mazinga.int.fabbione.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	Im a bit new to sparc kernel/hardware and I have been hitten by a
problem compiling alsa modules.
In a few words loading the modules i get the following error:

mazinga:/usr/src/modules/alsa-driver# insmod snd-page-alloc
Using /lib/modules/2.4.21-pre7/kernel/sound/acore/snd-page-alloc.o
/lib/modules/2.4.21-pre7/kernel/sound/acore/snd-page-alloc.o: unresolved
symbol virt_to_bus_not_defined_use_pci_map

poking around I found that io.h has this entry on sparc64:

extern unsigned long virt_to_bus_not_defined_use_pci_map(volatile void  *addr);
#define virt_to_bus virt_to_bus_not_defined_use_pci_map

while in other archs there is some "real" code.

I understand "use_pci_map" but what i would really like to know is:

* why is virt_to_bus missing from sparc64?
* which is the best way to fix the code? kernel or alsa???

I have also been trying to look at 2.5.66 kernel but unfortunatly I cannot
even boot it to confirm that is working or not (atleast to try a backport
or something)

Any help would be really appreciated.

Thanks
Fabio
