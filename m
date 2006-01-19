Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWASJBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWASJBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWASJBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:01:16 -0500
Received: from unthought.net ([212.97.129.88]:41733 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1161289AbWASJBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:01:15 -0500
Date: Thu, 19 Jan 2006 10:01:14 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Neil Brown <neilb@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Ross Vandegrift <ross@jose.lug.udel.edu>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060119090114.GF2729@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Neil Brown <neilb@suse.de>, Michael Tokarev <mjt@tls.msk.ru>,
	Ross Vandegrift <ross@lug.udel.edu>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru> <20060117160829.GA16606@lug.udel.edu> <43CD3388.9050107@tls.msk.ru> <17358.56263.806371.53617@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17358.56263.806371.53617@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 11:22:31AM +1100, Neil Brown wrote:
...
> Compare this to an offline solution (raidreconfig) where all the code
> is only used occasionally.  You could argue that the online version
> has more code safety than the offline version....

Correct.

raidreconf, however, can convert a 2 disk RAID-0 to a 4 disk RAID-5 for
example - the whole design of raidreconf is fundamentally different (of
course) from the on-line reshape.  The on-line reshape can be (and
should be) much simpler.

Now, back when I wrote raidreconf, my thoughts were that md would be
merged into dm, and that raidreconf should evolve into something like
'pvmove' - a user-space tool that moves blocks around, interfacing with
the kernel as much as strictly necessary, allowing hot reconfiguration
of RAID setups.

That was the idea.

Reality, however, seems to be that MD is not moving quickly into DM (for
whatever reasons). Also, I haven't had the time to actually just move on
this myself. Today, raidreconf is used by some, but it is not
maintained, and it is often too slow for comfortable off-line usage
(reconfiguration of TB sized arrays is slow - not so much because of
raidreconf, but because there simply is a lot of data that needs to be
moved around).

I still think that putting MD into DM and extending pvmove to include
raidreconf functionality, would be the way to go. The final solution
should also be tolerant (like pvmove is today) of power cycles during
reconfiguration - the operation should be re-startable.

Anyway - this is just me dreaming - I don't have time to do this and it
seems that currently noone else has either.

Great initiative with the reshape Neil - hot reconfiguration is much
needed - personally I still hope to see MD move into DM and pvmove
including raidreconf functionality, but I guess that when we're eating
an elephant we should be satisfied with taking one bite at a time  :)

-- 

 / jakob

