Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWFIRai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWFIRai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWFIRah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:30:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030323AbWFIRag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:30:36 -0400
Date: Fri, 9 Jun 2006 10:30:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <m3y7w69s6v.fsf@bzzz.home.net>
Message-ID: <Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <m3y7w69s6v.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Alex Tomas wrote:
> 
> oops :) I don't follow that well ... 
> 
> size of in-core inodes is a different problem.

Not really. It's really the same problem: adding features has a real cost.

And the cost is higher if you don't add them in a way that is statically 
separable.

So I'm not trying to make the in-core inode size be "the thing" to 
concentrate on. And I'm not saying that extents is inherently "the thing" 
that makes it sane to split up development. That time might have been a 
few years ago, or it might be in the future.

So don't get me wrong. I'm (a) generally supporting Jeff in that I think 
it makes sense to split projects off occasionally, and maybe even plan on 
hopefully make the original project be deleted in the long run (it does 
actually happen, although it is fairly rare). And (b) trying to show the 
costs.

For me, the biggest cost tends to actually be support. A stable filesystem 
that is used by thousands and thousands of people and that isn't actually 
developed outside of just maintaining it IS A REALLY GOOD THING TO HAVE. 

And I'm not saying that just because it's a filesystem, and people get 
upset if they lose data. No, I'm saying it because from a maintenance 
standpoint, such a filesystem has almost zero cost.

So from a maintenance stanpoint, it's actually a _lot_ more useful to me 
(and probably to a lot of other people) if development is done as its own 
project, and is merged as its own sub-project. When problems happen, it's 
fairly obvious what they are, and it's very much a case of all the people 
involved having made that choice ("Hey, you knew it wasn't as stable, but 
you wanted it for your special needs").

As an additional bonus, it tends to help find patterns in bug-reports 
("ahh, everyone involved is running ext4"). So not only does it not affect 
people who don't want to be affected, it also helps _pinpoint_ where 
problems are when they do happen.

Also, if it turns out that the stabilization thing worked well, and after 
a few years the _new_ code hasn't gotten any changes, and there are no 
other real downsides either, they can actually be merged later on too. 

That's what we're seeing in the 64-bit architecture support on both s390 
and powerpc (and maybe even x86, eventually? Possibly not, but who 
knows..). But that's a separate issue.

			Linus
