Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDXUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDXUTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWDXUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:19:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbWDXUTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:19:16 -0400
Date: Mon, 24 Apr 2006 13:18:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <20060424191558.GB16464@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0604241317510.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <20060424191558.GB16464@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Russell King wrote:

> On Mon, Apr 24, 2006 at 12:02:47PM -0700, Linus Torvalds wrote:
> > On Mon, 24 Apr 2006, Stephen Hemminger wrote:
> > > We should fail request_irq() if the SA_SHIRQ but the irq is edge-triggered.
> > 
> > That would be HORRIBLE.
> > 
> > Edge-triggered works perfectly fine for SA_SHIRQ, as long as there is just 
> > one user and the driver is properly written. Making request_irq() fail 
> > would break existing and working setups.
> 
> Sorry, untrue.  If you take a serial port and a network card on the same
> edge triggered interrupt line [ ... ]

Read what I wrote!

	"..as long as there is just one user .."

In other words, you MUST NOT disallow request_irq(), just because the one 
user happens to use SA_SHIRQ.

		Linus
