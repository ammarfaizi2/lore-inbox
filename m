Return-Path: <linux-kernel-owner+w=401wt.eu-S1750825AbXAEXcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXAEXcF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXAEXcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:32:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60144 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbXAEXcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:32:04 -0500
Date: Sat, 6 Jan 2007 00:28:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070105232853.GA20677@elte.hu>
References: <20070105215223.GA5361@elte.hu> <459ECDF7.9040309@vmware.com> <20070105223009.GA15369@elte.hu> <459ED624.1080100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459ED624.1080100@vmware.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> >>What you really want is more like 
> >>EXPORT_SYMBOL_READABLE_GPL(paravirt_ops);
> >>    
> >
> >yep. Not a big issue - what is important is to put the paravirt ops 
> >into the read-only section so that it's somewhat harder for rootkits 
> >to modify. (Also, it needs to be made clear that this is fundamental, 
> >lowlevel system functionality written by people under the GPLv2, so 
> >that if you utilize it beyond its original purpose, using its 
> >internals, you likely create a work derived from the kernel. 
> >Something simple as irq disabling probably doesnt qualify, and that 
> >we exported to modules for a long time, but lots of other details do. 
> >So the existence of paravirt_ops isnt a free-for all.)
> 
> I agree completely.  It would be nice to have a way to make certain 
> kernel structures available, but non-mutable to non-GPL modules.

the thing is, we are not 'making these available to non-GPL modules'. 
The _GPL postfix does not turn the other normal exports from grey into 
white. The _GPL postfix turns exports into almost-black for non-GPL 
modules. The rest is still grey.

in this case, i'd only make local_irq_*() available to modules (of any 
type), not the other paravirt ops. Exporting the whole of paravirt_ops 
was a mistake, and this has to be fixed before 2.6.20. I'll cook up a 
patch.

> >yes - this limit is easily triggered via the KVM/Qemu virtual serial 
> >drivers. You can think of "kvm_paravirt" as "Linux paravirt", it's 
> >just a flag.
> 
> Can't you just test paravirt_enabled() in that case?

yep - i've changed this in my tree.

	Ingo
