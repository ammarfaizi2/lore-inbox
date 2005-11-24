Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVKXNN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVKXNN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVKXNN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:13:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39298 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbVKXNN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:13:28 -0500
Date: Thu, 24 Nov 2005 14:13:10 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124131310.GE20775@brahms.suse.de>
References: <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132783243.13095.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. The lock behaviour *is* defined for main memory access by all bus
> masters.

For uncached memory, right?

> 2. Uncached mappings are unworkable for this because we must never have
> a page mapped with conflicting cache types - thats ugly, and plain
> horrific on SMP.

For kernel mapping change_page_attr() takes care of it,
and for user space memory following all mappings is the only
reliable way to find out which process needs to be killed
anyways - and when you do that you can as well unmap
or just kill.

> 3. Uncached has undefined semantics when racing a PCI master. Lock has
> defined semantics. An uncached add #0 is permitted to read the memory
> and then write it back as two different cycles and I suspect does.

Consider what happens with such a race: either the PCI master
gets an bus abort because it still sees the corrupted data.
Or it already accesses the repaired data. Both is ok.

> 4. The AMD BIOS guide requires both that LOCK is enabled by default and
> that the "lock affects the external bus" bit is clear to enable locking
> on the external bus.

The "Linux guidelines" might be different.

-Andi
