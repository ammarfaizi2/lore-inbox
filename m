Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWEOVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWEOVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWEOVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:54:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26753 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932307AbWEOVy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:54:27 -0400
Date: Mon, 15 May 2006 14:57:20 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Chris Wright <chrisw@sous-sol.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <Ian.Pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH 23/35] Increase x86 interrupt vector range
Message-ID: <20060515215720.GB25010@moss.sous-sol.org>
References: <200605131346_MC3-1-BFAF-FA0A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605131346_MC3-1-BFAF-FA0A@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:
> In-Reply-To: <20060509085157.070289000@sous-sol.org>
> 
> On Tue, 09 May 2006 00:00:23 -0700, Chris Wright wrote:
> 
> > Remove the limit of 256 interrupt vectors by changing the value
> > stored in orig_{e,r}ax to be the negated interrupt vector.
> > The orig_{e,r}ax needs to be < 0 to allow the signal code to
> > distinguish between return from interrupt and return from syscall.
> > With this change applied, NR_IRQS can be > 256.
> > 
> > Xen extends the IRQ numbering space to include room for dynamically
> > allocated virtual interrupts (in the range 256-511), which requires a
> > more permissive interface to do_IRQ.
> >
> > Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
> > Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > ---
> 
> AFAIC this could go in anytime.  It's simple, self-contained and makes
> sense even without Xen.

The plan is to split out things like this and push them ahead of the
rest of the batch.

> One minor nit: the IRQ value isn't negated, it's complemented.  The
> comments need to be fixed.

OK, bitwise negated.

thanks,
-chris
