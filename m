Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRIYVz5>; Tue, 25 Sep 2001 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRIYVzs>; Tue, 25 Sep 2001 17:55:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26004 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271278AbRIYVzk>;
	Tue, 25 Sep 2001 17:55:40 -0400
Date: Tue, 25 Sep 2001 14:55:47 -0700 (PDT)
Message-Id: <20010925.145547.90825509.davem@redhat.com>
To: bcrl@redhat.com
Cc: marcelo@conectiva.com.br, andrea@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010925170055.B19494@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0109251601360.2193-100000@freak.distro.conectiva>
	<20010925.132905.32720330.davem@redhat.com>
	<20010925170055.B19494@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Tue, 25 Sep 2001 17:00:55 -0400
   
   Last time I looked, those patches made the already ugly vm locking 
   even worse.  I'd rather try to use some of the rcu techniques for 
   page cache lookup, and per-page locking for page cache removal 
   which will lead to *cleaner* code as well as a much more scalable 
   kernel.
   
I'm willing to investigate using RCU.  However, per hashchain locking
is a much proven technique (inside the networking in particular) which
is why that was the method employed.  At the time the patch was
implemented, the RCU stuff was not fully formulated.

Please note that the problem is lock cachelines in dirty exclusive
state, not a "lock held for long time" issue.

   Keep in mind that just because a lock is on someone's hitlist doesn't 
   mean that it is for the right reasons.  Look at the io_request_lock 
   that is held around the bounce buffer copies in the scsi midlayer.  
   *shudder*

I agree.  But to my understanding, and after having studied the
pagecache lock usage, it was minimally used and not used in any places
unnecessarily as per the io_request_lock example you are stating.

In fact, the pagecache_lock is mostly held for extremely short periods
of time.

Franks a lot,
David S. Miller
davem@redhat.com

