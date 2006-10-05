Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWJEOVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWJEOVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWJEOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:21:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17604 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751236AbWJEOVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:21:37 -0400
Date: Thu, 5 Oct 2006 18:15:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Hans Henrik Happe <hhh@imada.sdu.dk>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061005141556.GA30715@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610051156.25036.dada1@cosmosbay.com> <20061005102106.GE1015@2ka.mipt.ru> <200610051601.20701.hhh@imada.sdu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610051601.20701.hhh@imada.sdu.dk>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 18:15:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 04:01:19PM +0200, Hans Henrik Happe (hhh@imada.sdu.dk) wrote:
> > And what happens when there are 3 empty at the beginning and \we need to
> > put there 4 ready events?
> 
> Couldn't there be 3 areas in the mmap buffer:
> 
> - Unused: entries that the kernel can alloc from.
> - Alloced: entries alloced by kernel but not yet used by user. Kernel can 
> update these if new events requires that.
> - Consumed: entries that the user are processing.
> 
> The user takes a set of alloced entries and make them consumed. Then it 
> processes the events after which it makes them unused. 
> 
> If there are no unused entries and the kernel needs some, it has wait for free 
> entries. The user has to notify when unused entries becomes available. It 
> could set a flag in the mmap'ed area to avoid unnessesary wakeups.
> 
> The are some details with indexing and wakeup notification that I have left 
> out, but I hope my idea is clear. I could give a more detailed description if 
> requested. Also, I'm a user-level programmer so I might not get the whole 
> picture.

This looks good on a picture, but how can you put it into page-based
storage without major and complex shared structures, which should be
properly locked between kernelspace and userspace?

> Hans Henrik Happe

-- 
	Evgeniy Polyakov
