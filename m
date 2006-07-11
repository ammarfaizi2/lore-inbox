Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWGKHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWGKHtX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWGKHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:49:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23190 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750704AbWGKHtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:49:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<1152571162.1576.122.camel@localhost.localdomain>
	<m14pxolryw.fsf@ebiederm.dsl.xmission.com>
	<1152595205.6346.26.camel@localhost.localdomain>
	<m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
	<9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
Date: Tue, 11 Jul 2006 01:48:33 -0600
In-Reply-To: <9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
	(Segher Boessenkool's message of "Tue, 11 Jul 2006 09:29:29 +0200")
Message-ID: <m18xn0h99q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:

>> As for supporting multiple irqs in plain MSI mode, I don't think
>> we want to do that.  The problem is that multiple interrupts
>> in msi mode cannot be individually routed.
>
> On some(/many/most) platforms that isn't a problem.  Platforms
> for which it is can just refuse to allocate more than one MSI
> at once.

It is a problem on all platforms that currently implement MSI.

>> I think we really want
>> to encourage vendors who are building cards with multiple MSI irqs
>> to use MSI-X.  MSI-X has a lot fewer ugly special cases and all
>> architectures can individually route the irqs.
>
> We still should support whatever hardware already exists, if
> possible.

Which hardware is this a problem for?

MSI and MSI-X only guarantee the availability of 1 irq if I recall
correctly.  More are a bonus so cards should be able to fall back
to a single irq mode.

>> If there are interesting cards that support just MSI mode and really
>> need more than one irq I would be happy to reconsider that decision
>> but my impression was that plain MSI was basically not quite flexible
>> enough to really be interesting, and supporting just one MSI irq was
>> ok but any more would lead to all kinds of strange special cases.
>
> Individual drivers can deal with those special cases if they are device-
> specific; and the platform can just refuse to do more than one MSI if
> something platform-specific would prevent correct operation.
>
> It would be nice to have the MSI and MSI-X interfaces have the same
> calling convention; in fact, they can probably be folded into one.

Examples? details? patches?

Part of the problem with plain MSI is that you can't mask irqs at the
source, in a generic way.

How do your ideas compare with my hypertransport irq implementation?

Eric
