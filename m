Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946255AbWJSROb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946255AbWJSROb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946256AbWJSROb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:14:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946255AbWJSROa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:14:30 -0400
Date: Thu, 19 Oct 2006 10:14:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Martin Lorenz <martin@lorenz.eu.org>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-Id: <20061019101411.f2466b2e.akpm@osdl.org>
In-Reply-To: <m1mz7s5plh.fsf@ebiederm.dsl.xmission.com>
References: <20061017063710.GA27139@gimli>
	<4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
	<20061018063431.GE20238@gimli>
	<20061018232603.585d14c3.akpm@osdl.org>
	<20061019063921.GJ6189@gimli>
	<20061019000109.626170f7.akpm@osdl.org>
	<m1mz7s5plh.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 08:48:10 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> >
> > There are already three interrupt sources on 201, so they are all happy to
> > share.
> >
> > It's e1000.  Jesse, you fibbed ;)
> >
> > static int e1000_request_irq(struct e1000_adapter *adapter)
> > {
> > 	...
> > 	if (adapter->have_msi)
> > 		flags &= ~IRQF_SHARED;
> 
> Well MSI irqs can't be shared, as they are edged triggered.
> Is the e1000 really trying to use irq 201?   That would indicate
> a logic failure in the msi irq allocator.  It should never allocate
> an inuse irq.

It's gone very bad.  See 
http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.boot
http://www.lorenz.eu.org/~mlo/kernel/dmesg_2.6.18-ie-la-tp-41.5+0813.out

> I have to ask what is the state in 2.6.19-rc2? I'm wondering if
> my turning of the msi irq allocator inside out has fixed this problem.

Martin, please try  CONFIG_PCI_MSI=n.  I'd expect that to fix it (it always does)

> Does this situation work if MSI is disabled, in 2.6.18?
> 
> The backwards msi irq allocator in 2.6.18 is so convoluted it may have
> a corner case where it fails, and that is triggering this mess.
> 
> If 2.6.19 works with MSI's enabled and 2.6.18 works with MSI disabled
> I'm inclined to say I have done all that is reasonable.

oh, we haven't tried 2.6.19-rc2 yet?   Please do that, with CONFIG_PCI_MSI=y.
