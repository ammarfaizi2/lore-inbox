Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTHYTAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTHYTAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:00:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:49091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262105AbTHYTAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:00:02 -0400
Date: Mon, 25 Aug 2003 12:05:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] powering down special devices
In-Reply-To: <1061655739.786.3.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308251201310.1157-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The decision to kill the level parameter came from extensive discussions
> > with Benh, who convinced me that we only need to call ->suspend() once for
> > any device; though we still need to somehow provide for those that need to
> > power down with interrupts disabled. I suggested -EAGAIN, since it allows
> > us to special case those that need it, with the minimum amount of impact.
> > Ben agreed with me.
> 
> Well... I think I told you I don't like much the check on the interrupt
> and tended to prefer either a separate power_down_irq callback or a
> parameter, but that would mean changing prototype for drivers... I
> agreed we can live with your current scheme though. 

How about a flag in the power struct, which would place the device on a 
completely separate list from the beginning. The drivers should know 
whether a device needs special handling a priori, so we don't even need to 
touch it during the first iteration of the lists.

This would eliminate the need to check in the drivers, have no impact on 
the majority of drivers, and allow us to easily determine whether or not 
the device supports runtime power management. 


	Pat


