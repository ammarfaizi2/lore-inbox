Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUCYE1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 23:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbUCYE1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 23:27:22 -0500
Received: from fmr10.intel.com ([192.55.52.30]:49794 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263146AbUCYE1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 23:27:20 -0500
Subject: Re: ACPI problem with latest 2.6 snapshot
From: Len Brown <len.brown@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1080136312.2309.9.camel@pegasus>
References: <1080136312.2309.9.camel@pegasus>
Content-Type: text/plain
Organization: 
Message-Id: <1080187915.21259.354.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Mar 2004 23:11:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting this failure Marcel.
I expect we'll have this problem in 2.4.26 too.

On Wed, 2004-03-24 at 08:51, Marcel Holtmann wrote:
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)

rats, I don't have a non-identity SCI over-ride like this to test on.

> ACPI: Subsystem revision 20040311
> ACPI: SCI (IRQ22) allocation failed
>     ACPI-0133: *** Error: Unable to install System Control Interrupt Handler, AE_NOT_ACQUIRED
> ACPI: Unable to start the ACPI Interpreter

apparently setting up IRQ22 on the IOAPIC early made it unavailable for
subsequent request_irq().

> ACPI: ACPI tables contain no PCI IRQ routing entries
> PCI: Invalid ACPI-PCI IRQ routing table
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Enabled i801 SMBus device
> Transparent bridge - 0000:00:1e.0
> PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
> PCI BIOS passed nonexistent PCI bus 0!
> PCI BIOS passed nonexistent PCI bus 0!

Marcel,
I've dropped this info into a new bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=2366

can you add yourself to the cc:, and attach the complete dmesg -s40000
from the failure (or a "debug" console capture).  Would like to confirm
that IRQ22 got set up correctly in the IOAPIC.

There are two bugs here,
1. AE_NOT_ACQUIRED on non-identity mapped SCI over-ride -- new
2. boot failure on AE_NOT_ACQUIRED -- old

thanks,
-Len


