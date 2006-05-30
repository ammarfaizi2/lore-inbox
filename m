Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWE3Wtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWE3Wtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWE3Wte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:49:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6078 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964798AbWE3Wte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:49:34 -0400
Date: Wed, 31 May 2006 00:49:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530224955.GA5500@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <adawtc34364.fsf@cisco.com> <20060530154521.d737cc65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530154521.d737cc65.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 30 May 2006 14:24:03 -0700
> Roland Dreier <rdreier@cisco.com> wrote:
> 
> > I'm seeing problems with MSI-X interrupts on 2.6.17-rc5-mm1.  I'll try
> > to debug the MSI patches in -mm further in the next day or so, but for
> > now I'll post the symptoms.
> > 
> > When I load the ib_mthca driver with MSI-X interrupts enabled, I get
> > the following crash as soon as the first interrupt is generated.
> 
> do_IRQ() did a jump-to-zero.  So there's no handler installed.

yep. No desc->irq_handler. That should be 'impossible' on x86_64, 
because the irq_desc[] array is initialized with handle_bad_irq, and 
from that point on x86_64 only uses set_irq_chip_and_handler(), which at 
most can set it to another (non-NULL) handle_irq function. Weird.

does MSI much with the irq_desc[] separately perhaps, clearing 
handle_irq in the process perhaps?

	Ingo
