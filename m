Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUCQAB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUCQAB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:01:26 -0500
Received: from colin2.muc.de ([193.149.48.15]:3856 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261798AbUCQABZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:01:25 -0500
Date: 17 Mar 2004 01:01:24 +0100
Date: Wed, 17 Mar 2004 01:01:23 +0100
From: Andi Kleen <ak@muc.de>
To: Greg KH <greg@kroah.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
Message-ID: <20040317000123.GB70879@colin2.muc.de>
References: <1AajM-5vw-21@gated-at.bofh.it> <1Abpq-6Av-1@gated-at.bofh.it> <1Aj3K-5Fn-9@gated-at.bofh.it> <1AjwZ-65D-15@gated-at.bofh.it> <m3brmwojk8.fsf@averell.firstfloor.org> <20040316194039.GA21702@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316194039.GA21702@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 11:40:39AM -0800, Greg KH wrote:
> On Tue, Mar 16, 2004 at 05:14:47PM +0100, Andi Kleen wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > >
> > > eh?  If there is any argument against this code it is that it is so simple
> > > that the thing which it abstracts is not worth abstracting.  But given that
> > > it is so unwasteful, this seems unimportant.
> > 
> > The bloat argument was about the additional pointer in the dynamic 
> > data structure (on a 64bit architecture it costs 12 bytes) 
> 
> Well balance that out against every usb driver re-implemeting the same
> get/put logic with an atomic counter and that "bloat of a pointer" just

Yes, all those one and two liners duplicated ... scary.

> got lost in the noise of the extra kernel code size increase :)

Have you ever looked how many instructions 
	
	if (!atomic_dec_and_test(&foo->ref))
		release(foo) 

generated? Code size makes no difference here at all.

Dynamic object bloat is much worse than code bloat anyways because you
can have thousands of these objects.

-Andi
