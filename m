Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWFJTpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWFJTpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWFJTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:45:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030503AbWFJTpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:45:08 -0400
Date: Sat, 10 Jun 2006 12:44:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Jeff Garzik <jeff@garzik.org>, Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com>
Message-ID: <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org>
 <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jun 2006, Kyle Moffett wrote:
> 
> Why not: "extX_ops.do_something_useful();", then have fs/ext/ext{2,3,4}_ops.c

I think that kind of setup is hugely preferable to conditionals in the 
code, if only because it tends to force people to do the abstractions 
right, and make the code sequences independent.

I just don't think it's necessarily very realistic - it's _hard_ to 
refactor code well. It also doesn't buy you hardly anything at all, since 
the people who are interested in ext2 are usually not very interested in 
sharing code with ext3. The filesystems simply aren't that similar, apart 
from the layout. 

ext2 is half the size of ext3, and that's ignoring JBD entirely.

That constant growth, btw, is one reason why splitting off legacy 
filesystems is often a good idea. What do you want to bet that the 2000+ 
line difference RIGHT NOW in ext3/ext4 will grow in the future? Splitting 
things off means that people who don't care about the new features can 
just stay with a stable base and also avoid the bloat. Exactly the way you 
can stay with ext2 on an old machine, and avoid the bloat of ext3.

There's also nothign that says that legacy filesystems cannot be 
simplified. For example, it's perfectly realistic to say that ext3 (as a 
legacy filesystem) doesn't support resizing, and simply ripping that part 
out of it. The people who don't want the bloat will be happy. The people 
who want the feature can move to ext4.

See? Splitting development is what allows you to make choices that you 
simply otherwise don't _have_. 

			Linus
