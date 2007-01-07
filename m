Return-Path: <linux-kernel-owner+w=401wt.eu-S932294AbXAGBKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbXAGBKI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 20:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbXAGBKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 20:10:08 -0500
Received: from ozlabs.org ([203.10.76.45]:60729 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294AbXAGBKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 20:10:06 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <45A00CB0.2020509@vmware.com>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
	 <1168064710.20372.28.camel@localhost.localdomain>
	 <20070106070807.GA11232@elte.hu>
	 <1168105353.20372.39.camel@localhost.localdomain>
	 <45A00CB0.2020509@vmware.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 12:09:56 +1100
Message-Id: <1168132196.20372.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 12:55 -0800, Zachary Amsden wrote:
> Rusty Russell wrote:
> >
> > +int paravirt_write_msr(unsigned int msr, u64 val);
> 
> If binary modules using debug registers makes us nervous, the 
> reprogramming MSRs is also similarly bad.

Yes, but this is simply from experience.  Several modules wrote msrs
(you can take out the EXPORT_SYMBOL and find them quite quickly).

> > +void raw_safe_halt(void);
> > +void halt(void);
> 
> These shouldn't be done by modules, ever.  Only the scheduler should 
> decide to halt.

Several modules implement alternate halt loops.  I guess being in a
module for specific CPUs makes sense...

Cheers!
Rusty.

