Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261172AbRERRJS>; Fri, 18 May 2001 13:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261198AbRERRJA>; Fri, 18 May 2001 13:09:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13574 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261172AbRERRIp>;
	Fri, 18 May 2001 13:08:45 -0400
Date: Fri, 18 May 2001 14:08:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105180734360.579-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105181403280.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Mike Galbraith wrote:
> On Thu, 17 May 2001, Rik van Riel wrote:
> > On Thu, 17 May 2001, Mike Galbraith wrote:
> >
> > > Only doing parallel kernel builds.  Heavy load throughput is up,
> > > but it swaps too heavily.  It's a little too conservative about
> > > releasing cache now imho. (keeping about double what it should be
> > > with this load.. easily [thump] tweaked;)
> >
> > "about double what it should be" ?
> 
> Do you think there's 60-80mb of good cachable data? ;-)  The "double"
> is based upon many hundreds of test runs.  I "know" that performance
> is best with this load when the cache stays around 25-35Mb.  I know
> this because I've done enough bend adjusting to get throughput to
> within one minute of single task times to have absolutely no doubt.
> I can get it to 30 seconds with much obscene tweaking, and have done
> it with zero additional overhead for make -j 30 ten times in a row.
> (that kernel was.. plain weird. perfect synchronization.. voodoo!)

Ahhh, I see.  Remember that the "cached" figure you are
seeing also includes swap-cached data from the gccs, which
results from kswapd scanning the processes, clearing the
PTE and, a bit later, the process grabbing the page again.

I suspect that if the gccs _just_ fit in memory, you can
get some extra performance by mercilessly eating from the
cache and keeping the ggcs in memory. However, I also have
the sneaking suspicion that this is not the best tactic for
all workloads ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

