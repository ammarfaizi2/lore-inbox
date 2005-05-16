Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVEPNl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVEPNl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVEPNl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:41:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34376
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261551AbVEPNlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:41:25 -0400
Date: Mon, 16 May 2005 15:41:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050516134114.GH26073@g5.random>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <Pine.LNX.4.62.0505131701450.31431@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505131701450.31431@twinlark.arctic.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 05:39:25PM -0700, dean gaudet wrote:
> same cache index -- and get an 8-fold reduction in exposure.  the trick 
> here is the L2 is physically indexed, and userland code can perform only 
> virtual allocations.  but it's not too hard to discover physical conflicts 
> if you really want to (using rdtsc) -- it would be done early in the 
> initialization of the program because it involves asking for enough memory 
> until the kernel gives you enough colliding pages.  (a system call could 
> help with this if we really wanted it.)

A 8-way set associative 1M cache is guaranteed to go at l2 speed only
up to 128K (no matter what the kernel does), but even if the secret
payload is larger than 128K as long as the load is still distributed
evenly at each pass for each page, there's not going to be any covert
channel, simply the process will run slower than it could if it had a
better page coloring.

So I don't see the need of kernel support, all it needs to do is to know
the page size, and that's provided to userland already.
