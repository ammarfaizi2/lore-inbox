Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbSIZE0B>; Thu, 26 Sep 2002 00:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262175AbSIZE0B>; Thu, 26 Sep 2002 00:26:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62594 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262173AbSIZEZ7>;
	Thu, 26 Sep 2002 00:25:59 -0400
Date: Wed, 25 Sep 2002 21:24:59 -0700 (PDT)
Message-Id: <20020925.212459.118951005.davem@redhat.com>
To: akpm@digeo.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D928813.7EAD7F3C@digeo.com>
References: <3D928813.7EAD7F3C@digeo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Wed, 25 Sep 2002 21:07:47 -0700
   
   The main objective of this is to reduce the CPU cost of the wait/wakeup
   operation.  When a task is woken up, its waitqueue is removed from the
   waitqueue_head by the waker (ie: immediately), rather than by the woken
   process.

I don't want to say that your changes cannot be made to work,
but it's been one of my understandings all these years that
the fact that the task itself controls it's presence on the
wait queue is what allows many races to be handled properly and
cleanly.

For example, the ordering of the test and add/remove from
the wait queue is pretty important.

It probably doesn't matter when there is a higher level of locking
done around the sleep/wakeup (TCP sockets are one good example)
and if that is what this is aimed at, great.
