Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUDMDVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 23:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUDMDVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 23:21:18 -0400
Received: from fmr02.intel.com ([192.55.52.25]:20674 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263147AbUDMDVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 23:21:16 -0400
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
From: Len Brown <len.brown@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F888E@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F888E@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1081826374.2258.597.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Apr 2004 23:19:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natalie,

> ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 13 high edge)

I agree with your description of why the 15->13 override fails.

> ACPI: INT_SRC_OVR (bus 0 bus_irq 4 global_irq 14 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 15 high edge)

These two also create an actual and potential duplicate mp_irqs[] entry.

> ACPI: INT_SRC_OVR (bus 0 bus_irq 6 global_irq 16 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 7 global_irq 17 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 18 low edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 12 global_irq 19 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 20 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 23 high level)

The ES7000 sure is a great tester of the over-ride code!

But I don't like the proposal to selectively invalidate
existing mp_irqs[] entries.

I think the proper fix is to parse the over-ride entries before
filling in the (remaining) identity mappings.  This also gets
rid of the special case for IRQ2, which would be handled exactly
like the mappings to < 16 on the ES7000 above.

Perhaps I should send you a patch you can test on the ES7000,
since I don't have one of those?

In any case, I'd prefer that proposed patches to this code come
through me, since it is ACPI specific.

thanks,
-Len


