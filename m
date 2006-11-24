Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757646AbWKXIQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646AbWKXIQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 03:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757642AbWKXIQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 03:16:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755791AbWKXIQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 03:16:20 -0500
Date: Fri, 24 Nov 2006 00:14:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
Message-Id: <20061124001412.371ec4e7.akpm@osdl.org>
In-Reply-To: <45664160.6060504@cosmosbay.com>
References: <11641265982190@2ka.mipt.ru>
	<456621AC.7000009@redhat.com>
	<45662522.9090101@garzik.org>
	<45663298.7000108@redhat.com>
	<45664160.6060504@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 01:48:32 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> > The alternative is the sorry state we have now.  In nscd, for instance, 
> > we have one single thread waiting for incoming connections and it then 
> > has to wake up a worker thread to handle the processing.  This is done 
> > because we cannot "park" all threads in the accept() call since when a 
> > new connection is announced _all_ the threads are woken.  With the new 
> > event handling this wouldn't be the case, one thread only is woken and 
> > we don't have to wake worker threads.  All threads can be worker threads.
> 
> Having one specialized thread handling the distribution of work to worker 
> threads is better most of the time.

It might be now.  Think "commodity 128-way".  Your single distribution thread
will run out of steam.

What Ulrich is proposing is faster.  This is a new interface.  Let's design
it to be fast.

