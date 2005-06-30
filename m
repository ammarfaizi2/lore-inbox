Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVF3LWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVF3LWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVF3LWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:22:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262716AbVF3LV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:21:57 -0400
Date: Thu, 30 Jun 2005 12:21:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050630122152.B16103@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200506300852.25943.vda@ilport.com.ua> <200506301321.20692.vda@ilport.com.ua> <1120128441.3181.37.camel@laptopd505.fenrus.org> <200506301410.43524.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506301410.43524.vda@ilport.com.ua>; from vda@ilport.com.ua on Thu, Jun 30, 2005 at 02:10:43PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 02:10:43PM +0300, Denis Vlasenko wrote:
> On Thursday 30 June 2005 13:47, Arjan van de Ven wrote:
> > On Thu, 2005-06-30 at 13:21 +0300, Denis Vlasenko wrote:
> > > On Thursday 30 June 2005 12:19, Arjan van de Ven wrote:
> > > > 
> > > > > > There are a number of compile-time checks that your patch has removed
> > > > > > which catch such things, and as such your patch is not acceptable.
> > > > > > Some architectures have a lower threshold of acceptability for the
> > > > > > maximum udelay value, so it's absolutely necessary to keep this.
> > > > > 
> > > > > It removes that check from x86 - other architectures retain it.
> > > > > 
> > > > > 
> > > For users, _any_ value, however large, will work for
> > > any delay function.
> > 
> > that's not desired though. Desired is to limit udelay() to say 2000 or
> > so. And force anything above that to go via mdelay() (just to make it
> > stand out as broken code ;)
> 
> An if(usec > 2000) { printk(..); dump_stack(); } will do.

No it won't - that's a run time test which will only get caught if the
code is run.  There's no guarantees of that.

> But do you really want to do this? There might be legitimate reasons
> to compute udelay's parameter with results which are sometimes large.

Yes.  udelay() has overflow issues - if you pass too large a number
to udelay() you get a randomised delay because you've lost the top
bits.

The maximum delay is dependent on the architecture implementation,
and it depends on bogomips.  There is no one single value for it.
Architectures have to decide this from the way that they do the
math and the expected range of bogomips.

Please - leave asm-*/delay.h alone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
