Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbSJBVbY>; Wed, 2 Oct 2002 17:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbSJBVbY>; Wed, 2 Oct 2002 17:31:24 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:53677 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262606AbSJBVbX>;
	Wed, 2 Oct 2002 17:31:23 -0400
Message-ID: <3D9B66EE.90001@colorfullife.com>
Date: Wed, 02 Oct 2002 23:36:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm wrote:
> It's not really clear why that yield is in there at all?  Unless that
> code is really, really slow (milliseconds) then probably it should just
> be deleted.
> 
It looks like a very simple starvation control:

thread 1:
	for(;;) {
		F_LOCK
		<do a few seconds work>
		F_UNLCK
	}
thread 2:
	F_LOCK.

If there is no yield after unlock, thread 2 might never receive the lock.
Is it possible to figure out if someone is waiting on the lock? F_UNLCK 
should schedule, if there is a waiter with higher priority.

--
	Manfred



