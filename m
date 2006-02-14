Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422859AbWBNWsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWBNWsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWBNWsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:48:24 -0500
Received: from fmr17.intel.com ([134.134.136.16]:18100 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422859AbWBNWsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:48:24 -0500
Subject: Re: AMD 8131 and MSI quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060214221025.GB14329@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com>
	 <20060214165222.GC12974@mellanox.co.il> <1139940226.18044.3.camel@whizzy>
	 <20060214212145.GC14113@mellanox.co.il> <1139954779.26803.3.camel@whizzy>
	 <20060214221025.GB14329@mellanox.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 14:52:54 -0800
Message-Id: <1139957574.26803.7.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Feb 2006 22:48:10.0990 (UTC) FILETIME=[BB2140E0:01C631B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 00:10 +0200, Michael S. Tsirkin wrote:
> Quoting r. Kristen Accardi <kristen.c.accardi@intel.com>:
> > I guess the assumption I made was that if msi is
> > turned off for a bridge, then all devices under the bridge may not use
> > msi.   
> 
> Well, all this is just quirks, so no real rules apply, thats why I thought
> having 2 bits gives us maximum flexibility.
> 
> Specifically for PCXH I see this in code:
> /*
>  * It's possible for the MSI to get corrupted if shpc and acpi
>  * are used together on certain PXH-based systems.
>  * */
> 
> So it seems the issue is device-specific - only affects the bridge itself.
> 
> What the code currently does is disable msi for bridge itself but not for
> the devices behind it. I cant inherit dev->no_msi from parent to child
> without changing this, and I just assumed this is by design.
> 
> Are you saying this is a bug and should be changed?
> 

Ok, I went back and read the errata that this patch was attempting to
solve, and you are right, it would not be correct to have children
inherit the no_msi flag from the parent in this case.  I can clearly see
why we need to have a flag associated with the bus rather than the
device for your case.

Kristen


