Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWHBW73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWHBW73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHBW73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:59:29 -0400
Received: from thunk.org ([69.25.196.29]:46295 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932186AbWHBW72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:59:28 -0400
Date: Wed, 2 Aug 2006 18:59:13 -0400
From: Theodore Tso <tytso@mit.edu>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060802225912.GB30457@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Mathias Adam <a2@adamis.de>
References: <20060802194938.GL5972@redhat.com> <20060802201723.GC7173@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802201723.GC7173@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 09:17:23PM +0100, Russell King wrote:
> On Wed, Aug 02, 2006 at 03:49:38PM -0400, Dave Jones wrote:
> > This patch has been submitted a number of times, and doesn't seem
> > to get any upstream traction, which is a shame, as it seems to work
> > for users, and I keep inadvertantly dropping it from the Fedora
> > kernel everytime I rebase it.
> 
> As I've said, I'm ignoring all 950 patches because I don't know what
> works and what doesn't, and it's highly likely that applying one fix
> for one card breaks already working fixes for other cards because
> they have different crystals fitted, thereby requiring different
> register settings.

Actually, this particular one is probably safe, because it doesn't
depend on what crystal is installed, but rather works by using a
documented feature in the Oxford 950 UART to oversample the clock
signal.  In addition, the patch only activates UART_TCR if the user
requests the higher baud rates, so the patch only does something if
the user requests a baud rate that would have been previously rejected
by the driver.  Worse case, if the UART oscillator is badly
implemented, it might make the UART behave out of spec when supporting
an "overclocked" baud rate, but only when trying to support 234000 bps
on hardware where the stock driver would only support 115200 bps.  The
patch programs the UART identically for 115200bps, so it's pretty easy
to prove by inspection that it won't break existing setups.

> Basically, either I need 950 based hardware so I can at least validate
> that new fixes don't break existing setups, or someone else needs to
> be in this position and take on the responsibility for reviewing and
> testing future 950 based patches.

I'll have to wait until I get back home to make sure, but I think have
a 950 based card around somewhere that I'd be happy to give to you on
extended loan.  I'm not sure whether I have an PCI card; it might
actually be part of my ISA serial card collection....

						- Ted
