Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUBCNUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266000AbUBCNUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:20:39 -0500
Received: from fmr04.intel.com ([143.183.121.6]:35032 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265999AbUBCNUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:20:37 -0500
Subject: Re: IRQ 9: nobody cared ;_;
From: Len Brown <len.brown@intel.com>
To: DaMouse Networks <damouse@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040203064920.087d5546@EozVul.WORKGROUP>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A93@hdsmsx402.hd.intel.com>
	 <20040203064920.087d5546@EozVul.WORKGROUP>
Content-Type: text/plain
Organization: 
Message-Id: <1075814415.13728.75.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Feb 2004 08:20:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)

> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect: 
> 09 003 03  0    1    0   1   0    1    1    71

Looks like we're setting up IRQ9 correctly -- level/low -- which is what
default/default is.  Other systems break if dfl/dfl is not interpreted
as level/low.

>  9:     100000          0   IO-APIC-level  acpi

But ACPI (alone on the IRQ) is getting an interrupt storm -- IRQ9 is low
and ACPI doesn't know why.

Please verify that you've got the latest BIOS for this box,
and send along
1. /proc/interrupts and demsg from booting same kernel with "acpi=off"
2. output from dmidecode available in /usr/sbin/, or here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

i'll send a patch later to force IRQ9 to level/high -- for if the ACPI
interrupt works properly with that setting, then we know we've
mis-interpreted what we think should be dfl/dfl on this box.

thanks,
-Len


