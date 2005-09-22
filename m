Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVIVOgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVIVOgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVIVOgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:36:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63502 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030379AbVIVOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:36:41 -0400
Date: Thu, 22 Sep 2005 15:36:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>,
       LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
Subject: Re: [RFC/BUG?] ide_cs's removable status
Message-ID: <20050922143635.GD26438@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>,
	LKML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain> <20050921192932.GB13246@flint.arm.linux.org.uk> <1127347845.18840.53.camel@localhost.localdomain> <20050922102221.GD16949@flint.arm.linux.org.uk> <1127396382.18840.79.camel@localhost.localdomain> <1127398876.8242.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127398876.8242.74.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:21:16PM +0100, Richard Purdie wrote:
> 3. ide-cs sometimes can't/doesn't detect the removal of an ide
> controller.

This is the one I'm particularly interested in, and I think it's
responsible for a lot of problems in this area.

"can't" is correct - from what I now understand from Alan, it seems
that there are PCMCIA to CF adapters out there which tie the PCMCIA
card detect lines to ground, rather than passing them through to the
CF socket.

This means that if you leave the PCMCIA to CF adapter in the slot,
pull out the CF card, replace it with another CF card, PCMCIA will
not notice the change.

You could even plug this adapter into the slot with a CF IDE card in,
unplug the CF IDE card and replace it with a CF network card.  Then
watch the fun and games when IDE tries to access the CF network card!

Therefore, it's completely unsafe to assume anything about what's
plugged in with such a broken adapter... the only way you could be
sure is to regularly check the CIS matches the PCMCIA cached version,
provided you have enough of the CIS cached.

I think this basically comes down to a buggy CF adapter which needs
bining.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
