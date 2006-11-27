Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758522AbWK0SYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522AbWK0SYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758519AbWK0SYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:24:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:11159
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758520AbWK0SYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:24:41 -0500
Date: Mon, 27 Nov 2006 10:24:43 -0800 (PST)
Message-Id: <20061127.102443.74556125.davem@davemloft.net>
To: drepper@redhat.com
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <456B2C82.7040700@redhat.com>
References: <456603E7.9090006@redhat.com>
	<20061124095052.GC13600@2ka.mipt.ru>
	<456B2C82.7040700@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Mon, 27 Nov 2006 10:20:50 -0800

> Evgeniy Polyakov wrote:
> >> We need to pass the data in the sigev_value meember of the struct 
> >> sigevent structure passed to timer_create to the caller.  I don't see it 
> >> being done here nor when the timer is created.  Do I miss something? 
> >> The sigev_value value should be stored in the user/ptr member of struct 
> >> ukevent.
> > 
> > sigev_value was stored in k_itimer structure, I just do not know where
> > to put it in the ukevent provided to userspace - it can be placed in
> > pointer value if you like.
> 
> sigev_value is a union and the largest element is a pointer.  So, 
> transporting the pointer value is sufficient and it should be passed up 
> to the user in the ptr member of struct ukevent.

Now we'll have to have a compat layer for 32-bit/64-bit environments
thanks to POSIX timers, which is rediculious.

This is exactly the kind of thing I was hoping we could avoid when
designing these data structures.  No pointers, no non-fixed sized
types, only types which are identically sized and aligned between
32-bit and 64-bit environments.

It's OK to have these problems for things designed a long time ago
before 32-bit/64-bit compat issues existed, but for new stuff no
way.
