Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVCUTI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVCUTI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVCUTI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:08:28 -0500
Received: from colin2.muc.de ([193.149.48.15]:6158 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261745AbVCUTHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:07:49 -0500
Date: 21 Mar 2005 20:07:41 +0100
Date: Mon, 21 Mar 2005 20:07:41 +0100
From: Andi Kleen <ak@muc.de>
To: Dave Peterson <dsp@llnl.gov>
Cc: oprofile-list@lists.sourceforge.net, bluesmoke-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dave_peterson@pobox.com
Subject: Re: [PATCH] NMI handler message passing / work deferral API
Message-ID: <20050321190741.GA98750@muc.de>
References: <200503202056.02429.dave_peterson@pobox.com> <m1eke93ul3.fsf@muc.de> <200503211103.56930.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503211103.56930.dsp@llnl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 11:03:56AM -0800, Dave Peterson wrote:
> On Monday 21 March 2005 07:08 am, Andi Kleen wrote:
> > Dave Peterson <dave_peterson@pobox.com> writes:
> > > Below is an experimental 2.6.11.5 kernel patch that implements the
> > > following:
> > >
> > >      - A generic mechanism for safely passing information from NMI
> > > handlers to code that executes outside NMI context.
> >
> > See the machine check queueing implementation in
> > arch/x86_64/kernel/mce.c. It does exactly that already.
> >
> > Several other architectures already have similar mechanisms.
> >
> > -Andi
> 
> Yes exactly.  That's one reason why I posted the patch.  Different
> sybsystems that need this type of functionality shouldn't have to
> individually reinvent the wheel.  With a single implementation, code
> is more compact and easier to understand and maintain.  I would argue

More compact? Sorry, but even all existing implementations together
are still far less code than your really complicated subsystem which
seems quite overengineered for this simple task for me.

Also lockless programming is tricky and I would feel quite uneasy
about auditing so much code.

> that code maintenance is of particular concern to code such as NMI
> and machine check handlers because bugs in this type of code can be
> hard to track down.

Yeah, that is why we use simple, not complex, code in there.

-Andi
