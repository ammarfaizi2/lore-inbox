Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWGJWjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWGJWjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWGJWjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:39:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:14260 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964868AbWGJWjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:39:39 -0400
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 08:39:22 +1000
Message-Id: <1152571162.1576.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 16:26 -0600, Eric W. Biederman wrote:
> This patch implements two functions ht_create_irq and ht_destroy_irq
> for use by drivers.  Several other functions are implemented as helpers
> for arch specific irq_chip handlers.
> 
> The driver for the card I tested this on isn't yet ready to be merged.
> However this code is and hypertransport irqs are in use in a few other
> places in the kernel.  Not that any of this will get merged before
> 2.6.19
> 
> Because the ipath-ht400 is slightly out of spec this code will need
> to be generalized to work there.
> 
> I think all of the powerpc uses are for a plain interrupt controller
> in a chipset so support for native hypertransport devices is a little
> less interesting.

At this point, the only PPCs with HT interrupts that I know are 970
based solutions using the Apple U3/U4 bridges (and their IBM
counterparts). Thus all HT interrupts are routed to the MPIC as sources,
so things like masking, affinity, etc... are all handled at the MPIC
level, not at the HT level and they all originate from either an Apple
home made HT APIC or standard HT APICs in PCI-X/E tunnels. We still need
to poke around with the HT APICs for configuration and EOI on level
interrupts (due to a bug in the Apple MPIC, the EOI doesn't get sent
back to the HT APIC) but we have code locally in the MPIC driver to do
it and I don't think it would fit well a generic layer.

Things might be different in the future... but for now, I'm afraid I
have no use of that HT layer.

Cheers
Ben.


