Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUDPOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDPOR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:17:27 -0400
Received: from gherkin.frus.com ([192.158.254.49]:45958 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263191AbUDPORX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:17:23 -0400
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (new)
In-Reply-To: <20040416130548.B5080@infradead.org> "from Christoph Hellwig at
 Apr 16, 2004 01:05:48 pm"
To: Christoph Hellwig <hch@infradead.org>
Date: Fri, 16 Apr 2004 09:17:20 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040416141720.746ABDBEE@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> I've given it a short spin and here's a bunch of comments:

Thank you for taking the time and trouble to review it.

>  - the split into three source files is supserflous, one file should do it

Given that the driver currently supports only PCMCIA implementations,
I agree.  My thinking was if someone comes up with a host adapter that
isn't PCMCIA, the SYM53C500.c file is to the sym53c500_cs driver what
the qlogicfas.c file is to the qlogic_cs driver, that is, core functions
that could support multiple types of host adapters.  The logic to
handle the different types of adapters isn't there, and I don't know
that it ever will be (else, it's probable that someone would have
written the Linux driver long before now).  However, after baring my
ignorance to the world and saying I was unaware of non-PCMCIA
implementations, I found a FreeBSD driver for the NCR 53c500.  Never
say "never," I guess...  Your opinion counts for much, but you're the
only person I've heard from.  Is there a consensus I should forget
about the non-PCMCIA cases?

>  - please don't use host.h or scsi.h from drivers/scsi/.  The defintions
>    not present in include/scsi/ are deprecated and shall not be used (the
>    most prominent example in your driver are the Scsi_<Foo> typedefs that
>    have been replaced by struct scsi_foo

I caught that in the coding style guidelines (and in the mentioned
include files), and will fix for the next submission.

>  - the driver doesn't even try to deal with multiple HBAs

Guilty as charged.  Functionally, there's nothing in the driver I
submitted that wasn't in the original.  Suggestions welcome...  Which
of the existing PCMCIA SCSI drivers do a proper job of handling
multiple host adapters in your opinion?  I'll try to adapt that code to
fit this driver.  If I have to "roll my own" from scratch, I'm probably
in over my head.

>  - your detection logic could be streamlined a little, e.g. the request/release
>    resource mess

I'll see what I can do.

Although I touched on it above, by way of apology/explanation, the goal
for the initial port was to replicate the functionality I already had in
older kernel versions.  It appears I faithfully replicated the
deficiencies of the old driver as well :-).  Again, thank you for the
feedback.

Anyone else have input before I act on the recommendations I've been
given?  Unless I hear otherwise, I'll start work on the code
consolidation and removal of dependencies on deprecated include files.
The detection logic and handling multiple HBAs will take a bit more
effort...

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
