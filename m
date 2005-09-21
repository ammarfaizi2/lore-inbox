Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVIUSqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVIUSqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVIUSqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:46:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:26056 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750797AbVIUSqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:46:42 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Richard Purdie <rpurdie@rpsys.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <1127327243.18840.34.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 19:46:25 +0100
Message-Id: <1127328385.20660.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-21 at 19:27 +0100, Alan Cox wrote:
> On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> > In the case of CF cards in ide-cs, removing the card is equivalent
> > to removing the entire IDE controller, not just the media.
> 
> It isn't the same as removing the entire PCMCIA controller layer. As far
> as PCMCIA is concerned there has been no change. Thus we have no media
> change event and we need ->removable = 1

CF slots have card detection and ide-cs will see a card removal event.
Have a look at ide_event() in ide-cs.c: CS_EVENT_CARD_INSERTION and
CS_EVENT_CARD_REMOVAL are what they say...

> If the PCMCIA card disappeared each time it would be different

Just the card disappears.

This along with your comments about the IDE layer having no hotplug
support suggest the code in question can be removed pending a better
replacement when hotplug is implemented.

Richard

