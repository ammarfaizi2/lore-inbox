Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314346AbSDRNOH>; Thu, 18 Apr 2002 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314347AbSDRNOG>; Thu, 18 Apr 2002 09:14:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55049 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314346AbSDRNOD>;
	Thu, 18 Apr 2002 09:14:03 -0400
Date: Thu, 18 Apr 2002 15:12:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020418131248.GI2492@suse.de>
In-Reply-To: <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418125757.GF2492@suse.de> <3CBEB51F.90105@evision-ventures.com> <20020418130743.GH2492@suse.de> <3CBEB754.6010205@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >On Thu, Apr 18 2002, Martin Dalecki wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Thu, Apr 18 2002, Martin Dalecki wrote:
> >>>
> >>>
> >>>>BTW>  Jens: Do you have any idea what the "sector chaing" in ide-cd is
> >>>>good for?! I would love to just get rid of it alltogether!
> >>>
> >>>
> >>>Sector chaining? Are you talking about the cdrom_read_intr() comments?
> >>
> >>Sorry I did mean sector caching.
> >
> >
> >That's for padding/caching sub-frame sized reads.
> 
> I tought the BIO layer did this alredy... Well it's a pain

Nope, it does not.

> in the a** to deal with it. IDE-FLOPPY is passing packet commands

It sure is... sr doesn't do it and lots of others don't as well, so I
suppose we could rip it out. We already require reblocking with loop in
those cases anyway.

> through the request buffer but IDE-CD is passing them through
> request special field... argh!

So kill ->special usage in ide-cd and use ->buffer?

-- 
Jens Axboe

