Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUDVO76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUDVO76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUDVO75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:59:57 -0400
Received: from fmr01.intel.com ([192.55.52.18]:17633 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264105AbUDVO7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:59:51 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <408773B6.4000306@gmx.de>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4>  <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>  <408773B6.4000306@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1082645897.16337.211.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 10:58:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 03:26, Prakash K. Cheemplavam wrote:
> Len Brown wrote:

> > Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> > is to address the XT-PIC timer issue in IOAPIC mode.
> 
> Ok, I recompiled using your (former) patch and Ross' apic tack patch. I 
> attached the new dmidecode Text.

Actually dmidecode dumps hard-coded BIOS data, so it will not change
unless you upgrade your BIOS.

> > I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> > product names (1st line of dmidecode entry) are correct,
> > these are not from DMI, but are supposed to be human-readable titles.
> 
> Are you referring to (as the first line doesn't say much):
> 
> Product Name: NF7-S/NF7,NF7-V (nVidia-nForce2)
> Version: 2.X,1.0


+       { ignore_timer_override, "Abit NF7-S v2", {

This one is for humans and anything can be in the string.

+                       MATCH(DMI_BOARD_VENDOR,
"http://www.abit.com.tw/"),
+                       MATCH(DMI_BOARD_NAME, "NF7-S/NF7,NF7-V
(nVidia-nForce2)"
),
+                       MATCH(DMI_BIOS_VERSION, "6.00 PG"),
+                       MATCH(DMI_BIOS_DATE, "03/24/2004") }},

These are keys in the DMI table, and have to match the BIOS (as seen in
dmidecode) exactly.

> Seems pretty much OK, though I don't understand, why 1.0 is in the 
> Version string. Durthermore I don't understand, why "Phoenix" appears as 
> bios vendor. It should be Award, AFAIK.

Phoenix and Award merged.
Doesn't really matter what it says, it is just a string compare to
linux.  Also, I chose not to look at the BIOS vendor in this example
b/c it adds no value, here we're just looking at BOARD vendor & name,
plus BIOS version and date.

Thanks for confirming that the entry matched your system and that the
patch triggered automatically.

-Len


