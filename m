Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313645AbSDURXo>; Sun, 21 Apr 2002 13:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313653AbSDURXn>; Sun, 21 Apr 2002 13:23:43 -0400
Received: from bitmover.com ([192.132.92.2]:6555 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313645AbSDURXm>;
	Sun, 21 Apr 2002 13:23:42 -0400
Date: Sun, 21 Apr 2002 10:23:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421102339.E10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IOW, I propose to create a "linuspush" script that replaces his current
> "bk push" command.  Linus pushes batches of csets out at a time,
> make these cset batches the pre-patches...

This is easily doable as a trigger.  I'm pretty sure that all you want
is

	cat > BitKeeper/triggers/pre-incoming.diffs
	#!/bin/sh
	bk prs -hr+ -nd:KEY: ChangeSet > BitKeeper/log/save_key
	^D

	cat > BitKeeper/triggers/post-incoming.diffs
	#!/bin/sh
	
	i=0
	while test -f BitKeeper/tmp/diffs-$i
	do	i=`expr $i + 1`
	done
	bk diffs -C`cat BitKeeper/log/save_key` > BitKeeper/tmp/diffs-$i
	^D

	chmod +x BitKeeper/triggers/*incoming.diffs

The only reason I don't do this on bkbits.net is that regular style patches
eat a lot more bandwidth than BK patches and we can't afford to offer up
the bandwidth for free. 
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
