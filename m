Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBABAg>; Fri, 31 Jan 2003 20:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTBABAg>; Fri, 31 Jan 2003 20:00:36 -0500
Received: from mail015.syd.optusnet.com.au ([210.49.20.173]:4564 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S264628AbTBABAe> convert rfc822-to-8bit; Fri, 31 Jan 2003 20:00:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
Date: Sat, 1 Feb 2003 12:09:49 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
References: <200302010930.54538.conman@kolivas.net> <200302011144.54554.conman@kolivas.net> <3E3B1B1E.7050800@cyberone.com.au>
In-Reply-To: <3E3B1B1E.7050800@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011209.49692.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 11:55 am, Nick Piggin wrote:
> Con Kolivas wrote:
> >On Saturday 01 Feb 2003 11:37 am, Nick Piggin wrote:
> >>Con Kolivas wrote:
> >>>Seems the fix for "reads starves everything" works. Affected the tar
> >>> loads too?
> >>
> >>Yes, at the cost of throughput, however for now it is probably
> >>the best way to go. Hopefully anticipatory scheduling will provide
> >>as good or better kernel compile times and better throughput.
> >>
> >>Con, tell me, are "Loads" normalised to the time they run for?
> >>Is it possible to get a finer grain result for the load tests?
> >
> >No, the load is the absolute number of times the load successfully
> > completed. We battled with the code for a while to see if there were ways
> > to get more accurate load numbers but if you write a 256Mb file you can
> > only tell if it completes the write or not; not how much has been written
> > when you stop the write. Same goes with read etc. The load rate is a more
> > meaningful number but we haven't gotten around to implementing that in
> > the result presentation.
>
> I don't know how the contest code works, but if you split that into
> a number of smaller writes it should work?

Yes it would but the load effect is significantly diminished. By writing a 
file the size==physical ram the load effect is substantial.

> >Load rate would be:
> >
> >loads / ( load_compile_time - no_load_compile_time )
>
> I think loads / time_load_ran_for should be ok (ie, give you loads per time
> interval). This would be more useful if your loads were getting more
> efficient
> or less because it is possible that an improvement would lower compile time
> _and_ loads, but overall the loads were getting done quicker.

I found the following is how loads occur almost always:
noload time: 60
load time kernal a: 80, loads 20
load time kernel b: 100, loads 40
load time kernel c: 90, loads 30

and loads/total time wouldnt show this effect as kernel c would appear to have 
a better load rate 

if there was
load time kernel d: 80, loads 40

that would be more significant no?
