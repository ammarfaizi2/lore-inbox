Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUIBFxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUIBFxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 01:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUIBFxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 01:53:45 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33730 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267350AbUIBFxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:53:37 -0400
Message-ID: <4136B55E.9080906@namesys.com>
Date: Wed, 01 Sep 2004 22:53:34 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 1 Sep 2004, David Masover wrote:
>  
>
>>And that is the right solution.  Not the only one, but the right one.
>>Caching isn't the only thing sorely in need of transaction support right
>>now.  Actually, I find it hard to think of anything on Linux which
>>shouldn't have transactions -- why should /etc/fstab or
>>/home/david/homework be more fragile than /var/lib/mysql?
>>    
>>
>
>It's easy to talk big. 
>
>It's damn hard to _implement_ a complex system, and make it stable and 
>bug-free, and support legacy applications.
>
>There is a reason why we do only what _must_ be done in kernel space.
>
>		Linus
>
>
>  
>
Filesystems need transactions. Given that they need it, it was very 
tempting to build an infrastructure offering some of the functionality 
to user space, and so we did in reiser4. What we have is very 
rudimentary, but I think I am prepared to say that important aspects of 
high performance transactions are better done in the kernel than in user 
space. It will be interesting to see what aspects of transaction 
functionality belong in user space as our transactions API comes into 
existence. Clearly there are some things about isolation that are better 
implemented by user space because user space can make optimizations the 
kernel doesn't know enough to make. Still, it will be interesting to see 
how low we can make the overhead of isolation. Right now reiser4 
supports atomicity but not isolation, which is to say we offer to 
guarantee that a set of operations will either all survive a crash or 
none of them will, but we don't let you roll them back without a crash. 
(Originally I called this a transcrash rather than atomicity, but nobody 
liked the term.) Being modest in our ambition was important to 
performance, but maybe in time we will find a high performance way to be 
more ambitious.
