Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTH2QUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTH2QUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:20:52 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:18856 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261449AbTH2QUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:20:44 -0400
Message-ID: <3F4F7D56.9040107@wmich.edu>
Date: Fri, 29 Aug 2003 12:20:38 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu> <m3r834phqi.fsf@bzzz.home.net>
In-Reply-To: <m3r834phqi.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>>Ed Sweetman (ES) writes:
> 
> 
>  ES> in the kernels that would boot (for some reason test4's videodev
>  ES> driver is borked so i used the mm patchset) passed the serio drivers,
>  ES> init was unable to be found, no matter what even though it mounted the
>  ES> root fs and the root fs is not as far as i can tell when booting on
>  ES> older kernels, corrupted.   I'm writing now in mozilla from the very
>  ES> system but with extents turned off.  I'm somewhat afraid though that
>  ES> even though i didn't mount the partitions with the extents option,
>  ES> that the patch may still be having an adverse effect.  Right now
>  ES> things seem pretty stable but last night apt was hanging while
>  ES> generating locales reproducably causing the entire kernel to lose the
>  ES> ability to do anything to the fs. This was all being tested on
>  ES> test3-mm1.  I am aware that mm does have some patches to ext3 that
>  ES> aren't in the main kernel i believe. perhaps the xattr stuff is
>  ES> conflicting in some way?  I really have no way of testing the linus
>  ES> tree directly because the drivers i use wont compile.
> 
> first of all, once fs gets mounted with extents support any newly created
> files/dirs will be stored in extents-format. thus, if you remount that fs
> w/o extents support you won't be able to access those files/dirs

> I really propose you don't use extents on a partitions you care about for a while.

I was testing this with only a single partition mounted with extents 
enabled when benchmarking.  Ext3 gave no messages of being mounted 
afterbootup with or without extents so to make sure i had extents 
enabled i booted with all my partitions with the extents option.  I 
suspect then my problems began.  I'm completely unaware of the extent of 
the damage enabling extents has done since most of the important things 
were opened, not created during my extents use.  In any case it may be 
that the reason why init is not able to be found is because i used apt 
and upgraded my system ...and I dont remember if i had extents enabled 
at the time or not.  If my init is in extents format though, then why is 
a patched kernel able to read it with extents not being enabled via the 
omunt option where as kernels without the patch cannot.  Is extents able 
to be read from a fs even when it's not mounted with the option but not 
written?   I'm kinda confused, this aspect of extents wasn't in the 
original email.

>  ES> All in all though, when it was enabled, i saw really no difference
>  ES> from when it was not enabled. dbench 16 gave me ~140MB/sec either
>  ES> way. md5summing large files resulted in equal performance as well.  I
>  ES> got nothing even close to the kind of performance increases you showed
>  ES> in the first mail.
> 
> quite interesting result. could you help me to investigate that?
> it would be great to go through following steps:
> 1) create fresh ext3 fs
> 2) mount it w/o extents option
> 3) run dbench 16 for few times (say, 4)
>    make sure it performs on that filesystem (cd <mntpoint>; dbench -c ... 16)
> 4) unmount fs
> 5) recreate that fs
> 6) mount it with extents option
>    'EXT3-fs: file extents enabled' should be printed in logs
> 7) run dbench 16 for few times
> 8) unmount that fs and take a look in logs, you should see stats info about
>    extents usage
> 
> thank you!

i'm going to try and boot a kernel without the extents patch (so far 
hasn't been possible) and run dbench again and see if i get different 
numbers.  I'm almost suspecting extents being enabled no matter what i 
mount the fs's as.



