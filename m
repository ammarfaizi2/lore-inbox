Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWEJKYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWEJKYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWEJKYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:24:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6624 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964894AbWEJKYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:24:41 -0400
Date: Wed, 10 May 2006 15:50:55 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: [PATCH][delayacct] Add comments on units for the delay fields (was Re: [Patch 2/8] Sync block I/O and swapin delay collection)
Message-ID: <20060510102055.GD29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508141952.2d4b9069.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:19:52PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > @@ -550,6 +550,12 @@ struct task_delay_info {
> >  	 * Atomicity of updates to XXX_delay, XXX_count protected by
> >  	 * single lock above (split into XXX_lock if contention is an issue).
> >  	 */
> > +
> > +	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
> > +	u64 blkio_delay;	/* wait for sync block io completion */
> > +	u64 swapin_delay;	/* wait for swapin block io completion */
> > +	u32 blkio_count;
> > +	u32 swapin_count;
> 
> These fields are a bit mystifying.
> 
> In what units are blkio_delay and swapin_delay?
> 
> What is the meaning behind blkio_count and swapin_count?
> 
> Better comments needed, please.

Hi, Andrew,

Here is an update, that adds comments to the fields as suggested in the
review comments

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Changelog

1. Add comments to the task_delay_info structure, documenting the units
   of delay and document the meaning of the count fields in the structure.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/sched.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN include/linux/sched.h~task-delay-add-comments-on-units include/linux/sched.h
--- linux-2.6.17-rc3/include/linux/sched.h~task-delay-add-comments-on-units	2006-05-10 14:35:46.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/sched.h	2006-05-10 14:43:39.000000000 +0530
@@ -553,11 +553,18 @@ struct task_delay_info {
 	 * single lock above (split into XXX_lock if contention is an issue).
 	 */
 
+	/*
+	 * XXX_count is incremented on every XXX operation, the delay
+	 * associated with the operation is added to XXX_delay.
+	 * XXX_delay contains the accumulated delay time in nanoseconds.
+	 */
 	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
 	u64 blkio_delay;	/* wait for sync block io completion */
 	u64 swapin_delay;	/* wait for swapin block io completion */
-	u32 blkio_count;
-	u32 swapin_count;
+	u32 blkio_count;	/* total count of the number of sync block */
+				/* io operations performed */
+	u32 swapin_count;	/* total count of the number of swapin block */
+				/* io operations performed */
 };
 #endif	/* CONFIG_TASK_DELAY_ACCT */
 
_
