Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUDQJpf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbUDQJpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:45:33 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:14092 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263757AbUDQJp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:45:29 -0400
Date: Sat, 17 Apr 2004 10:45:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (new)
Message-ID: <20040417104527.A16676@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040416130548.B5080@infradead.org> <20040416141720.746ABDBEE@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040416141720.746ABDBEE@gherkin.frus.com>; from rct@gherkin.frus.com on Fri, Apr 16, 2004 at 09:17:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 09:17:20AM -0500, Bob Tracy wrote:
> Given that the driver currently supports only PCMCIA implementations,
> I agree.  My thinking was if someone comes up with a host adapter that
> isn't PCMCIA, the SYM53C500.c file is to the sym53c500_cs driver what
> the qlogicfas.c file is to the qlogic_cs driver, that is, core functions
> that could support multiple types of host adapters.  The logic to
> handle the different types of adapters isn't there, and I don't know
> that it ever will be (else, it's probable that someone would have
> written the Linux driver long before now).  However, after baring my
> ignorance to the world and saying I was unaware of non-PCMCIA
> implementations, I found a FreeBSD driver for the NCR 53c500.  Never
> say "never," I guess...  Your opinion counts for much, but you're the
> only person I've heard from.  Is there a consensus I should forget
> about the non-PCMCIA cases?

I'd suggest to keep it as simple as you can for the time beeing.  If we
ever find a user with a ISA or whatever variant he can split it out.  And
such a split would work a little different from what you did now.

> >  - the driver doesn't even try to deal with multiple HBAs
> 
> Guilty as charged.  Functionally, there's nothing in the driver I
> submitted that wasn't in the original.  Suggestions welcome...  Which
> of the existing PCMCIA SCSI drivers do a proper job of handling
> multiple host adapters in your opinion?  I'll try to adapt that code to
> fit this driver.  If I have to "roll my own" from scratch, I'm probably
> in over my head.

It looks like nsp_cs at least tries to :-)

> >  - your detection logic could be streamlined a little, e.g. the request/release
> >    resource mess
> 
> I'll see what I can do.
> 
> Although I touched on it above, by way of apology/explanation, the goal
> for the initial port was to replicate the functionality I already had in
> older kernel versions.  It appears I faithfully replicated the
> deficiencies of the old driver as well :-).  Again, thank you for the
> feedback.

Hey, you don't need to apologize.   Anyt 2.6 driver is better than none and
your looks quite okay from the functional standpoint.  We just need to have
a little higher bars for new drivers as we already have lots of maintaince
overhead for old and sloppy written drivers.

