Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265908AbUFDSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbUFDSSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUFDSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:18:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:13751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265908AbUFDSRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:17:33 -0400
Date: Fri, 4 Jun 2004 11:15:28 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-ID: <20040604181528.GA11527@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com> <1086222156.29391.337.camel@bach> <20040603162712.GA3291@kroah.com> <20040603093807.33bc670d.pj@sgi.com> <20040603165142.GA3959@kroah.com> <1086312466.7990.884.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086312466.7990.884.camel@bach>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:27:46AM +1000, Rusty Russell wrote:
> On Fri, 2004-06-04 at 02:51, Greg KH wrote:
> > Just be aware of the size and code your show() function to be defensive
> > and not overrun that size.
> 
> This is where we have a philosophical difference.  As I understand it,
> the rule is, "don't put big things in attributes".  If we want to change
> that rule, we need to do more work, like pass the length to the show
> function, and handle -ENOMEM by reallocating and looping.

We don't want to change the rule, it's a good rule.

> But I think the /rule/ is a good one: if you need to handle something
> arbitrarily large, DON'T USE THIS INTERFACE, because there is no way to
> do that correctly.  This allows us to handle 99.9% of cases as a
> one-liner, which I think has great merit.

Agreed.

> I think we should guarantee any kernel primitive fits into the space:
> this means it should comfortably fit printing a cpumask_t.  I would
> argue for a #error inside the cpumask or sysfs code which ensures we can
> fit two cpumasks (~7000 CPUs on page-size 4096), so we explode early if
> this ever becomes a problem, and a runtime sanity check inside the sysfs
> code to BUG on overrun.

Again, this seems to be a issue with the code that is trying to export a
cpumask_t.  I suggest you keep the check inside that code and keep it
out of the sysfs core, which does not need it for 99.99% of the cases.

thanks,

greg k-h
