Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTGDCxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbTGDCxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:53:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265661AbTGDCxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:53:41 -0400
Date: Thu, 3 Jul 2003 20:08:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Sipek <jeffpc@optonline.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
In-Reply-To: <200307032231.39842.jeffpc@optonline.net>
Message-ID: <Pine.LNX.4.44.0307032005340.8468-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Jul 2003, Jeff Sipek wrote:
> 
> The variables for network statistics (in struct net_device_stats) are unsigned 
> longs. On 32-bit architectures, this makes them overflow every 4GB or 2^32 
> packets. The following series of patches [against 2.5.74] makes the 
> statistics variable type configurable. The default is to leave everything the 
> way it was (unsigned long). However, when NETSTATS64 is set in the config, 
> the statistics use 64-bit variables (u_int64_t) - this works only on 32-bit 
> architectures.

Please do this in user space. The "overflow every 2^32 packets" thing is 
_not_ a problem, if you just gather the statistics at any kind of 
reasonable interval.

I'd hate to penalise performance for something like this. We have
generally avoided locking _entirely_ for statistics, exactly because
people felt that there are major performance issues wrt network packet
handling, and that "perfect statistics" aren't important enough to
penalize performance over.

Remember: "perfect is the enemy of good". 

		Linus

