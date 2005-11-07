Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVKGIwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVKGIwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVKGIwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:52:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41224 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932458AbVKGIwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:52:05 -0500
Date: Mon, 7 Nov 2005 08:51:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fwd: [RFC] IRQ type flags
Message-ID: <20051107085156.GA18358@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20051106084012.GB25134@flint.arm.linux.org.uk> <1131316897.1212.61.camel@localhost.localdomain> <20051106221643.GB6274@flint.arm.linux.org.uk> <1131317998.1212.63.camel@localhost.localdomain> <20051106224225.GC6274@flint.arm.linux.org.uk> <1131321802.1212.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131321802.1212.75.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:03:22AM +0000, Alan Cox wrote:
> On Sul, 2005-11-06 at 22:42 +0000, Russell King wrote:
> > We could do as you suggest, but my concern would be adding extra
> > complexity to drivers, causing them to do something like:
> > 
> > 	ret = request_irq(..., SA_TRIGGER_HIGH, ...);
> > 	if (ret == -E<whatever>)
> > 		ret = request_irq(..., SA_TRIGGER_RISING, ...);
> > 
> > The alternative is:
> > 
> > 	ret = request_irq(..., SA_TRIGGER_HIGH | SA_TRIGGER_RISING, ...);
> 
> I was thinking that specifying neither would imply 'don't care' or
> 'system default'. That would mean existing drivers just worked and
> driver authors who didnt care need take no specific action.

Yes, this is exactly what the ARM implementation already does.  I'll
add a comment to that effect.

As per benh's suggestion, I don't see the point of adding a definition
- not unless we're going to fix up all drivers which call request_irq().
That would be a very big task.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
