Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422855AbWBNWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422855AbWBNWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWBNWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:08:59 -0500
Received: from [194.90.237.34] ([194.90.237.34]:41386 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1422855AbWBNWI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:08:58 -0500
Date: Wed, 15 Feb 2006 00:10:25 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060214221025.GB14329@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il> <1139940226.18044.3.camel@whizzy> <20060214212145.GC14113@mellanox.co.il> <1139954779.26803.3.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139954779.26803.3.camel@whizzy>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Feb 2006 22:10:52.0125 (UTC) FILETIME=[84A990D0:01C631B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Kristen Accardi <kristen.c.accardi@intel.com>:
> I guess the assumption I made was that if msi is
> turned off for a bridge, then all devices under the bridge may not use
> msi.   

Well, all this is just quirks, so no real rules apply, thats why I thought
having 2 bits gives us maximum flexibility.

Specifically for PCXH I see this in code:
/*
 * It's possible for the MSI to get corrupted if shpc and acpi
 * are used together on certain PXH-based systems.
 * */

So it seems the issue is device-specific - only affects the bridge itself.

What the code currently does is disable msi for bridge itself but not for
the devices behind it. I cant inherit dev->no_msi from parent to child
without changing this, and I just assumed this is by design.

Are you saying this is a bug and should be changed?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
