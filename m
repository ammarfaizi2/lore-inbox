Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWGHAOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWGHAOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGHAOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:14:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8387 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932430AbWGHAOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:14:43 -0400
Date: Fri, 7 Jul 2006 17:14:27 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, John Daiker <jdaiker@osdl.org>,
       John Hawkes <hawkes@sgi.com>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Message-ID: <20060708001427.GA723842@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com> <yq04py4i9p7.fsf@jaguar.mkp.net> <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com> <1151578513.3122.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151578513.3122.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 12:55:13PM +0200, Arjan van de Ven wrote:
> On Thu, 2006-06-29 at 12:48 +0200, Jes Sorensen wrote:
> > Alan Cox wrote:
> > > Ar Iau, 2006-06-29 am 05:37 -0400, ysgrifennodd Jes Sorensen:
> > >> You have my vote for that one. Anything else is just going to cause
> > >> those broken userapps to continue doing the wrong thing. We should
> > >> really do this on all archs though.
> > > 
> > > No need, all current mainstream architectures expose a constant user HZ.
> > 
> Hi,
> 
> > But you are still going to have the issue where someone installs their
> > own kernel and apps will break because of this?
> 
> to answer that question with one word: no.
> 
> read what Alan said: the HZ exposed to userspace is *constant*. For
> example, the i386 user visible HZ is 100, even if the kernel runs at a
> HZ of 250 or 1000.... Just when a HZ value gets exposed to userspace,
> it's transformed into a HZ=100 based value.
> 
> And that's not a distribution thing, that's the kernel.org kernel
> honoring the stable-userspace-interface contract, and common sense..


So does i386 convert the return value of the times(2) call to user
hertz?  On IA64, it returns the value in internal clock ticks, and
then when a program uses the value in param.h, it gets it wrong now,
because internal HZ is now 250.

So is times() is broken in IA64, or is this an exception to Alan's
statement?

jeremy
