Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVL2VXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVL2VXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVL2VXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:23:54 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:51390 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVL2VXy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:23:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sl1sXSRZ+hZMN9qDp/Y7L5SG3L4C2A/wgiPCQ2aPVIEyA1gH5tciqyBZ+L2/1fHuRWo420ifMGC45/wMcjQOYml4TMSGqcZhMCMlbsLw5qEvsjrdVZjJxfdLb3R1ZaRLE8GWSYcLTHMKo6u4+74lQgYKy2718r08Iq6DdaljoRo=
Message-ID: <5b5833aa0512291323o1fe50d23m5f9fe6dc00f5f876@mail.gmail.com>
Date: Thu, 29 Dec 2005 17:23:52 -0400
From: Anderson Lizardo <anderson.lizardo@gmail.com>
To: Anderson Lizardo <anderson.lizardo@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
In-Reply-To: <20051229200939.GA1113@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213213208.303580000@localhost.localdomain>
	 <439FC4A6.4010900@drzeus.cx>
	 <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
	 <43A11204.2070403@drzeus.cx>
	 <20051215091220.GA29620@flint.arm.linux.org.uk>
	 <43A136F1.3040700@drzeus.cx>
	 <20051215100657.GC32490@flint.arm.linux.org.uk>
	 <20051215134436.GB6211@flint.arm.linux.org.uk>
	 <5b5833aa0512291106m5142acd5pfb12c4831b60e96b@mail.gmail.com>
	 <20051229200939.GA1113@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Dec 29, 2005 at 03:06:15PM -0400, Anderson Lizardo wrote:
> > On 12/15/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > Reading through the specs I have here, block sizes seem to be all over
> > > the place.  The MMC card specs seem to imply that any block size can
> > > be set, from 0 bytes to 2^32-1 bytes.
> > >
> > > The PXA MMC interface specification allows the block size to be anything
> > > from 1 to 1023 bytes, excluding CRC.  It is unclear whether a value of 0
> > > means 1024.
> > >
> > > The MMCI specification allows the block size to be specified as a power
> > > of two, from 1 to 2048 bytes, excluding CRC.
> >
> > By "allows" do you mean we can set the block size to arbitrary values
> > on MMCI too?
>
> No - that's not what I said.  I said "power of two, from 1 to 2048
> bytes excluding CRC."

Ah, so you meant "only allows", sorry for the confusion.

> > The MMC specification v4.1 is clear in one thing: the SET_BLOCKLEN
> > command should be issued prior to the actual LOCK_UNLOCK command with
> > *exactly* the password length + 2 bytes (which contains the operation
> > mode bits and the password length in bytes). The MMC password
> > unlocking (and other password operations, FWIW) doesn't work on the
> > OMAP host if the SET_BLOCKLEN command argument and the block size of
> > the data transfer itself do not match.
>
> Since passwords are limited to a maximum of 16 characters, this means
> that only passwords of length 2, 6, and 14 are possible with MMCI.
> All other passwords are invalid and/or impossible with this host.

What do you suggest in this case? So far the MMCI host seems the only
one (from those supported by mainline tree) that has such limitation.

--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
