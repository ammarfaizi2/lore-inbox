Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVGYQ5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVGYQ5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVGYQ5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:57:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261371AbVGYQ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:57:50 -0400
Date: Mon, 25 Jul 2005 17:57:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050725175738.E7629@flint.arm.linux.org.uk>
Mail-Followup-To: dtor_core@ameritech.net, Pavel Machek <pavel@suse.cz>,
	rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <d120d500050725081664cd73fe@mail.gmail.com> <20050725165014.B7629@flint.arm.linux.org.uk> <d120d50005072509022ccbdd0a@mail.gmail.com> <20050725171311.D7629@flint.arm.linux.org.uk> <d120d500050725094776984a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <d120d500050725094776984a0f@mail.gmail.com>; from dmitry.torokhov@gmail.com on Mon, Jul 25, 2005 at 11:47:25AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 11:47:25AM -0500, Dmitry Torokhov wrote:
> On 7/25/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > If you look at _my_ version, you'll notice that it doesn't use the
> > class interface stuff.  A previous version of it did, and this seems
> > to be what the collie stuff is based upon.
> 
> I was only commenting on something that was posted on LKML for
> inclusion into input subtree that I am interested in. I don't track
> ARM development that closely. Where can we see your version, please?

See earlier in this thread, 24th July.

> > What I suggest is that the collie folk need to update their driver
> > to my version so that we don't have two different forks of the same
> > driver in existance.  Then we can start discussing whether things
> > should be using kthreads or not.
> 
> Do you have any reason why, generally speaking, threads should not be
> used? They seem to clean up code in drivers quite a bit.

It depends what the reasoning is behind them.  The touchscreen driver
is threaded because it wants to collect touschreen samples independently
of the availability of a user thread.  Moreover, obtaining ADC samples
needs a sleeping context since it may take a while to complete.

However, putting all UCB interrupts into a thread does not make sense
to me - if we allow UCB interrupts to sleep, it allows one UCB interrupt
to be processed at the exclusion of the others.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
