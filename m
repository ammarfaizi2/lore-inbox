Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUH1J6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUH1J6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUH1J5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:57:15 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43471 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267435AbUH1Jx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:53:28 -0400
Message-ID: <41305619.9030401@namesys.com>
Date: Sat, 28 Aug 2004 02:53:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com, Alexander Zarochentcev <zam@namesys.com>
Subject: Re: reiser4 plugins
References: <20040825152805.45a1ce64.akpm@osdl.org>	<412D9FE6.9050307@namesys.com>	<20040826014542.4bfe7cc3.akpm@osdl.org>	<1093522729.9004.40.camel@leto.cs.pocnet.net>	<20040826124929.GA542@lst.de>	<1093525234.9004.55.camel@leto.cs.pocnet.net>	<20040826130718.GB820@lst.de>	<1093526273.11694.8.camel@leto.cs.pocnet.net>	<20040826132439.GA1188@lst.de>	<1093527307.11694.23.camel@leto.cs.pocnet.net>	<20040826134034.GA1470@lst.de>	<1093528683.11694.36.camel@leto.cs.pocnet.net>	<412E786E.5080608@namesys.com>	<16687.9051.311225.697109@thebsh.namesys.com>	<412F7A59.8060508@namesys.com> <16687.33718.571411.76990@thebsh.namesys.com>
In-Reply-To: <16687.33718.571411.76990@thebsh.namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> > >Whoever sponsors the benchmark usually wins. Had you forgotten that
> > >mongo setup used by http://www.namesys.com/benchmarks.html was specially
> > >`tuned' to reach peak reiser4 performance? Remember why you decided to
> > >turn OVERWRITE and MODIFY phases off?
>
What I should have done was what I did with fsync performance.  With 
fsync performance I told people that we had not yet tuned for it, please 
wait a bit and we will tune for it, for now it sucks.

Instead what I did was discuss with Zam at the time how it could be 
fixed, leave it off the website until Zam was given a chance to fix it, 
and then I managed to forget about it.   After release one remembers 
what all the things that should have been fixed before release were, sigh.

Zam and I both know what is needed to fix performance in these phases, 
and I just spoke with him on the phone.  I imagine it is 2 weeks of work 
for him, but it could be up to 6 weeks.  He will comment later.

The fix should consist of the following:

1) tweak the relocation policies (zam will say more about this, as he is 
the maintainer of them)

2) optimize overwrite set so that in the modify phase we behave like a 
write twice journaling filesystem, which means implement a reserved for 
the journal only area that exists as long as plenty of disk space is free.

3) finish the repacker (but we won't do that this month....)

The modify phase, which picks a random block to modify, is a worst case 
for a wandering log without a repacker.  We could actually do very very 
well at that kind of activity with a repacker, probably better than a 
fixed journal, but for now we should try acting like a write twice 
journal for atoms that small.

So, having realized my error thanks to the gracious kindness of how you 
pointed it out, we will modify the web site to say that we are not yet 
tuned for and currently suck at modifying random blocks in the middle of 
files, and appending small amounts to the end of them, and overwriting 
small files, but that we think we know what is needed to fix those things.

I think your characterization of my reasons was unkind and also unfair.  
I will pass on saying similarly unkind things about you as you are 
mostly a good person.  You never did seem to understand me.  You didn't 
understand the reasons for my technical designs (when they worked it 
made no sense to you that they did), and you didn't understand me as a 
person. 

I wish you well in your new job, and thank you for the hard work you did 
for me.

Hans
