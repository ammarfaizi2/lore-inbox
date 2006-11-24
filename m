Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757610AbWKXLDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbWKXLDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620AbWKXLDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:03:00 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:1201 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1757608AbWKXLC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:02:56 -0500
Date: Fri, 24 Nov 2006 14:01:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124110143.GF13600@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com> <20061123115240.GA20294@2ka.mipt.ru> <4565FA60.9000402@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4565FA60.9000402@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 14:01:46 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 11:45:36AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >Kernel does not put there a new entry, it is only done inside
> >kevent_wait(). Entries are put into queue (in any context), where they can 
> >be obtained
> >from only kevent_wait() or kevent_get_events().
> 
> I know this is how it's done now.  But it is not where it has to end. 
> IMO we have to get to a solution where new events are posted to the ring 
> buffer asynchronously, i.e., without a thread calling kevent_wait.  And 
> then you need the extra parameter and verification.  Even if it's today 
> not needed we have to future-proof the interface since it cannot be 
> changed once in use.

There is a special flag in kevent_user to wake it if there are no ready
events - kernel thread which has added new events will set it and thus
subsequent kevent_wait() will return with updated indexes - userspace
must check indexes after kevent_wait().

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
