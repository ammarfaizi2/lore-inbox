Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUA2PFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 10:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUA2PFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 10:05:18 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:32487 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S266163AbUA2PFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 10:05:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16409.7239.119612.861354@gargle.gargle.HOWL>
Date: Thu, 29 Jan 2004 09:44:23 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Eric <eric@cisu.net>
Cc: Andrew Morton <akpm@osdl.org>, stoffel@lucent.com, ak@muc.de,
       Valdis.Kletnieks@vt.edu, bunk@fs.tum.de, cova@ferrara.linux.it,
       linux-kernel@vger.kernel.org
Subject: 2.6.2-rc2-mm1 now boots, 2.6.2-rc? doesn't
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Thank you for your -mm1 patch to 2.6.2-rc2, I've now got my system up
and running again.  I'm not sure where the problem was, since I didn't
find the problem point after sprinkling a bunch of AAA(); debugging
printks() all over the stuff in arch/i386/kernel/setup.c and some
other files in there as well.  

Would it make sense for me to try and work backwards from the -mm1 and
see which patch(es) makes the difference?  

One thing I notice is that now my interrupts are all on just one
processor:

   > cat /proc/interrupts            CPU0       CPU1       
     0:   59000197         20    IO-APIC-edge  timer
     1:       1867          1    IO-APIC-edge  i8042
     2:          0          0          XT-PIC  cascade
     8:          3          1    IO-APIC-edge  rtc
    11:          1          0    IO-APIC-edge  Cyclom-Y
    12:        703          1    IO-APIC-edge  i8042
    14:        281          0    IO-APIC-edge  ide0
    16:      42762          3   IO-APIC-level  ide2, ide3, ohci_hcd
    17:     183325          1   IO-APIC-level  ehci_hcd, eth0
    18:     119211          1   IO-APIC-level  aic7xxx, aic7xxx, Ensoniq AudioPCI
    19:          0          0   IO-APIC-level  ohci_hcd
   NMI:          0          0 
   LOC:   58999640   58999802 
   ERR:          0
   MIS:         26

Should I think about using that daemon to move interrupts around?
Gotta go find the pointer to that stuff again.

Thanks again Andrew!

John
