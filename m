Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWDZOAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWDZOAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWDZOAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:00:51 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:64772 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932454AbWDZOAu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:00:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 09:00:45 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0B98@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-Index: AcZpMSEVs1tnMAkRRMKEWo8DYGUTlwACHdnA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <sergio@sergiomb.no-ip.org>, "Brown, Len" <len.brown@intel.com>
Cc: "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <ak@suse.de>,
       <kmurray@redhat.com>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 26 Apr 2006 14:00:46.0544 (UTC) FILETIME=[D0E63D00:01C66939]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think, it is about time, not thinking via quirks as 
> workarounds, because all pcis (on via) are quirked, some are 
> quirked twice.
> And we should think in programmer interrupts of via chipset, 
> in specific function for this propose, for me, doesn't make 
> sense every time VIA put other ID out, we have to add quirks 
> to this ID , as this was an exception. 
> 
> Thanks, 

VIA's numerous pci quirks are not related to this patch. They only hit
one problem with it having only 4 bits encoding their interrupt.
 
> On Tue, 2006-04-25 at 15:53 -0400, Brown, Len wrote:
> > I'd rather see the original irq-renaming patch and its subsequent 
> > multiple via workaround patches reverted than to further complicate 
> > what is becoming a fragile mess.
> > 
> > -Len

There are probably better ways to control 224 possible IRQs by their
total number instead of their range, and per-cpu IDTs are the better
answer to the IRQ shortage altogether. But just going back to the way it
was wouldn't be right I think. We were able to run 2 generations of
systems only because we had this compression, other big systems
benefited from it as well.
Thanks,
--Natalie
