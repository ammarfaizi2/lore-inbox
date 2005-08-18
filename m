Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVHRUlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVHRUlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVHRUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:41:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45021 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932421AbVHRUlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:41:09 -0400
Date: Thu, 18 Aug 2005 22:19:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-ID: <20050818201919.GD516@openzaurus.ucw.cz>
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx> <20050818092321.B3966@flint.arm.linux.org.uk> <43044B7A.6090102@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43044B7A.6090102@drzeus.cx>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>We had this discussion on LKML and Alan Cox' comment on it was that a
> >>solution like this would be acceptable, where we try and shove
> >>everything out first and then fall back on sector-by-sector to determine
> >>where an error occurs. This will only break if the problematic sector
> >>keeps shifting around, but at that point the card is probably toast
> >>anyway (if the thing keeps moving how can you bad block it?).
> >>    
> >>
> >
> >There are two different kinds of error - the ones at the transport
> >level which we are able to force a result of "no sectors transferred"
> >for.  For all other errors and successful completions, the driver
> >reports "all sectors tranferred" since the driver level doesn't know
> >that an error occurred.
> >
> >This causes us to tell the upper levels that we were successful,
> >even if we weren't.  Hence the problem.
> >
> >  
> >
> 
> I still don't understand where you see the problem. As you said there
> are two problems that can occur:
> 
> * Transport problem. The driver will report back a CRC error, timeout or
> whatnot and break. We might not know how many sectors survived so we try
> again, going sector-by-sector. We might get a transfer error again,
> possibly even before the previous one. But at this point the transport
> is probably so noisy that we have little chans of doing a clean umount
> anyway. So when the device gets fixed, either by replaying the journal

Well, but then you can get:

good data #1
trash #2
good data #2
trash #1

I'm not sure how much journalling filesystems will like that in their journals...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

