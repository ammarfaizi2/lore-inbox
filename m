Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRJIHlR>; Tue, 9 Oct 2001 03:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJIHlH>; Tue, 9 Oct 2001 03:41:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14478 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273515AbRJIHk5>;
	Tue, 9 Oct 2001 03:40:57 -0400
Date: Tue, 9 Oct 2001 13:16:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: "Paul E. McKenney" <pmckenne@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011009131626.A10410@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com> <3BC2A3B3.3020004@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BC2A3B3.3020004@wipro.com>; from balbir.singh@wipro.com on Tue, Oct 09, 2001 at 12:43:55PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 12:43:55PM +0530, BALBIR SINGH wrote:
> 1) On Alpha this code does not improve performance since we end up using spinlocks
> for my_global_data anyway, I think you already know this.

It may if you don't update very often. It depends on your
read-to-write ratio.

> 
> The approach is good, but what are the pratical uses of the approach. Like u mentioned a newly
> added element may not show up in the search, searches using this method may have to search again
> and there is no way of guaranty that an element that we are looking for will be found (especially
> if it is just being added to the list).
> 
> The idea is tremendous for approaches where we do not care about elements being newly added.
> It should definitely be in the Linux kernel  :-) 

Either you see the element or you don't. If you want to avoid duplication,
you could do a locked search before inserting it.
Like I said before, lock-less lookups are useful for read-mostly
data. Yes, updates are costly, but if they happen rarely, you still benefit.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
