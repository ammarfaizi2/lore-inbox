Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTDXJID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTDXJID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:08:03 -0400
Received: from pop.gmx.de ([213.165.65.60]:57496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262186AbTDXJHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:07:35 -0400
Message-ID: <3EA7AC28.8090402@gmx.net>
Date: Thu, 24 Apr 2003 11:19:36 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Christoph Hellwig <hch@infradead.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com> <b7n46e$dtb$1@cesium.transmeta.com> <20030420003021.GA10547@work.bitmover.com> <16035.30645.648954.185797@notabene.cse.unsw.edu.au> <3EA6B61B.7030303@gmx.net> <20030424024549.GA10840@work.bitmover.com>
In-Reply-To: <20030424024549.GA10840@work.bitmover.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Wed, Apr 23, 2003 at 05:49:47PM +0200, Carl-Daniel Hailfinger wrote:
> 
> Fast or safe, pick one.  CVS has no integrity check and you will never know

I picked bitkeeper because it is convenient, easy to use, has a
distributed structure and keeps revision history locally.

> [description of feats achieved by integrity checking snipped]
> 
> The BK integrity check will tell you right away if any of your data is bad.

Every once in a while (cron job at night), I do a
bk -r check -ac
According to the man page, that should cover me nicely. Files which
change during a bk pull are checked anyway, so the only possible
corruption remaining undetected for a few hours is corruption in files
which were not modified at all. I just don't see the BIG benefit in
knowing a few hours earlier that an unused file is corrupted.

If corruption does not affect your working set, it is nice to know about
(to get rid of the offending hardware), but it will not harm you
directly. Checking readonly files is a job for cron because it is highly
unlikely that corruption of your on-disk data will happen on read. I'ts
either already corrupt on the platter or not (cabling/RAM etc. issues
aside), READING a sector from disk should NEVER change the contents of
this sector. If it does, you have a much bigger problem.

> *Everyone* hates the check until it saves their butt and then they decide
> it's not such a bad idea.  It's a lot like a seatbelt - you don't like it
> until something goes wrong.

You should introduce periodic checks, then. Data corruption is not a
function of the read count of a specific sector, but of the write count
and/or time. Feel free to point me to contrary evidence, I'm always
willing to learn.

> BK != CVS.  You want fast and loose, by all means, use CVS, that's not our
> intended market and we don't care about fast where fast means bad data.
> 
> 
>>P.S. If anyone knows other speedup tricks for a kernel tree in bk,
>>please tell me.
> 
> 
> Mount the file system with noatime.

Did that already. But thanks for the suggestion anyway.

> Buy enough memory to fit the kernel in memory and on a 1Ghz processor that
> pull will take about 20 seconds.  Even laptop memory is pretty cheap these
> days.  Pricewatch says $80 for .5GB for laptops, that's cheap.

With a upper maximum of 192MB in my laptop (the chipset won't accept
more), I have no choice but to buy a new one or enable partial checks. I
even use ext2 instead of reiser/ext3 on my notebook to save RAM. The
only thing running during a bk pull is XFree86 and fvwm2 as windowmanager.

Unfortunately, I was unable to find a good laptop in the 80$ range;
heck, I would even consider a good used laptop in the 300$ range. And
before you ask: as an university student, I think twice before shelling
out money for a new machine. Maybe that will change if I have gobs of
money available.

Don't understand me wrong, bitkeeper is a tool which has saved me hours
of merging and debugging mismerges, but I'd perefer not to use xiafs
instead of ext2 just to save a couple more kB of RAM to speed up bk.

Regards,
Carl-Daniel

-- 
Carl-Daniel Hailfinger
Xiafs maintainer
More about Xiafs soon at
http://www.hailfinger.org/

