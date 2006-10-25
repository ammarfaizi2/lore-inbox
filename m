Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161319AbWJYA44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWJYA44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWJYA4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:56:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16560 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161298AbWJYA4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:56:54 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200610250056.k9P0ujPY21429663@clink.americas.sgi.com>
Subject: Re: [patch] Mixed Madison and Montecito system support
To: tony.luck@intel.com (Luck, Tony)
Date: Tue, 24 Oct 2006 19:56:45 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061023205643.GA13990@intel.com> from "Luck, Tony" at Oct 23, 2006 01:56:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck wrote:
> 
> Cc: linux-kernel for generic bit of this change.  Rest of patch was
> posted to linux-ia64: http://marc.theaimsgroup.com/?l=linux-ia64&m=116070997529216&w=2
> 
> On Thu, Oct 12, 2006 at 10:25:58PM -0500, Russ Anderson wrote:
> >  int sched_create_sysfs_power_savings_entries(struct sysdev_class *cls)
> >  {
> > -	int err = 0;
> > +	int err = 0, c;
> >  
> >  #ifdef CONFIG_SCHED_SMT
> > -	if (smt_capable())
> > -		err = sysfs_create_file(&cls->kset.kobj,
> > +	for_each_online_cpu(c)
> > +		if (smt_capable(c)) {
> > +			err = sysfs_create_file(&cls->kset.kobj,
> >  					&attr_sched_smt_power_savings.attr);
> > +			break;
> > +		}
> >  #endif
> 
> What if you booted an all-Madison system, and then hot-plugged some
> Montecitos later?  Either we'd need the hotplug cpu code to run through
> this routine again to re-test whether any cpu has multi-thread support
> (it doesn't look like it does that now).
> 
> Or perhaps it would be simpler to dispense with this test and always
> call sysfs_create_file() here (still inside CONFIG_SCHED_SMT) so that
> the hook is always present to tune the scheduler (even if it may be
> ineffective on a no-smt system)?

I like that idea.  Any objections or comments?


-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
