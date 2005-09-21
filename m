Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVIUT3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVIUT3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVIUT3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:29:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751395AbVIUT3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:29:41 -0400
Date: Wed, 21 Sep 2005 20:29:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
Message-ID: <20050921192932.GB13246@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127327243.18840.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:27:23PM +0100, Alan Cox wrote:
> On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> > In the case of CF cards in ide-cs, removing the card is equivalent
> > to removing the entire IDE controller, not just the media.
> 
> It isn't the same as removing the entire PCMCIA controller layer. As far
> as PCMCIA is concerned there has been no change. Thus we have no media
> change event and we need ->removable = 1
> 
> If the PCMCIA card disappeared each time it would be different

Last time I checked, with CF cards the media was an inherent part of
the CF card and is not changable without removing the card, opening
it, getting out the soldering iron... or alternatively plugging in
a different CF card.

Of course, PCMCIA will detect removal of the CF card provided the
PCMCIA hardware is working.  PCMCIA will also detect a CF card which
has been changed while the system has been suspended _provided_ the
CIS does not match the previous cards CIS.  It'll even do this if
you use cardctl suspend/cardctl resume.

However, if you suspend your system, remove your CF card, put it in
a different machine, use it (note: by doing this it could _already_
be in an inconsistent state), and put it back in the original machine
before resuming it, the cache on the original machine will disagree
with what is on the card.  But then you have done something silly
already by taking media in an inconsistent state to another machine
- and modified that inconsistent filesystem state.

It sounds like you know of a case where this isn't true - maybe a bug
report.  Can you expand on it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
