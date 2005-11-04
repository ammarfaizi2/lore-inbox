Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVKDV1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVKDV1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVKDV1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:27:54 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:665 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750921AbVKDV1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:27:53 -0500
Date: Fri, 4 Nov 2005 22:27:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, aherrman@de.ibm.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104212742.GC9222@osiris.ibm.com>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com> <20051104084829.714c5dbb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104084829.714c5dbb.akpm@osdl.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > See original stack back trace below and Andreas' patch and analysis
> > here:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html

I probably should add that with "original" stack back trace a trace of
a 2.6.10 kernel was meant, if that wasn't clear, but the DM code is
still the same in 2.6.14.

> >     <4>Call Trace:
...
> >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
...

This part of the call trace is actually good for >1500 bytes of stack
usage and is what kills us and should be fixed.
I'm surprised that there are no other bug reports regarding DM and
stack overflow with 4k stacks.
 
> I'd call that a device mapper bug.  If you were to increase the stacking
> from 4-deep to 5-deep, it will crash the kernel, patched or not.

Yes, you're right. Just forget the do_mount() patch. It's the wrong approach.

Heiko
