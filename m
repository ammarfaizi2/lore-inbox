Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUAJEVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 23:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbUAJEVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 23:21:11 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:49141 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264583AbUAJEVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 23:21:08 -0500
Date: Fri, 9 Jan 2004 23:21:08 -0500
To: linux-kernel@vger.kernel.org
Subject: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
Message-ID: <20040110042108.GB313@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: "Eric C. Cooper" <ecc@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried a 2.6.1 kernel with CONFIG_PCI_USE_VECTOR, my onboard
Ethernet (sis900) produced nothing but watchdog timeouts.  It worked
fine with the old IRQ routing.

When I looked in /var/log/syslog, I noticed that the Ethernet driver
was using a different IRQ, so I suspected the vector routing.  I found
the following suspicious entries:

Jan  9 20:09:08 jaguar kernel: PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
Jan  9 20:09:08 jaguar kernel: PCI: Using configuration type 1
Jan  9 20:09:08 jaguar kernel: mtrr: v2.0 (20020519)
Jan  9 20:09:08 jaguar kernel: ACPI: Subsystem revision 20031002
Jan  9 20:09:08 jaguar kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> 0xa9 -> IRQ 20 Mode:1 Active:1)
Jan  9 20:09:08 jaguar kernel: ACPI: SCI (IRQ20) allocation failed
Jan  9 20:09:08 jaguar kernel:     ACPI-0133: *** Error: Unable to install System Control Interrupt Handler, AE_NOT_ACQUIRED
Jan  9 20:09:08 jaguar kernel: ACPI: Unable to start the ACPI Interpreter
Jan  9 20:09:08 jaguar kernel: Trying to free free IRQ20
Jan  9 20:09:08 jaguar kernel: ACPI: ACPI tables contain no PCI IRQ routing entries
Jan  9 20:09:08 jaguar kernel: PCI: Invalid ACPI-PCI IRQ routing table
Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware
Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware (bus 00)
Jan  9 20:09:08 jaguar kernel: Enabling SiS 96x SMBus.
Jan  9 20:09:08 jaguar kernel: PCI: Using IRQ router default [1039/0963] at 0000:00:02.0
Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
Jan  9 20:09:08 jaguar last message repeated 9 times
Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 1!
Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!


If anyone needs more information (kernel configs, syslog from the
non-USE_VECTOR kernel, etc) or if I can help in any way by trying
something out, please let me know.

-- 
Eric C. Cooper          e c c @ c m u . e d u
