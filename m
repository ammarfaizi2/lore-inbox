Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTFWWBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTFWWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:01:50 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:35855 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S265362AbTFWWBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:01:37 -0400
Date: Tue, 24 Jun 2003 00:15:41 +0200
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030623221541.GA8096@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

long time ago I noticed a problem with the ACPI IRQ not working
if it is _not_ shared with some other PCI IRQ.  The problem still
exists in the 2.4.21 kernel, confirmed on two machines with the
MSI MS-6368L motherboard (VIA PLE133 chipset).

I need ACPI for just one thing: to run "shutdown -h now" after the
power button is pressed.  (The box is a server which usually has
no keyboard connected.)

As I can see in /proc/interrupts, the BIOS usually allocates IRQ9
for ACPI (not shared with anything else), and the IRQ9 counter is
always zero.  Pressing the power button has no effect at all.

There is an easy workaround: in BIOS setup, set IRQ9 to "Legacy ISA"
instead of "PCI/ISA PnP" so that ACPI gets some other IRQ, shared
with some other PCI devices (in my case, IRQ11 is shared by: acpi,
usb-uhci, usb-uhci, eth0).  Then the power button works fine.

Is this a known problem?  Should I complain to MSI (BIOS fix),
or is this a Linux bug?  Any patches I should try?  This looks
a bit unusual to me - one would expect problems if an IRQ _is_
shared, and some broken hardware/driver doesn't like sharing...

If there is no known fix, perhaps the "Legacy ISA" workaround
(which I discovered by accident) should be documented somewhere?

Thanks,
Marek

