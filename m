Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUH2MBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUH2MBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUH2MBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:01:49 -0400
Received: from clusterfw.gprsrus.net ([217.118.66.232]:44904 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267767AbUH2MBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:01:43 -0400
Date: Sun, 29 Aug 2004 15:55:03 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Steve Bergman <steve@rueb.com>
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       reiserfs <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20040829115503.GL5108@backtop.namesys.com>
References: <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net> <412E786E.5080608@namesys.com> <16687.9051.311225.697109@thebsh.namesys.com> <412F7A59.8060508@namesys.com> <1093645747.17445.19.camel@voyager.localdomain> <41302C39.2080100@namesys.com> <1093687768.8097.25.camel@voyager.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093687768.8097.25.camel@voyager.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 05:09:28AM -0500, Steve Bergman wrote:
> On Fri, 2004-08-27 at 23:54 -0700, Hans Reiser wrote:
> > >
> > I didn't write this (more precisely, it only vaguely resembles what I 
> > wrote in 1996).  Are you saying that it reports system time as real 
> > time?  If yes, then it is an error, we need to go remove a bunch of 
> > numbers from our benchmarks, and thanks for finding it.
> > 
> > Zam, please comment.
> > 
> 
> No.  I'm saying that on my setup (kernel 2.6.8.1-mm4/perl 5.8.5/bash
> 3.00) the first line returned from running the test is the:
> 
> [1]+  Done ...

> line which throws the array indexes off by 1 and I always get 0 for the
> real time and, yes, the real time gets reported as the system time, I
> think.  Plus I get a warning about the fact that "Done" is not numeric.
> This is obviously a problem with my particular setup.

Yes. but that real/sys time parsing isn't reliable.   

> After bumping the indexes up by 1, I get the correct real time reported
> as "STAT REAL_TIME".  And the system time is reported as "STAT
> CPU_TIME".
> 
> "STAT CPU_UTIL", however is computed in a completely different way based
> on numbers collected from /proc/stat.  If I'm, reading
> linux/Documentation/filesystems/proc.txt correctly, it is trying to
> return the (system time) / (total time).  The total time agrees with
> "STAT REAL_TIME".  However, the (system time) that it comes up with here
> is always considerably higher than "STAT CPU_TIME".

CPU_UTIL counts other background processes too.   The foreground process may just wait
when all work is done by pdflush.  I think CPU_UTIL is more useful than CPU_TIME.

> 
> User error is quite possible, as I am:
> 
> 1. Just getting to know mongo.
> 2. Not a perl guy.

i don't like perl too much, but seems Perl is perfect for the things you just did (the fixes).

> 3. There is obviously something mongo.pl doesn't like about my setup.
> 
> -Steve Bergman
> 
> P.S. In the 2 tests I've run, reiser4 is not doing all that badly
> against ext3 in OVERWRITE and MODIFY, though ext3 does come in faster.
> Reiser4 trails badly on APPEND however, ext3 (data=ordered, without
> htree) being some 2.5 - 4 times faster. 

-- 
Alex.
