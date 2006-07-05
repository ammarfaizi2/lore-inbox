Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWGEGrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWGEGrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWGEGrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:47:42 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21397 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750999AbWGEGrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:47:42 -0400
Message-ID: <44AB608F.1060903@drzeus.cx>
Date: Wed, 05 Jul 2006 08:47:43 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>
Subject: ACPIPNP and too large IO resources
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

Commit 1acfb7f2b0d460ee86bdb25ad0679070ec8a5f0d by Bjorn is causing me
some grief. Although the patch seems correct, it is triggering another
misfeature of the system and I am hoping you have a solution.

Before your patch, the PCI bridge didn't allocate many io ports as they
were mislabeled as iomem. But now it puts its dirty paws all over the
entire ISA io port address space, effectively disabling PNP.

On my machine it steals the ranges 0x0-0xcf7, 0xcf8-0xcff and
0xd00-0xffff. IOW, the entire range of 0x0-0xffff gets blocked and none
of the ISA PNP devices can use ports outside this range.

We can see the same effect in the example given in your commit where
only the range 0x3b0-0x3df is left open.

I don't know enough about PNP to determine the problem, but I guess it's
the section that checks overlaps with other PNP devices that is somehow
wrong. It could also be that everyone keeps coding their DSDTs wrong,
but if that's the case then I see little other choice than to be bug
compatible.

Rgds
Pierre
