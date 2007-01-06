Return-Path: <linux-kernel-owner+w=401wt.eu-S1751423AbXAFQSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbXAFQSz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAFQSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 11:18:55 -0500
Received: from ozlabs.org ([203.10.76.45]:54488 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbXAFQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 11:18:54 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20070106071424.GB11232@elte.hu>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
	 <1168064710.20372.28.camel@localhost.localdomain>
	 <20070106071424.GB11232@elte.hu>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 03:18:45 +1100
Message-Id: <1168100325.20372.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 08:14 +0100, Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > +EXPORT_SYMBOL(clts);
> > +EXPORT_SYMBOL(read_cr0);
> > +EXPORT_SYMBOL(write_cr0);
> 
> mark these a _GPL export. Perhaps even mark the symbol deprecated, to be 
> unexported once we fix raid6.

OK...

> > +EXPORT_SYMBOL(wbinvd);
> > +EXPORT_SYMBOL(raw_safe_halt);
> > +EXPORT_SYMBOL(halt);
> > +EXPORT_SYMBOL_GPL(apic_write);
> > +EXPORT_SYMBOL_GPL(apic_read);
> 
> these should be _GPL too. If any module uses it and breaks a user's box 
> we need that big licensing hint to be able to debug them ...

OK.  I GPLed the ones which I thought were really obscure, but I was
trying to follow existing policy of not _GPL'ing existing symbols.

Cheers,
Rusty.

PS.  drm_memory.h has a "drm_follow_page": this forces us to uninline
various page tables ops.  Can this use follow_page() somehow, or do we
need an "__follow_page" export for this case?




