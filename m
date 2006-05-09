Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWEIFtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWEIFtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWEIFtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:49:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63109 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751399AbWEIFtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:49:40 -0400
Date: Tue, 9 May 2006 11:15:56 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
Message-ID: <20060509054556.GG784@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44601933.2040905@yahoo.com.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 02:23:15PM +1000, Nick Piggin wrote:
> Balbir Singh wrote:
> 
> >On Mon, May 08, 2006 at 02:19:52PM -0700, Andrew Morton wrote:
> >
> >>Balbir Singh <balbir@in.ibm.com> wrote:
> >>
> >>>@@ -550,6 +550,12 @@ struct task_delay_info {
> >>>	 * Atomicity of updates to XXX_delay, XXX_count protected by
> >>>	 * single lock above (split into XXX_lock if contention is an issue).
> >>>	 */
> >>>+
> >>>+	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
> >>>+	u64 blkio_delay;	/* wait for sync block io completion */
> >>>+	u64 swapin_delay;	/* wait for swapin block io completion */
> >>>+	u32 blkio_count;
> >>>+	u32 swapin_count;
> >>>
> >>These fields are a bit mystifying.
> >>
> >>In what units are blkio_delay and swapin_delay?
> >>
> >>What is the meaning behind blkio_count and swapin_count?
> >>
> >>Better comments needed, please.
> >>
> >
> >Will add more detailed comments and send them as updates.
> >
> 
> What kinds of usages will this stuff see? Will the CONFIG be usually 
> turned on,
> with some tasks occasionally using the statistics?
> 
> In which case, might it be better to make each delay collector in its 
> own data
> structure { .list; .start; .end; .delay; .count; .private; .name }, and 
> allocate
> them and hang them off the task structure when they're in use?
> 
> Or even put them in their own data structure (a small hash or something).
> 
> OTOH if they're often going to be in use by many tasks, then what you 
> have might
> be the best option.
> 
> Nick
> 
> Send instant messages to your online friends http://au.messenger.yahoo.com 

I expect/hope that the CONFIG will be turned on. There is a boot
option (called delayacct) to enable/disable the statistics collection.
Once turned on and enabled, all tasks will be filling in/using the statistics.


	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
