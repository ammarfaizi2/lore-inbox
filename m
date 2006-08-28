Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWH1B5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWH1B5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWH1B5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:57:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54453
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932332AbWH1B5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:57:42 -0400
Date: Sun, 27 Aug 2006 18:57:44 -0700 (PDT)
Message-Id: <20060827.185744.82374086.davem@davemloft.net>
To: drepper@redhat.com
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org,
       chase.venters@clientec.com
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44F208A5.4050308@redhat.com>
References: <11564996832717@2ka.mipt.ru>
	<44F208A5.4050308@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Sun, 27 Aug 2006 14:03:33 -0700

> The biggest problem I see so far is the integration into the existing
> interfaces.  kevent notification *really* should be usable as a new
> sigevent type.  Whether the POSIX interfaces are liked by kernel folks
> or not, they are what the majority of the userlevel programmers use.
> The mechanism is easily extensible.  I've described this in my paper.  I
> cannot comment on the complexity of the kernel side but I'd imagine it's
> not much more difficult, just different from what is implemented now.
> Let's learn for a change from the mistakes of the past.  The new and
> innovative AIO interfaces never took off because their implementation
> differs so much from the POSIX interfaces.  People are interested in
> portable code.  So, please, let's introduce SIGEV_KEVENT.  Then we
> magically get timer notification etc for free.

I have to disagree with this.

SigEvent, and signals in general, are crap.  They are complex
and userland gets it wrong more often than not.  Interfaces
for userland should be simple, signals are not simple.  A core
loop that says "give me events to process", on the other hand,
is.  And this is what is most natural for userspace.

The user can say when he wants the process events.  In fact,
ripping out the complex signal handling will be a welcome
change for most server applications.

We are going to require the use of a new interface to register
the events anyways, why keep holding onto the delivery baggage
as well when we can break free of those limitations?
