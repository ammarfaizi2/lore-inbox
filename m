Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWFNFEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWFNFEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWFNFEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:04:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34240 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964869AbWFNFEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:04:39 -0400
To: Greg KH <greg@kroah.com>, mp3@de.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com>
	<20060613234739.GA30534@kroah.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Jun 2006 07:04:35 +0200
In-Reply-To: <20060613234739.GA30534@kroah.com>
Message-ID: <p73slm8qqe4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> > + * exploiters don't update several statistics of the same entity in one go.
> > + */
> > +static inline void statistic_add(struct statistic *stat, int i,
> > +				 s64 value, u64 incr)
> > +{
> > +	unsigned long flags;
> > +	local_irq_save(flags);
> > +	if (stat[i].state == STATISTIC_STATE_ON)
> > +		stat[i].add(&stat[i], smp_processor_id(), value, incr);


Indirect call in statistics hotpath?  You know how slow this is 
on IA64 and even on other architectures it tends to disrupt 
the pipeline.

Also on i386 the u64s generate quite bad code.

That looks like a really bad implementation that shouldn't be used
anywhere.

-Andi
