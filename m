Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945966AbWKJDBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945966AbWKJDBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 22:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424341AbWKJDBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 22:01:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37067
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1424242AbWKJDBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 22:01:45 -0500
Date: Thu, 09 Nov 2006 19:01:43 -0800 (PST)
Message-Id: <20061109.190143.78711283.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
Subject: Re: DMA APIs gumble grumble
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163127327.4982.79.camel@localhost.localdomain>
References: <1163120524.4982.61.camel@localhost.localdomain>
	<20061109.185026.07639529.davem@davemloft.net>
	<1163127327.4982.79.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 13:55:27 +1100

> > pci_alloc_consistent() is not allowed from atomic contexts.
> 
> Yes, but some drivers did it anyway, though I can't remember under which
> circumstances (IDE probe possibly ? It's a usual culprit for that sort
> of thing). This is why most implementations use GFP_ATOMIC (including
> sparc64 :-)

Ok, I see.

> Oh well, I have no problem with leaving sparc32 do GFP_KERNEL indeed, I
> can't remember for sure the reason why we have most architectures do
> GFP_ATOMIC, but it probably never hit sparc32.

I wish sparc32 hadn't used alloc_resource() as a poor-man's bitmap
allocator to keep track of IOMMU mappings.  That's where the
GFP_KERNEL requirement comes from.

Just use GFP_KERNEL for now, and someone might find the strength
to remove this problem some day :-)
