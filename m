Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVKDXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVKDXzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVKDXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:55:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7442 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750981AbVKDXzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:55:03 -0500
Date: Sat, 5 Nov 2005 00:55:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
Message-ID: <20051104235500.GE5368@stusta.de>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com> <20051104084829.714c5dbb.akpm@osdl.org> <20051104212742.GC9222@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104212742.GC9222@osiris.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 10:27:42PM +0100, Heiko Carstens wrote:
> > > See original stack back trace below and Andreas' patch and analysis
> > > here:
> > > http://www.ussg.iu.edu/hypermail/linux/kernel/0410.3/1844.html
> 
> I probably should add that with "original" stack back trace a trace of
> a 2.6.10 kernel was meant, if that wasn't clear, but the DM code is
> still the same in 2.6.14.
> 
> > >     <4>Call Trace:
> ...
> > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> > >     <4> [<0000000010831380>] __map_bio+0x70/0x160 [dm_mod]
> > >     <4> [<000000001083173e>] __split_bio+0x1e6/0x538 [dm_mod]
> > >     <4> [<0000000010831ba8>] dm_request+0x118/0x25c [dm_mod]
> > >     <4> [<0000000000241074>] generic_make_request+0xf0/0x21c
> ...
> 
> This part of the call trace is actually good for >1500 bytes of stack
> usage and is what kills us and should be fixed.
> I'm surprised that there are no other bug reports regarding DM and
> stack overflow with 4k stacks.
>...

There were some reports of dm+xfs overflows with 4k stacks on i386.

The xfs side was sorted out, but I son't know the state of the dm part.

> Heiko

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

