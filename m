Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCYOTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCYOTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVCYOTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:19:19 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:6297 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261626AbVCYOTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:19:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Li, Shaohua" <shaohua.li@intel.com>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Fri, 25 Mar 2005 15:19:22 +0100
User-Agent: KMail/1.7.1
References: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503251519.22680.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 25 of March 2005 13:54, you wrote:
]--snip--[
> >My box is still hanged solid on resume (swsusp) by the drivers:
> >
> >ohci_hcd
> >ehci_hcd
> >yenta_socket
> >
> >possibly others, too.  To avoid this, I had to revert the following
> patch from the Len's tree:
> >
> >diff -Naru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> >--- a/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
> >+++ b/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
> >@@ -72,10 +72,12 @@
> > 	u8			active;			/* Current IRQ
> */
> > 	u8			edge_level;		/* All IRQs */
> > 	u8			active_high_low;	/* All IRQs */
> >-	u8			initialized;
> > 	u8			resource_type;
> > 	u8			possible_count;
> > 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
> >+	u8			initialized:1;
> >+	u8			suspend_resume:1;
> >+	u8			reserved:6;
> > };
> >
> > struct acpi_pci_link {
> >@@ -530,6 +532,10 @@
> >
> > 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
> >
> >+	if (link->irq.suspend_resume) {
> >+		acpi_pci_link_set(link, link->irq.active);
> >+		link->irq.suspend_resume = 0;
> >+	}
> > 	if (link->irq.initialized)
> > 		return_VALUE(0);
> 
> How about just remove below line:
> >+		acpi_pci_link_set(link, link->irq.active);

You mean apply the patch again and remove just the single
line?  No effect (ie hangs).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
