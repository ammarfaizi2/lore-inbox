Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWFUKaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWFUKaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWFUKaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:30:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16529 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751481AbWFUKaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:30:00 -0400
Date: Wed, 21 Jun 2006 12:24:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/25] Decouple IRQ issues (MSI, i386, x86_64, ia64)
Message-ID: <20060621102407.GA18447@elte.hu>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> The following patchset is against 2.6.17-rc6-mm2. It was the only easy 
> place I could get everyones work who has been touching relevant code.
> 
> The primary aim of this patch is to remove maintenances problems 
> caused by the irq infrastructure.  The two big issues I address are an 
> artificially small cap on the number of irqs, and that MSI assumes 
> vector == irq.  My primary focus is on x86_64 but I have touched other 
> architectures where necessary to keep them from breaking.

Very nice! Your queue addresses all of the remaining grievances i had 
about the x86_64/i386 IRQ code (MSI/balancing) and does this ontop of 
genirq, which is very good. This is much more than i hoped for when you 
told us about your project! :)

The only open bigger issue i guess (besides all the smaller code details 
that i'm sure we'll sort out) is timing. Your queue, as tempting as it 
is, is probably not 2.6.18 material. _I_ would certainly dare this for 
2.6.18, but Andrew/Linus would kill me i guess.

So the question is - are we brave/confident enough to try to stabilize 
this in the next couple of days and drop it into 2.6.18 together with 
the other bits of genirq? I strongly suspect that the bugs this patchset 
will introduce is roughly equal to the bugs we already have due to the 
existing MSI and irq-balancing unrobustnesses, so we might as well go 
for that, instead of prolonging the pain by doing a two-stage (or 
3-stage) process. (which would be to introduce genirq stage #1 now, then 
introduce genirq stage #2 in 2.6.19) Delaying genirq to 2.6.19 
altogether would be messy i think and would interfere with ben's (and 
others') platform plans. Hm?

One big point of confidence would be if ia64 built and booted fine with 
these changes. Somehow ia64 seems to be the most sensitive to MSI (and 
genirq) changes.

	Ingo
