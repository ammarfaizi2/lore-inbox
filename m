Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbTBQWeF>; Mon, 17 Feb 2003 17:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTBQWeF>; Mon, 17 Feb 2003 17:34:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267615AbTBQWeE>;
	Mon, 17 Feb 2003 17:34:04 -0500
Message-Id: <200302172244.h1HMi3n03557@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cliffw@osdl.org
Subject: Re: 2.5.61-mm1 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Fri, 14 Feb 2003 23:13:56 PST." <20030214231356.59e2ef51.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Feb 2003 14:44:03 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.61/2.5.61-mm1/
> 
> . Jens has fixed the request queue aliasing problem and we are no longer
>   able to break the IO scheduler.  This was preventing the OSDL team from
>   running dbt2 against recent kernels, so hopefully that is all fixed up now.
> 
Thanks again for doing all this, really appreciate it.
Well, we're closer....
The showstopper for us is still the flock() issue. We have Mathew Wilcox's patch from
2.5.52, which we have been applying to all recent kernels. The patch is in PLM as patch id
# 1061. The issue is in BugMe as bug #94 . 
Without proper flock() we cannot stop and restart the database, which means we can't run the test. 
We've tried applying Wilcox's flock patch to -mm1, but it's doesn't go clean, and frankly we're not smart enough
to do the merge by hand -  lock code scares us. 

We just tested 2.5.61 vanilla, and 2.5.61-mm1. 

The patch applies cleanly to stock 2.5.61, and we can cycle the database.
We can't run dbt2 on stock 2.5.61, because of the scheduler bug. 
We believe the scheduler fix in -mm1 will be the ticket, but we can't try
it because of the flock() issue. So we're wedged. 
Can someone smarter than us maybe do a merge? 

thanks,
cliffw


