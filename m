Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVKJO5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVKJO5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVKJO5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:57:04 -0500
Received: from rtr.ca ([64.26.128.89]:31390 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750973AbVKJO5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:57:03 -0500
Message-ID: <43735FC8.2090101@rtr.ca>
Date: Thu, 10 Nov 2005 09:57:12 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
References: <20051103220305.77620d8f.akpm@osdl.org>	 <20051104071932.GA6362@kroah.com>	 <1131117293.26925.46.camel@localhost.localdomain>	 <20051104163755.GB13420@kroah.com> <1131531428.8506.24.camel@localhost.localdomain>
In-Reply-To: <1131531428.8506.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
>
> - *	FIXME: This treatment is probably applicable for *all* PCMCIA (PC CARD)
> - *	devices, so in linux 2.3.x we should change this to just treat all
> - *	PCMCIA  drives this way, and get rid of the model-name tests below
> - *	(too big of an interface change for 2.4.x).
> - *	At that time, we might also consider parameterizing the timeouts and
> - *	retries, since these are MUCH faster than mechanical drives. -M.Lord
> - */

I believe the latter half of those comments (timeouts) should
be left in the IDE layer (somewhere), as a note to current/future
maintainers about something that does need fixing eventually.

Something like this:

/*
  * FIXME:  Someday we ought to parameterize IDE timeouts to use
  * much smaller values when dealing with flash memory cards.
  * For example, these devices never require more than a second
  * (much less, actually) for "spin-up", compared with a limit
  * of 31 seconds for mechanical ATA drives.  This would speed up
  * error recovery for these popular devices, especially in embedded work
  */

Cheers
-M.Lord
