Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267191AbUGMWm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267191AbUGMWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267188AbUGMWkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:40:05 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:52657 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267197AbUGMWis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:38:48 -0400
Message-ID: <014901c46932$5a380ac0$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: "Bill Huey \(hui\)" <bhuey@lnxw.com>,
       "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       "Paul Davis" <paul@linuxaudiosystems.com>, <florin@sgi.com>,
       <linux-kernel@vger.kernel.org>, <albert@users.sourceforge.net>
References: <20040712172458.2659db52.akpm@osdl.org> <008501c468d2$405d8c70$161b14ac@boromir> <20040713191224.GA22237@nietzsche.lynx.com> <006901c4692b$074996f0$161b14ac@boromir> <20040713220838.GA22781@nietzsche.lynx.com>
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought?
Date: Wed, 14 Jul 2004 00:37:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bill Huey (hui)" <bhuey@lnxw.com>
> On Tue, Jul 13, 2004 at 11:44:59PM +0100, Martijn Sipkema wrote:
> [...]
> > The worst case latency is the one that counts and that is the contended case. If
> > you could guarantee no contention then the worst case latency would be the
> > very fast uncontended case, but I doubt there are many (any?) examples of this in
> > practice. There are valid uses of mutexes with priority inheritance/ceiling protocol;
> > the poeple making the POSIX standard aren't stupid...
> 
> There are cases where you have to use priority inheritance, but the schemes that are
> typically used either have a kind of exhaustive analysis backing it or uses a simple
> late detection scheme. In a general purpose OS, the latter is useful for various kind
> of overload cases. But if your system is constantly using that specific case, then it's
> a sign the contention in the kernel must *also* be a problem under SMP conditions. The
> constant use of priority inheritance overloads the scheduler, puts pressure on the
> cache and other negative things that hurt CPU local performance of the system.
> 
> The reason why I mention this is because of Linux's hand-crafted nature of dealing
> with this. These are basically contention problems expressed in a different manner.
> The traditional Linux method is the correct method of deal with this in a general
> purpose OS. This also applies to application structure as well. The use of these
> mechanisms need to be thought out before application.

To be honest, I don't understand a word of what you are saying here. Could you
give an example of a ``contention problem'' and how it should be solved?

> > > > It is often heard in the Linux audio community that mutexes are not realtime
> > > > safe and a lock-free ringbuffer should be used instead. Using such a lock-free
> > > > ringbuffer requires non-standard atomic integer operations and does not
> > > > guarantee memory synchronization (and should probably not perform
> > > > significantly better than a decent mutex implementation) and is thus not
> > > > portable.
> > > 
> > > It's to decouple the system from various time related problems with jitter.
> > > It's critical to use this since the nature of Linus is so temporally coarse
> > > that these techniques must be used to "smooth" over latency problems in the
> > > Linux kernel.
> 
> > Either use mutexes or POSIX message queues... the latter also are not
> > intended for realtime use under Linux (though they are meant for it in
> > POSIX), since they don't allocate memory on creation.
>  
> The nature these kind of applications push into a very demanding space where
> typical methodologies surrounding the use of threads goes out the window. Pushing
> both the IO and CPU resources of a kernel is the common case and often you have to
> roll your own APIs, synchronization mechanisms to deal with these problem. Simple
> Posix API and traditional mutexes are a bit too narrow in scope to solve these
> cross system concurrency problems. It's not trivial stuff at all and can span
> from loosely to tightly coupled systems, yes, all for pro-audio/video.
> 
> Posix and friends in these cases simply aren't good enough to cut it.

I find this a little abstract. Sure, there might be areas where POSIX doesn't supply
all the needed tools, e.g. one might want some scheduling policy especially for
audio, but to say that POSIX isn't good enough without providing much
explanation...

--ms


