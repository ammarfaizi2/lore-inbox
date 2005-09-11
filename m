Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVIKTHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVIKTHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIKTHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:07:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbVIKTHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:07:06 -0400
Date: Sun, 11 Sep 2005 12:06:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <20050911185711.GA22556@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> > 
> > Absolutely. The mirroring has been slow again lately. I've packed my 
> > archive, but I suspect others should much more aggressively now be using 
> > the "objects/info/alternates" information to point to my tree, so that 
> > they don't even need to have their objects at all (no packing 
> > even necessary - just running "git prune-packed" on peoples archives 
> > would get rid of any duplicate objects when I pack mine).
> 
> Can you post a small description how to utilize this method?

Just do

	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects > objects/info/alternates

in your tree, and that will tell git that your tree can use my object 
directory as an "alternate" source of objects. At that point, you can 
remove all objects that I have.

However, that only works with a local directory - you can't say that the
alternate object directory is over the network (unless you use NFS or
similar, of course ;).

Another potential problem is that while the above makes git understand to
pick the objects from my directory, it can in theory cause problems for
mirrors etc - since they mirror things to a different location and/or may
not mirror all of it anyway.

Anyway, modulo those caveats, you can then just do

	git prune-packed

and it will remove all unpacked objects in your git archive that can be 
reached through a pack-file - including any packfiles in _my_ directory. 

Then you never need to pack your own objects any more. Just leave
everything unpacked, and rely on me packing every once in a while, and
just do "git prune-packed" when I do.

That allows a site like kernel.org to effectively share 99% of all 
objects, and do it efficiently.

		Linus
