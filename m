Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280200AbRKEEjp>; Sun, 4 Nov 2001 23:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280199AbRKEEjf>; Sun, 4 Nov 2001 23:39:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36338
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280200AbRKEEjX>; Sun, 4 Nov 2001 23:39:23 -0500
Date: Sun, 4 Nov 2001 20:39:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011104203917.B16679@mikef-linux.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>, <3BE5F5BF.7A249BDF@zip.com.au> <20011104193232.A16679@mikef-linux.matchmail.com> <3BE60B51.968458D3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE60B51.968458D3@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:45:21PM -0800, Andrew Morton wrote:
> Mike Fedyk wrote:
> > What settings are you suggesting?  The 2.4 elevator queue size is an
> > order of magnatide larger than 2.2...
> 
> The default number of requests is 128.    This is in fact quite ample AS
> LONG AS the filesystem is feeding decent amounts of reasonably localised
> stuff into the request layer, and isn't stopping for reads all the time.
> ext2 and the VFS are not.  But I suspect that with the ialloc.c change,
> disk readahead is covering up for it.
>

Hmm...

> The meaning of the parameter to elvtune is a complete mystery, and the
> code is uncommented crud (tautology).  So I just used -r20000 -w20000.
> 

I saw somewhere that Andrea Acrangeli wrote it... Maybe he can help?

> This was based on observing the request queue dynamics.  We frequently
> fail to merge requests which really should be merged regardless of
> latency.  Bumping the elvtune settings fixed it all.  But once the
> fs starts writing data out contiguously it's all academic.
> 

I have had much improved interactive performance with -r 333 -w 1000, or
even -r 100 -w 300...

Setting it down to -r 0 -w 0 caused several processes (in a -j5 kernel
compile) to start waiting for disk...

> > >
> > > The time to create 100,000 4k files (10 per directory) has fallen
> > > from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.
> > >
> > 
> > Nice!
> 
> Well.  I got to choose the benchmark.
>

Yep, but I'm sure the diffing two trees test will will get your patch
noticed... ;)

How do the numbers look for ext2 mounted -o sync?

> > My God!  I'm no kernel hacker, but I would think the first thing you would
> > want to do is keep similar data (in this case similar because of proximity
> > in the dir tree) as close as possible to reduce seeking...
> 
> Sure.  ext2 goes to great lengths to avoid intra-file fragmentation,
> and then goes and adds its own inter-file fragmentation.
> 
> It's worse on larger partitons, because they have more of the 128 meg
> block groups.
>

Yep.

Do you think that more (and thus, smaller) block groups would help for the
larger partitions?  

> > Is there any chance that this will go into ext3 too?
> > 
> 
> If it goes in ext2, yes.  

Great!

>Depends on what the ext2 gods say - there
> may be some deep design issue I'm missing here.
> 
Yes, let's see what they say. :)

Mike
