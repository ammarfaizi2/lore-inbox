Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWAULmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWAULmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWAULmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:42:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8559 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932150AbWAULmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:42:11 -0500
Date: Sat, 21 Jan 2006 12:44:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
Subject: Re: Fall back io scheduler for 2.6.15?
Message-ID: <20060121114408.GS13429@suse.de>
References: <200601141113_MC3-1-B5DA-F6EC@compuserve.com> <20060116084336.GO3945@suse.de> <43D1D134.5070401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D1D134.5070401@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21 2006, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Sat, Jan 14 2006, Chuck Ebbert wrote:
> >
> >>In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>
> >>
> >>On Fri, 13 Jan 2006, Andrew Morton wrote:
> >>
> >>
> >>>OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> >>
> >>As of 2.6.15 you need to use "anticipatory" instead of "as".
> >>
> >>Maybe this patch would help?
> >>
> >>Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> >>
> >>--- 2.6.15a.orig/block/elevator.c
> >>+++ 2.6.15a/block/elevator.c
> >>@@ -150,6 +150,13 @@ static void elevator_setup_default(void)
> >>	if (!chosen_elevator[0])
> >>		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
> >>
> >>+	/*
> >>+	 * Be backwards-compatible with previous kernels, so users
> >>+	 * won't get the wrong elevator.
> >>+	 */
> >>+	if (!strcmp(chosen_elevator, "as"))
> >>+		strcpy(chosen_elevator, "anticipatory");
> >>+
> >> 	/*
> >> 	 * If the given scheduler is not available, fall back to no-op.
> >> 	 */
> >
> >
> >We probably should apply this, since it used to be 'as'.
> >
> 
> Just out of curiousity, why did 'as' get renamed to 'anticipatory'?

Side effect really, not intentional. 'as' always registered itself with
the elevator core as "anticipatory", the logic to match elevator=foo
string to scheduler used to be completely seperate prior to the addition
of online switchable elevators. So when those two were tied together,
the "as" disappeared. I guess the right thing to do at that time was to
rename "anticipatory", but that didn't happen...

-- 
Jens Axboe

