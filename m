Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbVKBVRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbVKBVRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbVKBVRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:17:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:38835 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965244AbVKBVRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:17:20 -0500
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in
	quirks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Mackerras <paulus@samba.org>,
       akpm@osdl.org, David Brownell <david-b@pacbell.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0511010748430.27915@g5.osdl.org>
References: <Pine.LNX.4.44L0.0511011029040.5081-100000@iolanthe.rowland.org>
	 <Pine.LNX.4.64.0511010748430.27915@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 08:13:54 +1100
Message-Id: <1130966034.20136.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But an alternative strategy (which might be very sensible) is to forget 
> about the handoff entirely, and just shut down the bus master flag 
> unconditionally. Just make sure that the eventual driver will reset the 
> controller before it re-enables bus mastering.

Unfortunately, I know quite a few devices (including USB controllers)
that will react badly to the bus master flag being just cleared like
that. By badly, I mean it ranges from simply ignoring it and happily
continuing whatever bus master was being done, to completely screwing up
and crapping all over your memory/bus.

> That would seem to be the simplest possible "handoff". The only danger is 
> that I could imagine that there would be controllers out there that get 
> really confused (ie "I'm not going to play nice any more") if we shut them 
> up that way.

I suspect with the IO/MEM enable test fix we did, it shoul work fine in
practice for all cases. Let's address the "potential" issues if they
happen to show up in real life, which I doubt.

Ben.


