Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWGYTcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWGYTcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWGYTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:32:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12782 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S964845AbWGYTcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:32:13 -0400
Message-ID: <44C141C4.1030802@slaphack.com>
Date: Fri, 21 Jul 2006 16:06:12 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: Mike Benoit <ipso@snappymail.ca>
CC: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>
Subject: Re: reiser4 status (correction)
References: <44BFFCB1.4020009@namesys.com> <44C043B5.3070501@slaphack.com>	 <44C093D2.1040703@namesys.com> <1153514509.6659.41.camel@ipso.snappymail.ca>
In-Reply-To: <1153514509.6659.41.camel@ipso.snappymail.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit wrote:

> Tuning fsync will fix the last wart on Reiser4 as far as benchmarks are
> concerned won't it? Right now Reiser4 looks excellent on the benchmarks
> that don't use fsync often (mongo?), but last I recall the fsync
> performance was so poor it overshadows the rest of the performance. It
> would also probably be more useful to a much wider audience, especially
> if Namesys decides to charge for the repacker.

If Namesys does decide to charge for the repacker, I'll have to consider 
whether it's worth it to pay for it or to use XFS instead.  Reiser4 
tends to become much more fragmented than most other Linux FSes -- 
purely subjective, but probably true.

> ReiserV3 is used on a lot of mail and squid proxy servers that deal with
> many small files, and these work loads usually call fsync often.
[...]
> But neglecting fsync performance will just put a sour taste in their
> mouth. 

So will neglecting fragmentation, only worse.  At least fsync is slow up 
front.  Fragmentation will be slow much farther in, when the mailserver 
has already been through one painful upgrade.  Charging for the repacker 
just makes it worse.

> On top of that, I don't see how a repacker would help these work loads
> much as the files usually have a high churn rate. Packing them would
> probably be a net loss as the files would just be deleted in 24hrs and
> replaced by new ones.

Depends.  Some will, some won't.  My IMAP server does have a lot of 
churning, but there's also the logs (which stay for at least a month or 
two before they rotate out), and since it's IMAP, I do leave quite a lot 
of files alone.

v3 is also used on a lot of web servers, at least where I used to work 
-- some areas will be changing quite a lot, and some areas not at all. 
Changing a lot means fragmentation will happen, not changing at all 
means repacking will help.

These issues may be helped by partitioning, if you know how you're going 
to split things up.  But then, how do you partition in the middle of a 
squid server?  A lot of people visit the same sites every day, checking 
for news, but that means plenty of logos, scripts, and other things 
won't change -- but plenty of news articles will change every couple hours.

> Very few people will (or should) disable fsync as David suggests, I
> don't see that as a solution at all, even if it is temporary.

I guess the temporary solution is to incur a pretty big performance hit. 
  But it comes back to, which is more of a performance problem, fsync or 
fragmentation?

And I really would like to hear a good counter-argument to the one I've 
given for disabling fsync.  But even if we assume fsync must stay, do we 
have any benchmarks on fragmentation versus fsync?

But maybe it's best to stop debating, since both will be done 
eventually, right?
