Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUKOVa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUKOVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUKOV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:28:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:9671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbUKOV1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:27:52 -0500
Date: Mon, 15 Nov 2004 13:27:49 -0800
From: Chris Wright <chrisw@osdl.org>
To: Dean Nelson <dcn@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041115132749.N2357@build.pdx.osdl.net>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041115203343.GA32173@sgi.com>; from dcn@sgi.com on Mon, Nov 15, 2004 at 02:33:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dean Nelson (dcn@sgi.com) wrote:
> On Mon, Nov 15, 2004 at 10:58:01AM -0800, Chris Wright wrote:
> > * Dean Nelson (dcn@sgi.com) wrote:
> > > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> > 
> > this should be static.
> 
> You're right. I made another change in that one now passes the task_struct
> pointer to sched_setscheduler() instead of the pid. This requires that
> the caller of sched_setscheduler() hold the tasklist_lock. The new patch
> for people's feedback follows.

This now means callers of sched_setscheduler hold tasklist_lock, also
with irq off.  I think it's safer to let the core function do that.
It's a touchy area that's ripe for deadlock.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
