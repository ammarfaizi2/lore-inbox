Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131420AbRCUN5b>; Wed, 21 Mar 2001 08:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRCUN5L>; Wed, 21 Mar 2001 08:57:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7632 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131420AbRCUN5H>;
	Wed, 21 Mar 2001 08:57:07 -0500
Date: Wed, 21 Mar 2001 08:56:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP-scalability patch [was: spinlock usage]
In-Reply-To: <Pine.LNX.4.30.0103211356420.6061-100000@elte.hu>
Message-ID: <Pine.GSO.4.21.0103210847500.739-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, Ingo Molnar wrote:

> 
> On Wed, 21 Mar 2001, Alexander Viro wrote:
> 
> > > (about lstat(): IMO lstat() should not call into the lowlevel FS code.)
> >
> > a) revalidation on network filesystems
> > b) just about anything layered would win from ability to replace the
> > normal stat() behaviour (think of UI/GID replacement, etc.)
> 
> sorry, i meant ext2fs - but this was fixed by your VFS scalability changes
> already :-)

???
<checking 2.2.0>
Nope, no calls into ext2/*. do_revalidate() seeing NULL ->i_revalidate
and doing nothing, lnamei() doing usual lookup, cp_old_stat() not touching
fs code at all...

The only change was s/lnamei()/user_path_walk_link()/ and they are
equivalent, modulo different API (filling nameidata vs. returning
dentry).
							Cheers,
								Al

