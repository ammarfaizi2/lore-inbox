Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbTEaAgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 20:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTEaAgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 20:36:24 -0400
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:5129
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S264090AbTEaAgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 20:36:22 -0400
Date: Fri, 30 May 2003 17:52:47 -0700
From: Neil Schemenauer <nas@python.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH][CFT] new IO scheduler for 2.4.20
Message-ID: <20030531005247.GA646@glacier.arctrix.com>
References: <20030530220923.GA404@glacier.arctrix.com> <200305310940.41780.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305310940.41780.kernel@kolivas.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> How does this compare to akpm's read-latency2 patch that he posed some
> time ago? That seems to make a massive difference but was knocked back
> for style or approach.

It looks like they do fairly similar things.  Andrew's patch puts
unmergable read requests at a fixed distance from the front of the
queue.  My patch lets unmerged reads skip max((reads - writes), 0)
requests.  That's probably more fair when lots of reads and writes are
in queue.

Andrew's idea of always allowing a merge is probably a good idea and
could be adopted.

My patch uses a fixed deadline for requests (similar to Jen's deadline
scheduler).  I'm not sure if that's an advantage or not.  Note that the
deadline of writes are ignored when inserting a read.

I didn't change the size of the request queue.  I can't find where that
gets set in 2.4.20. :-(

Sorry for the hand-waving.  I didn't know about Andrew's patch and I
obviously didn't do enough testing yet.

  Neil
