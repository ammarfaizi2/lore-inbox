Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264701AbSIWB5E>; Sun, 22 Sep 2002 21:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264703AbSIWB5E>; Sun, 22 Sep 2002 21:57:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264701AbSIWB5C>;
	Sun, 22 Sep 2002 21:57:02 -0400
Message-ID: <3D8E7603.5060106@mandrakesoft.com>
Date: Sun, 22 Sep 2002 22:01:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org, dev@bitmover.com
Subject: Re: boring BK stats
References: <200209222356.g8MNu4V10172@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I should be working on getting the bk-3.0 release done but I'm sick of
> fixing BK-on-windows bugs...
> 
> Linus' kernel tree has 13333 revision controlled files in it.  Without
> repository compression, it eats up 280M in an ext2 fs.  With repository
> compression, that drops to 129M.  After checking out all the files, the
> size of the revision history and the checked out files is 317MB when
> the revision history is compressed.  That means the tree without the
> history is 188MB, we get the revision history in less space than the
> checked out tree.  That's pretty cool, by the way, I know of no other
> SCM system which can say that.
> 
> Checking out the tree takes 16 seconds.  Doing an integrity check takes 10
> seconds if the repository is uncompressed, 15 seconds if it is compressed.
> That's on 1.3Ghz Athlon w/ PC133 memory running at the slower CAS rate,
> but lots of it, around 900MB.


If you can't fit a whole tree including metadata into RAM, though, BK 
crawls...   Going from "bk citool" at the command line to actually 
seeing the citool window approaches five minutes of runtime, on this 
200MB laptop...  [my dual athlon with 512MB RAM corroborates your 
numbers, though]  "bk -r co -Sq" takes a similar amount of time...

I also find that BK brings out the worst in the 2.4 kernel 
elevator/VM...  mouse clicks in Mozilla take upwards of 10 seconds to 
respond, when "bk -r co -Sq" is running on this laptop [any other 
read-from-disk process behaves similarly].  And running any two BK jobs 
at the same time is a huge mistake.  Two "bk -r co -Sq" runs easily take 
four or more times longer than a single run.  Ditto for consistency 
checks, or any other disk-intensive activity BK indulges in.

Next time I get super-annoyed at BK on this laptop, I'm gonna look into 
beating the disk scheduler into submission...  some starvation is 
clearly occurring.

</rant>

	Jeff



