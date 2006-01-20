Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWATShY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWATShY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWATShY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:37:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751100AbWATShX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:37:23 -0500
Date: Fri, 20 Jan 2006 19:36:21 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Neil Brown <neilb@suse.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060120183621.GA2799@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17360.9233.215291.380922@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:43:13AM +1100, Neil Brown wrote:
> On Thursday January 19, psusi@cfl.rr.com wrote:
> > Neil Brown wrote:
> > > 
> > > The in-kernel autodetection in md is purely legacy support as far as I
> > > am concerned.  md does volume detection in user space via 'mdadm'.
> > > 
> > > What other "things like" were you thinking of.
> > > 
> > 
> > Oh, I suppose that's true.  Well, another thing is your new mods to 
> > support on the fly reshaping, which dm could do from user space.  Then 
> > of course, there's multipath and snapshots and other lvm things which 
> > you need dm for, so why use both when one will do?  That's my take on it.
> 
> Maybe the problem here is thinking of md and dm as different things.
> Try just not thinking of them at all.  
> Think about it like this:
>   The linux kernel support lvm
>   The linux kernel support multipath
>   The linux kernel support snapshots
>   The linux kernel support raid0
>   The linux kernel support raid1
>   The linux kernel support raid5
> 
> Use the bits that you want, and not the bits that you don't.
> 
> dm and md are just two different interface styles to various bits of
> this.  Neither is clearly better than the other, partly because
> different people have different tastes.
> 
> Maybe what you really want is for all of these functions to be managed
> under the one umbrella application.  I think that is was EVMS tried to
> do. 
> 
> One big selling point that 'dm' has is 'dmraid' - a tool that allows
> you to use a lot of 'fakeraid' cards.  People would like dmraid to
> work with raid5 as well, and that is a good goal.
> However it doesn't mean that dm needs to get it's own raid5
> implementation or that md/raid5 needs to be merged with dm.

That's a valid point to make but it can ;)

> It can be achieved by giving md/raid5 the right interfaces so that
> metadata can be managed from userspace (and I am nearly there).

Yeah, and I'm nearly there to have a RAID4 and RAID5 target for dm
(which took advantage of the raid address calculation and the bio to
stripe cache copy code of md raid5).

See http://people.redhat.com/heinzm/sw/dm/dm-raid45/dm-raid45_2.6.15_200601201914.patch.bz2 (no Makefile / no Kconfig changes) for early code reference.

> Then 'dmraid' (or a similar tool) can use 'dm' interfaces for some
> raid levels and 'md' interfaces for others.

Yes, that's possible but there's recommendations to have a native target
for dm to do RAID5, so I started to implement it.

> 
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
Cluster and Storage Development                   56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
