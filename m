Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUH1LIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUH1LIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 07:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUH1LIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 07:08:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19370 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266003AbUH1LID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 07:08:03 -0400
Message-ID: <41306876.70901@namesys.com>
Date: Sat, 28 Aug 2004 14:11:50 +0300
From: Yury Umanets <umka@namesys.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hans Reiser <reiser@namesys.com>, Christophe Saout <christophe@saout.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com> <20040826112818.GL5618@nocona.random>
In-Reply-To: <20040826112818.GL5618@nocona.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Thu, Aug 26, 2004 at 01:35:01AM -0700, Hans Reiser wrote:
>  
>
>>Reiser4 plugins are not for end users to download from amazon.com, they 
>>are for weekend hackers to send me a cool plugin for me to review, 
>>assign a plugin id to, and send to Linus in the next release.  Sometimes 
>>    
>>
>
>then what's the difference in having the plugin fixed in stone into
>reiserfs? That's my whole point. Get the patch from the weekend hacker,
>check it, send the patch to Linus to add the new feature to reiser4,
>just call it "feature" not plugin. That's how it works normally for
>everything. Many fs have many features, many of them optional.  you
>wouldn't need to build any hook infrastructure either that way. Hooks
>would be needed if this wasn't open source me thinks. Or if you want
>people to fetch the module from amazon without your review.
>
>Another reason I could see the modularization/hooking useful is if those
>feature would take lots of kernel space, but this sure isn't the case
>for reiserfs, infact having modules would waste _more_ ram due the half
>wasted page allocation for the module text. The only single reason we
>use modules is to avoid wasting tons of ram by loading every possible
>device driver on earth, it's not that we use modules because they're
>more flexible, if something they're more fragile. I never use modules in
>my test kernel just to go fast (because I self compile them). The last
>good thing of the modules is during development you don't need to reboot
>the machine to test a kernel change in a driver, but you don't need that
>with reiserfs since you can make the fs itself a module (just change the
>name of the fs, AFIK you do that all the time already).
>  
>
There lots of good things about plugins as they are in reiser4. And
probably the best one (as for me) is that, reiser4 core code (quite
complex thing) does not need to be changed after adding new plugins
(read new features).

It is written once and provides some basic functionality (balancing,
atoms, etc.), which works well with all kinds of plugins if they
implement required functions from plugin interface.

As for me, this looks like Linux's VFS. Sure, if I want to add some very
new filesystem with features which were not foreseen,  and VFS does not
provide needed interface, it will need some changes. But in simple case,
when I just want to develop once more disk filesystem, which say will be
different from another disk filesystem in only that respect it manages
its metadata in different manner and aims to achieve better performance
this way. In this case I will not need to chnage VFS at all. The same
about reiser4 core and new plugins.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
umka



