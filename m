Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWGKGaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWGKGaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWGKGaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:30:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32390 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965224AbWGKGaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:30:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<1152571162.1576.122.camel@localhost.localdomain>
	<m14pxolryw.fsf@ebiederm.dsl.xmission.com>
	<1152595205.6346.26.camel@localhost.localdomain>
Date: Tue, 11 Jul 2006 00:29:26 -0600
In-Reply-To: <1152595205.6346.26.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 11 Jul 2006 15:20:05 +1000")
Message-ID: <m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> I didn't really expect you to have an immediate use, but the
>> confirmation is nice.  The interesting part is how I have factored out
>> the arch specific details. I believe this is close to the direction
>> you envisioned for msi.  If you could look at the basic structure
>> and confirm that the structure looks properly arch neutral that
>> would be appreciated.  As time permits I want to make the msi code
>> look more the this hypertransport irq code.
>
> Ok, I'll try to have a second look in the plane :) (I'm flying off
> tomorrow). If you are interested in the new IRQ infrastructure I did for
> powerpc, it's now upstream (read comments in arch/powerpc/kernel/irq.c).

Ok.  Thanks.  If I stay sufficient stuck in irq land I will.  I keep
hoping to find the end of this project :)  This all started when I
looked at some problem with irqs and say hey that is easy to fix
you just do this....

> I don't have time to work much on the MSI aspect of things before OLS
> though and I'll be away after that until end of august with only
> intermittent internet access, so we'll talk about it again either at OLS
> itself if we find some time, or when I'm back.

Sure, it looks like I at least get to play care taker of this code for
a while.

I think the separation of linux irq numbers and hardware addresses
seems fairly sane.  Having something you can get a grip on is nice but
that really doesn't work for things like msi's.  Unless we move to a
completely sparse architecture where the irq number is: 
((((domain*256)+bus)*256)+devfn)*1024

As for supporting multiple irqs in plain MSI mode, I don't think
we want to do that.  The problem is that multiple interrupts
in msi mode cannot be individually routed.  I think we really want
to encourage vendors who are building cards with multiple MSI irqs
to use MSI-X.  MSI-X has a lot fewer ugly special cases and all
architectures can individually route the irqs.

If there are interesting cards that support just MSI mode and really
need more than one irq I would be happy to reconsider that decision
but my impression was that plain MSI was basically not quite flexible
enough to really be interesting, and supporting just one MSI irq was
ok but any more would lead to all kinds of strange special cases.

Eric
