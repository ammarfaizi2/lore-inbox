Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283795AbRLWGcs>; Sun, 23 Dec 2001 01:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283860AbRLWGci>; Sun, 23 Dec 2001 01:32:38 -0500
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:44240 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S283795AbRLWGc1>; Sun, 23 Dec 2001 01:32:27 -0500
Message-ID: <3C257B08.C4848C76@kegel.com>
Date: Sat, 22 Dec 2001 22:34:48 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Huey <billh@tierra.ucsd.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
Subject: Re: aio
In-Reply-To: <20011219.172046.08320763.davem@redhat.com> <E16HTTI-0000w0-00@the-village.bc.nu> <20011222214630.B12352@burn.ucsd.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey wrote:
> > There we agree. Things like the current asynch/thread mess in java are
> > partly poor design of language and greatly stupid design of JVM.
> 
> It's not the fault of the JVM runtime nor the the language per se since
> both are excellent. The blame should instead be placed on the political
> process within Sun, which has created a lag in getting a decent IO event
> model/system available in the form of an API.
> 
> This newer system is suppose to be able to scale to tens of thousands of
> FDs and be able to handle heavy duty server side stuff in a more graceful
> manner. It's a reasonable system from what I saw, but the implementation
> of it is highly OS dependent and will be subject to those environmental
> constraints. Couple this and the HotSpot compiler (supposeablly competitive
> with gcc's -O3 from benchmarks) and it should be high useable for a broad
> range of of server side work when intelligently engineered.

I served on JSR-51, the expert group that helped design the new I/O
model.  (The design was Sun's, but we had quite a bit of input.)
For network I/O, there's a Selector object which is essentially
a nice OO wrapper around the /dev/poll or kqueue/kevent abstraction.
Selector does have a distinctly Unixy feel to it, but it can probably
be implemented well on top of any reasonable OS; I'm quite sure
it can be expressed fairly well in terms of Windows NT's asych I/O
or Linux's rt signal stuff.  

(I suspect the initial Linux implementations will just use poll(),
but that's something the Blackdown team can fix.  And heck, it
ought to be easy to implement it on top of all the nifty poll
replacements and choose between them at jvm startup time without
any noticable overhead.)

- Dan

p.s. Davide, I didn't forget /dev/epoll, I just haven't had time to
post Poller_devepoll yet!
