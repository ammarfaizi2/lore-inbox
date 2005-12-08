Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVLHWrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVLHWrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVLHWrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:47:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:6630 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932686AbVLHWrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:47:40 -0500
Date: Thu, 8 Dec 2005 23:47:35 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Rafael Wysocki <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Discuss x86-64 <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Message-ID: <20051208224735.GV11190@wotan.suse.de>
References: <20051204232153.258cd554.akpm@osdl.org> <200512070146.50221.rjw@sisk.pl> <200512080015.01444.rjw@sisk.pl> <43980058.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43980058.76F0.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:43:52AM +0100, Jan Beulich wrote:
> I don't know how resume normally handles the re-syncing of the wall
> clock, but the problem here is obvious: do_timer runs a loop to
> increment jiffies, which may require significant amounts of time
> (depending how long the system was sleeping).

It would be good if someone could submit a patch to fix
this up properly. It indeed sounds wrong.

The HPET patch seems to be generally unhappy. With it applied
I get lots of obviously wrong softlockup warnings from the
softlockup watchdog thread on a dual NForce4 system. So something
goes wrong with the timing there. The strange thing 
is that the system doesn't even have a HPET table so HPET code shouldn't
be executed - but it goes away when I revert the patch. Very
mysterious.

Also I think vgettimeofday doesn't handle 64bit HPET correctly
yet. Also why does it not use hpet_readq? 

I suspect the 64bit HPET patch needs some more cooking. I think
I will drop it for now.

I would suggest you submit the cleanups in there separately
(without changing semantics yet) 
then it will be easier to test in the future too.

-Andi
