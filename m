Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbVKXVGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVKXVGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbVKXVGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:06:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:47341 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161045AbVKXVGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:06:00 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <200511242150.23205.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	 <200511240122.46125.rjw@sisk.pl> <1132795396.26560.382.camel@gaston>
	 <200511242150.23205.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 08:01:27 +1100
Message-Id: <1132866088.26560.455.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Well, it's there (actually the problem occurs in vanilla 2.6.15-rc2-mm1 that
> contains the patch).  Do you mean it should go before the
> 
> if (readl(&ehci->regs->configured_flag) != FLAG_CF)
> 		goto restart;
> 
> thing?

Yes.

> > It may be worth following it with a memory barrier actually... just in case
> > (due to the absence of locks in that area).
> 
> wmb()?

Yup.

I wrote that patch against a tree that had different things in that
function, Greg merged it by hand but he got that little bit wrong
unfortunately. I'll send a new patch later today.

Ben.


