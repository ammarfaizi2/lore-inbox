Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVJER2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVJER2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVJER2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:28:07 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9197 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030280AbVJER2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:28:06 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=BLEv19tc/PRixx555rrNHLIfKl41JX1TbAIizqJPdjqY9awOhFu1bk6O5PAPzDdxh
	f3AGf79DYFBYRpNoAwkSA==
Date: Wed, 05 Oct 2005 10:27:49 -0700
From: David Brownell <david-b@pacbell.net>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH/RFC 0/2] simple SPI framework, refresh + ads7864 driver
Cc: vwool@ru.mvista.com, linux-kernel@vger.kernel.org
References: <20051005162117.24DDBEE95B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20051005162453.GD7761@flint.arm.linux.org.uk>
In-Reply-To: <20051005162453.GD7761@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005172749.C0BE9EE973@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 5 Oct 2005 17:24:53 +0100
> From: Russell King <rmk+lkml@arm.linux.org.uk>
>
> On Wed, Oct 05, 2005 at 09:21:17AM -0700, David Brownell wrote:
> > In my investigations of SPI, I don't happen to have come across any
> > SPI slave device that would naturally be handled as a block device.
> > There's lots of flash (and dataflash); that's MTD, not block.
>
> In two words, MMC cards.

With the interesting subcase of DataFlash cards, which are MMC format
but which only talk SPI protocol.  Dataflash would go through MTD.

(Seems to me that DataFlash cards are now "old tech" not being put
into many new systems.  Certainly they're not price-competitive with
MMC/SD ... DigiKey charges $US 28 for an 8 MB card, quantity one,
and that's the local price of a single 256 MB MMC or SD card.  The
story with discrete DataFlash chips seems to be different.)


> They can be used in MMC mode or SPI mode.

Yes, but ... any system with an MMC controller would use them in
MMC mode; then they'd be "MMC devices".  (Except DataFlash...)

The reason to use them in SPI mode is that that the system might
not _have_ an MMC controller, yet it might want inexpensive
removable storage.

(And there's another funky case too.  Most MMC controllers will
handle SPI protocol directly; I'm not sure how full the support
is, maybe it's just enough to talk to MMC cards.  But systems
that want SPI -- say, for sensors -- might do that using their
MMC controllers on one of the chipselects that's not used for
an external card slot.)


>  	 There have been some queries
> about using them in SPI mode, but I don't think anyone's written such
> a driver (yet).

Nor does the MMC stack yet understand that notion... it'd likely
help a bit if there were an SPI framework to build on!

Teaching that stack how to work in SPI mode, or even represent
controllers which only support SPI protocol, would be a lot more
work than just letting SPI drivers optionally provide DMA addresses
as well as the CPU addresses for their buffers.  :)

- Dave

