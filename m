Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbULaRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbULaRBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbULaRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:01:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35343 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261695AbULaRBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:01:43 -0500
Date: Fri, 31 Dec 2004 17:01:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp: Make driver SMP-correct
Message-ID: <20041231170139.B10216@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20041231014611.003281e5.akpm@osdl.org> <20041231100037.A29868@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041231100037.A29868@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Dec 31, 2004 at 10:00:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 10:00:37AM +0000, Russell King wrote:
> On Fri, Dec 31, 2004 at 01:46:11AM -0800, Andrew Morton wrote:
> > James Nelson <james4765@verizon.net> wrote:
> > >
> > > This is an attempt to make the esp serial driver SMP-correct.  It also removes
> > >  some cruft left over from the serial_write() conversion.
> > 
> > >From a quick scan:
> > 
> > - startup() does multiple sleeping allocations and request_irq() under
> >   spin_lock_irqsave().  Maybe fixed by this:
> 
> However, can you guarantee that two threads won't enter startup() at
> the same time?  (that's what ASYNC_INITIALIZED is protecting the
> function against, and the corresponding shutdown() as well.)
> 
> It's probably better to port ESP to the serial_core structure where
> this type of thing is already taken care of.

For the record, Verizon appear to have adopted silly policies.

>From now on, I will be removing the CC: line containing any verizon
email address until further notice, or just plain ignoring mails
containing such addresses.  Why?  To prevent the inevitable bounce
caused by their misconfigured systems.  None of the servers I have
access to on several different ISPs can connect to Verizon's incoming
mail server.

See:
 http://www.broadbandreports.com/forum/remark,12116645~mode=flat~days=9999

particularly the last post by techie68, who claims to be a Verizon
tech support person.

I encourage James Nelson to find another provider without silly policies
in the mean time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
