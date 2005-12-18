Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVLRDTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVLRDTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVLRDTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:19:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932680AbVLRDTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:19:36 -0500
Date: Sat, 17 Dec 2005 19:19:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
Message-Id: <20051217191932.af2b422c.akpm@osdl.org>
In-Reply-To: <1134859243.20575.84.camel@phosphene.durables.org>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	<200512161548.lRw6KI369ooIXS9o@cisco.com>
	<20051217123833.1aa430ab.akpm@osdl.org>
	<1134859243.20575.84.camel@phosphene.durables.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Walsh <rjwalsh@pathscale.com> wrote:
>
> > > +	movl %edx,%ecx
> > > +	shrl $1,%ecx
> > > +	andl $1,%edx	
> > > +	cld
> > > +	rep 
> > > +	movsq 
> > > +	movl %edx,%ecx
> > > +	rep
> > > +	movsd
> > > +	ret
> > 
> > err, we have a portability problem.
> 
> Any chance we could get these moved into the x86_64 arch directory,
> then?

That would make sense.  Give it a non-ipath-related name and require that
all architectures which wish to run this driver must implement that
(documented) function.

And, in Kconfig, make sure that architectures which don't implement that
library function do not attempt to build this driver.  To avoid breaking
`make allmodconfig'.

>  We have to do double-word copies, or our chip gets unhappy.

In what form is this chip available?  As a standard PCI/PCIX card which
people will want to plug into power4/ia64/x86 machines?  Or is it in some
way exclusively tied to x86_64?
