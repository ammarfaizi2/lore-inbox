Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJMTju>; Sun, 13 Oct 2002 15:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJMTju>; Sun, 13 Oct 2002 15:39:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50671 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261661AbSJMTjt>; Sun, 13 Oct 2002 15:39:49 -0400
Date: Mon, 14 Oct 2002 01:20:12 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Structure clobbering causes timer oopses
Message-ID: <20021014012012.A13906@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DA8C585.1030600@us.ibm.com> <3DA8C75C.C38F840B@digeo.com> <3DA8D5E6.8090201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA8D5E6.8090201@us.ibm.com>; from haveblue@us.ibm.com on Sun, Oct 13, 2002 at 02:17:46AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 02:17:46AM +0000, Dave Hansen wrote:
> > If they're initially using add_timer(), that works out
> > OK.  It they start out using mod_timer() (or del_timer) then bug.
> 
> The init_timer() comment says otherwise, but I imagine that not using 
> it shouldn't _cause_ any bugs.
> 
> * init_timer() must be done to a timer prior calling *any* of the
> * other timer functions.

I am not sure about that. init_timer() initializes timer->base
and timer_pending() checks for base == NULL. So, it is illegal
to do timer_pending(), mod_timer() and del_timer*() without an
init_timer() or an add_timer() earlier. But then, I presume this
was a requirement in the earlier timer interfaces too. No ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
