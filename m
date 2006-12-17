Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLQRch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLQRch (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 12:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWLQRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 12:32:37 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52987 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbWLQRcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 12:32:36 -0500
Date: Sun, 17 Dec 2006 20:32:04 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fallout from atomic_long_t patch
Message-ID: <20061217173201.GA31675@2ka.mipt.ru>
References: <20061217105907.GE17561@ftp.linux.org.uk> <Pine.LNX.4.64.0612170911230.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612170911230.3479@woody.osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 17 Dec 2006 20:32:15 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 09:24:30AM -0800, Linus Torvalds (torvalds@osdl.org) wrote:
> 
> 
> On Sun, 17 Dec 2006, Al Viro wrote:
> > -			if (likely(!test_bit(WORK_STRUCT_PENDING,
> > -					     &__cbq->work.work.management) &&
> > +			if (likely(!work_pending(&__cbq->work.work) &&
> 
> That should properly be
> 
> 	if (likely(!delayed_work_pending(&__cbq->work) && ...
> 
> and why the heck was it doing that open-coded int he first place?
>
> HOWEVER, looking even more, why is that thing a "delayed work" at all? All 
> the queuing seems to happen with a timeout of zero..
> 
> So I _think_ that the proper patch is actually the following, but somebody 
> who knows and uses the connector thing should double-check. Please?

Delayed work was used to play with different timeouts and thus allow to
smooth performance peaks, but then I dropped that idea, so timeout is always
zero.

I posted similar patch today to netdev@, which directly used
work_pending instead of delayed_work_pending(), but if you will figure
this out itself, I'm ok with proposed patch.


> 			Linus

-- 
	Evgeniy Polyakov
