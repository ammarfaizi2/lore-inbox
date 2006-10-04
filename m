Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWJDEz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWJDEz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWJDEz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:55:58 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41947 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1160996AbWJDEz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:55:57 -0400
Date: Wed, 4 Oct 2006 08:55:27 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061004045527.GB32267@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 04 Oct 2006 08:55:28 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:50:09PM -0700, Ulrich Drepper (drepper@gmail.com) wrote:
> On 9/27/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> \> I have been told in private what is signal masks about - just to wait
> >until either signal or given condition is ready, but in that case just
> >add additional kevent user like AIO complete or netwrok notification
> >and wait until either requested events are ready or signal is triggered.
> 
> No, this won't work.  Yes, I want signal notification as part of the
> event handling.  But there are situations when this is not suitable.
> Only if the signal is expected in the same code using the event
> handling can you do this.  But this is not always possible.
> Especially when the signal handling code is used in other parts of the
> code than the event handling.  E.g., signal handling in a library,
> event handling in the main code.  You cannot assume that all the code
> is completely integrated.

Signals still can be delivered in usual way too.

When we enter sys_ppoll() we specify needed signals as syscall
parameter, with kevents we will add them into the queue.

-- 
	Evgeniy Polyakov
