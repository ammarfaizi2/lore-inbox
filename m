Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRGFVyp>; Fri, 6 Jul 2001 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbRGFVyf>; Fri, 6 Jul 2001 17:54:35 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:24836 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266864AbRGFVyZ>; Fri, 6 Jul 2001 17:54:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
Date: Fri, 6 Jul 2001 23:57:15 +0200
X-Mailer: KMail [version 1.2]
Cc: Xavier Bestel <xavier.bestel@free.fr>, Dan Maas <dmaas@dcine.com>,
        <linux-kernel@vger.kernel.org>, Tom spaziani <digiphaze@deming-os.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33L.0107061608380.17825-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107061608380.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01070623571501.22952@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 21:09, Rik van Riel wrote:
> On Thu, 5 Jul 2001, Daniel Phillips wrote:
> > Let me comment on this again, having spent a couple of minutes
> > more thinking about it.  Would you be happy paying 1% of your
> > battery life to get 80% less sluggish response after a memory
> > pig exits?
>
> Just to pull a few random numbers out of my ass too,
> how about 50% of battery life for the same optimistic
> 80% less sluggishness ?
>
> How about if it were only 30% of battery life?

It's not as random as that.  The idea being considered was: suppose a 
program starts up, goes through a period of intense, cache-sucking 
activity, then exits.  Could we reload the applications it just 
displaced so that the disk activity to reload them doesn't have to take 
place the first time the user touches the keyboard/mouse.  Sure, we 
obviously can, with how much complexity is another question entirely ;-)

So probably, we could eliminate more than 80% of the latency we now see 
in such a situation, I was being conservative.

Now what's the cost in battery life?  Suppose it's a 128 meg machine, 
1/3 filled with program text and data.  Hopefully, the working sets 
that were evicted are largely coherent so we'll read it back in at a 
rate not too badly degraded from the drive's transfer rate, say 5 
MB/sec.  This gives about three seconds of intense reading to restore 
something resembling the previous working set, then the disk can spin 
down and perhaps the machine will suspend itself.  So the question is, 
how much longer did the machine have to run to do this?  Well, on my 
machine updatedb takes 5-10 minutes, so the 3 seconds of activity 
tacked onto the end of the episode amounts to less than 1%, and this is 
where the 1% figure came from.

I'm not saying this would be an easy hack, just that it's possible and 
the numbers work.

--
Daniel
