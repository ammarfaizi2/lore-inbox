Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWJDHsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWJDHsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWJDHsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:48:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62617 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030532AbWJDHsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:48:53 -0400
Date: Wed, 4 Oct 2006 11:48:22 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061004074821.GA22688@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452363C5.1020505@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 04 Oct 2006 11:48:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 12:33:25AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > When we enter sys_ppoll() we specify needed signals as syscall
> > parameter, with kevents we will add them into the queue.
> 
> No, this is not sufficient as I said in the last mail.  Why do you
> completely ignore what others say.  The code which depends on the signal
> does not have to have access to the event queue.  If a library sets up
> an interrupt handler then it expect the signal to be delivered this way.
>  In such situations ppoll etc allow the signal to be generally blocked
> and enabled only and *ATOMICALLY* around the delays.  This is not
> possible with the current wait interface.  We need this signal mask
> interfaces and the appropriate setup code.
> 
> Being able to get signal notifications does not mean this is always the
> way it can and must happen.

It is completely possible to do what you describe without special
syscall parameters. Just add interesting signals to the queue (and
optionally block them globally) and wait on that queue.
When signal's event is generated and appropriate kevent is removed, that
signal will be restored in global signal mask (there are appropriate
enqueue/dequeue callbacks which can perform operations on signal mask
for given process).

My main consern is to not add special cases for something in generic
code, especially when gneric code can easily handle that situations.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov
