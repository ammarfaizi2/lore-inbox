Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSGZG1B>; Fri, 26 Jul 2002 02:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGZG1B>; Fri, 26 Jul 2002 02:27:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:38330 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317078AbSGZG1A>;
	Fri, 26 Jul 2002 02:27:00 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines 
In-reply-to: Your message of "Thu, 25 Jul 2002 20:45:12 +0530."
             <20020725204512.E3594@in.ibm.com> 
Date: Fri, 26 Jul 2002 16:24:51 +1000
Message-Id: <20020726063124.5114E45D6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020725204512.E3594@in.ibm.com> you write:
> I've noticed that xtime_lock and timerlist_lock ends up on the same
> cacheline  all the time (atleaset on x86).  Not a good thing for
> loads with high xxx_timer and do_gettimeofday counts I guess (networking etc)
..

Better might be to use the x86-64 trick of using sequence counters
around do_gettimeofday, and avoid the xtime lock altogether.  That
will improve gettimeofday performance as well.  Or you could try
changing xtime lock to a brlock.

FYI: as policy, I don't take optimization patches without
measurements.  I'm just not that smart.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
