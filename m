Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUHDC40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUHDC40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUHDC40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:56:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:28306 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265212AbUHDC4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:56:20 -0400
Subject: RE: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
From: Len Brown <len.brown@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Nathan Bryant <nbryant@optonline.net>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stefan D?singer <stefandoesinger@gmx.at>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F037BB9C6@pdsmsx401.ccr.corp.intel.com>
References: <B44D37711ED29844BEA67908EAF36F037BB9C6@pdsmsx401.ccr.corp.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1091588154.2297.43.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Aug 2004 22:55:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua,
pci=noacpi and acpi=noirq are boot workarounds --
not full-featured supported configurations -- YMMV!
We don't even guarantee that the ACPI SCI
will work with these configurations.
So I think we should spend 0 effort to support ACPI suspend/resume
in configurations where ACPI is partially disabled.

Sorry if this contradicts what I said yesterday,
I think I wasn't thinking clearly then.

thanks,
-Len


On Tue, 2004-08-03 at 22:36, Li, Shaohua wrote:
> Nathan,
> I agree your patch should be ok for the special case, but it's not
> sufficient. Please note a Link device is just an abstraction of PCI
> router, which possibly is in ICH. If we use pci=noacpi or acpi=noirq, we
> don't use link device but still use the router and may also change the
> sets of the router (look at i386/pci/irq.c) and so still fail after S3.
> Your patch can't handle this situation. This indicates adding
> suspend/resume code in pci_link.c is not a good idea. Generic solution
> should be to provide LPC driver.
> 
> Thanks,
> Shaohua
> 
> >-----Original Message-----
> >From: Nathan Bryant [mailto:nbryant@optonline.net]
> >Sent: Wednesday, August 04, 2004 9:43 AM
> >To: Brown, Len
> >Cc: acpi-devel@lists.sourceforge.net; Linux Kernel list; Li, Shaohua;
> >Stefan D?singer
> >Subject: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
> >
> >
> >This patch should fix multiple user-visible problems with the ACPI IRQ
> >routing after S3 resume:
> >
> >"irq x: nobody cared"
> >"my interrupts are gone"
> >
> >It probably applies to multiple bugzilla entries and mailing list
> posts.
> >
> >Tested on my machine, which is experiencing similar problems. Seems to
> >work - although I get some non-fatal "nobody cared" messages that might
> >be caused by the i8042 driver.
> >
> >Comments?
> >Stefan, can you test this?

