Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUG3UEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUG3UEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267813AbUG3UEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:04:07 -0400
Received: from web14922.mail.yahoo.com ([216.136.225.6]:35454 "HELO
	web14922.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267810AbUG3UEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:04:00 -0400
Message-ID: <20040730200359.80825.qmail@web14922.mail.yahoo.com>
Date: Fri, 30 Jul 2004 13:03:59 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040730194634.GA4851@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From what I know minimal decoder cards are ancient PCI cards. None of
the current hardware does this.

Caching would only occur:
1) when a kernel driver for the card loads
2) and if the kernel driver asks for it

So normal hardware would never ask for the cache since it isn't needed.
In the normal hardware case direct ROM access is used. If the
minimalistic hardware is using a user space driver it won't ask for the
cache either. The only time you get cached is on minimal hardware and
when the driver asks for it. Since the driver is asking for the cache
you have to assume that it needs it so the memory isn't wasted.

--- Martin Mares <mj@ucw.cz> wrote:

> Hello!
> 
> > The caching is only going to happen for cards with minimal address
> > decoder implementations. As far as I know there is only one card
> that
> > does this.
> 
> Yes, but ...
> 
> (1) it doesn't change the fact that the caching is in the vast
> majority
> of cases just wasting of RAM, even if it will happen only with a
> couple
> of cards.
> 
> (2) not all drivers dwell in the kernel.
> 
> I would prefer keeping sysfs access the ROM directly, with a little
> work-around disabling the sysfs file for the devices known for
> sharing
> decoders and to offer a boot-time parameter for forcing the copy in
> case
> you really need such feature for that particular device.
> 
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares   <mj@ucw.cz>  
> http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep.,
> Earth
> return(EIEIO); /* Here-a-bug, There-a-bug... */
> 

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
