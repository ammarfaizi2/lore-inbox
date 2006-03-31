Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWCaTcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWCaTcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWCaTcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:32:12 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:46513 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932067AbWCaTcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:32:10 -0500
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 11:16:27 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@kernel.crashing.org>,
       spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311011.00981.david-b@pacbell.net> <1143829180.4355.51.camel@ststephen.streetfiresound.com>
In-Reply-To: <1143829180.4355.51.camel@ststephen.streetfiresound.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311116.27971.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 10:19 am, Stephen Street wrote:
> On Fri, 2006-03-31 at 10:11 -0800, David Brownell wrote:
> > I don't know how your particular hardware works, but if you have a
> > real SPI controller it would probably be more natural to have your
> > setup() function handle that mode register earlier, out of the main
> > transfer loop ... unless that mode register is shared among all
> > chipselects, in which case you'd use the setup_transfer() call for
> > that, inside the transfer loop.  (That call hasn't yet been merged
> > into the mainline kernel yet; it's in the MM tree.)
> > 
> Is setup_transfer() a change to framework API or just the bit_bang
> driver?

Just bitbang.


> > The chipselect() call should only affect the chipselect signal and,
> > when you're activating a chip, its initial clock polarity.  Though
> > if you're not using the latest from the MM tree, that's also your
> > hook for ensuring that the SPI mode is set up right.
> 
> Ditto?

Ditto.  Though it should also be OK, come to think of it, to keep
doing SPI mode selection in chipselect(); that shouldn't break.

- Dave

