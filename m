Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVA3S2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVA3S2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVA3S2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:28:13 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64015 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261762AbVA3S1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:27:50 -0500
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Lukasz Kosewski <lkosewsk@nit.ca>,
       Andrew Morton <akpm@osdl.org>, vgoyal@in.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20050130152749.GF5186@logos.cnet>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
	 <1105013524.4468.3.camel@laptopd505.fenrus.org>
	 <20050106195043.4b77c63e.akpm@osdl.org> <41DE15C7.6030102@nit.ca>
	 <20050107043832.GR27371@parcelfarce.linux.theplanet.co.uk>
	 <20050130152749.GF5186@logos.cnet>
Content-Type: text/plain
Date: Sun, 30 Jan 2005 19:27:26 +0100
Message-Id: <1107109647.4306.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 13:27 -0200, Marcelo Tosatti wrote:
> On Fri, Jan 07, 2005 at 04:38:32AM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 06, 2005 at 11:53:27PM -0500, Lukasz Kosewski wrote:
> > > I have an idea of something I might do for 2.6.11, but I doubt anyone
> > > will actually agree with it.  Say we keep a counter of how many times
> > > interrupt x has been fired off since the last timer interrupt
> > > (obviously, a timer interrupt resets the counter).  Then we can pick an
> > > arbitrary threshold for masking out this interrupt until another device
> > > actually pines for it.
> > > 
> > > Or something.  The point is, we need a general solution to the problem,
> > > not poking about in every single driver trying to tie it down.
> > 
> > Something like note_interrupt() in kernel/irq/spurious.c?
> 
> BTW I wonder if its feasible to add an interface on top of kernel/irq/spurious.c for 
> notifying drivers about interrupts storms, so they can take appropriate action 
> (try to reset the device).

the problem is... the driver just denied it was their irq (at least in
all the common cases)... 


