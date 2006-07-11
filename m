Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWGKH3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWGKH3i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWGKH3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:29:38 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:64418 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S965237AbWGKH3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:29:37 -0400
In-Reply-To: <m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com> <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com> <1152571162.1576.122.camel@localhost.localdomain> <m14pxolryw.fsf@ebiederm.dsl.xmission.com> <1152595205.6346.26.camel@localhost.localdomain> <m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
Date: Tue, 11 Jul 2006 09:29:29 +0200
To: ebiederm@xmission.com (Eric W. Biederman)
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for supporting multiple irqs in plain MSI mode, I don't think
> we want to do that.  The problem is that multiple interrupts
> in msi mode cannot be individually routed.

On some(/many/most) platforms that isn't a problem.  Platforms
for which it is can just refuse to allocate more than one MSI
at once.

> I think we really want
> to encourage vendors who are building cards with multiple MSI irqs
> to use MSI-X.  MSI-X has a lot fewer ugly special cases and all
> architectures can individually route the irqs.

We still should support whatever hardware already exists, if
possible.

> If there are interesting cards that support just MSI mode and really
> need more than one irq I would be happy to reconsider that decision
> but my impression was that plain MSI was basically not quite flexible
> enough to really be interesting, and supporting just one MSI irq was
> ok but any more would lead to all kinds of strange special cases.

Individual drivers can deal with those special cases if they are device-
specific; and the platform can just refuse to do more than one MSI if
something platform-specific would prevent correct operation.

It would be nice to have the MSI and MSI-X interfaces have the same
calling convention; in fact, they can probably be folded into one.


Segher

