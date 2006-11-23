Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757050AbWKWL4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbWKWL4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbWKWL4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:56:22 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:32195 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757028AbWKWL4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:56:21 -0500
Date: Thu, 23 Nov 2006 14:55:04 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061123115504.GB20294@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E2AB.1020202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4564E2AB.1020202@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 14:55:05 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 03:52:11PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >+ struct kevent_ring
> >+ {
> >+   unsigned int ring_kidx, ring_uidx, ring_over;
> >+   struct ukevent event[0];
> >+ }
> >+ [...]
> >+ring_uidx - index of the first entry userspace can start reading from
> 
> Do we need this value in the structure?  Userlevel cannot and should not 
> be able to modify it.  So, userland has in any case to track the tail 
> pointer itself.  Why then have this value at all?
> 
> After kevent_init() the tail pointer is implicitly assumed to be 0. 
> Since the front pointer (well index) is also zero nothing is available 
> for reading.

uidx is an index, starting from which there are unread entries. It is
updated by userspace when it commits entries, so it is 'consumer'
pointer, while kidx is an index where kernel will put new entries, i.e.
'producer' index. We definitely need them both.
Userspace can only update (implicitly by calling kevent_commit()) uidx.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
