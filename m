Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSGYWtE>; Thu, 25 Jul 2002 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGYWtE>; Thu, 25 Jul 2002 18:49:04 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:10635 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S316615AbSGYWtD>; Thu, 25 Jul 2002 18:49:03 -0400
Date: Thu, 25 Jul 2002 15:49:18 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile warnings in suspend.c, 2.5.28
In-Reply-To: <20020725215312.GA489@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0207251501320.18430-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Pavel Machek wrote:

> Does it work for you? I get reboot after S4 on 2.5.28. Can you mail me
> diff between clean and your tree?

Isn't the 'reboot after S4' due to #define TEST_SWSUSP 1?   I set it 
to 0 and it shuts down properly for me.  I'm not sure why rebooting should 
be the default behavior, actually -- it seems a bit strange.

My laptop's at home, but I applied the following patches from:
	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.28/

I applied the 2 rmap-related patches in order, then the remaining patches 
(which are trivial cleanups and compile-fixes) in no special order.  
2.5.28-swsusp is the patch in this thread.  This won't change the "reboot 
after S4" behavior without the additional change to TEST_SWSUSP, above. 

Side note:
The only change to suspend.c that I made which isn't covered by 
the patch in this thread, is the try_to_free_pages() line -- 
but this is specific to the "full rmap-VM for 2.5".  The big rmap patch 
(2.5.28-rmap-1-rmap13b) makes this single alteration.

Second side note:
For the vanilla 2.5 classzone VM, I don't honestly understand why we're 
only looking at &contig_page_data.node_zones[ZONE_HIGHMEM] in
try_to_free_pages().  On the other hand, I don't see how it would break
swsusp.

And a note of appreciation: :)
This was the very first time I tried ACPI and swsusp! I had been using 
APM before, but had no hibernation capability (my BIOS only worked 
properly with suspend to RAM in Linux).  This is really a nice feature!

But now I have to figure out how to teach acpid to do useful stuff, like 
throttle the CPU and try to S4 on lid close and such. :)

Craig Kulesa
Steward Obs.
Univ. of Arizona

