Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319384AbSH2VHq>; Thu, 29 Aug 2002 17:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319385AbSH2VHp>; Thu, 29 Aug 2002 17:07:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35592
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319384AbSH2VHp>; Thu, 29 Aug 2002 17:07:45 -0400
Subject: Re: [PATCH] low-latency zap_page_range()
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <3D6E8B7F.8D5D20D8@zip.com.au>
References: <3D6E844C.4E756D10@zip.com.au>
	<1030653602.939.2677.camel@phantasy>  <3D6E8B7F.8D5D20D8@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 17:12:11 -0400
Message-Id: <1030655532.12110.2691.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 17:00, Andrew Morton wrote:

> That's an interesting point.  page_table_lock is one of those locks
> which is occasionally held for ages, and frequently held for a short
> time.

Since latency is a direct function of lock held times in the preemptible
kernel, and I am seeing disgusting zap_page_range() latencies, the lock
is held a long time.

So we know it is held forever and a day... but is there contention?

> But I don't recall seeing nasty page_table_lock spintimes on
> anyone's lockmeter reports, so we can leave it as-is for now.

I do not recall seeing this either and I have not done my own tests.

Personally, I would love to rip out the "cond_resched_lock()" and just
do

	spin_unlock();
	spin_lock();

and be done with it.  This gives automatic preemption support and the
SMP benefit.  Preemption being an "automatic" consequence of improved
locking was always my selling point (albeit, this is a gross example of
improving the locking, but it gets the job done).

But, the current implementation was more palatable to you and Linus when
I first posted this, and that counts for something.

	Robert Love

