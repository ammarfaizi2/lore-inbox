Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDALww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUDALww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:52:52 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:3745 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262874AbUDALwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:52:50 -0500
Date: Thu, 1 Apr 2004 13:52:48 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
Subject: Re: ACPI SCI IOAPIC bug (Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered)
In-Reply-To: <1080771580.31359.32.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0404011331550.3675@jurand.ds.pg.gda.pl>
References: <A6974D8E5F98D511BB910002A50A6647615F0C10@hdsmsx402.hd.intel.com>
 <1080771580.31359.32.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2004, Len Brown wrote:

> Why is it that all IRQs get their name from the
> IOAPIC pin number, but the timer connected to
> pin 2 is called IRQ0 instead of IRQ2?

 ISA interrupts get their numbers from 8259A IRQ numbers they would be
routed to in the PIC mode.  This lets the code operate in the mixed mode
sanely (which happens for certain hardware), although it's not necessarily
the reason for the numbering used.  Note that the MP Specification does
not mandate an identity map of ISA interrupts, although it seems to be
what vendors do.

 Also note that depending on the configuration, the timer can effectively
be routed to INTIN2 or INTIN0 by Linux -- one of the alternatives being a
direct connection and the other one being done through the 8259A
configured to be transparent for its IRQ 0.

> I wonder if we should't be moving to at least a build option which
> deletes support for multiple pins at an IRQ, and deletes
> suport for non-identity pin->IRQ mapping.

 This can't be done for the timer due to configuration variations.

> While the ACPI table parsing is very early, the _PRT parsing
> can happen only after the ACPI interpreter is up, because
> the _PRT's are encoded in AML.

 Hmm, that's unfortunate.  Couldn't the interpreter be started earlier?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
