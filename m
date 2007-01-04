Return-Path: <linux-kernel-owner+w=401wt.eu-S932324AbXADINE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbXADINE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbXADINE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:13:04 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:45489
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbXADINB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:13:01 -0500
Date: Thu, 4 Jan 2007 00:12:50 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070104081250.GA1572@gnuppy.monkey.org>
References: <20070104012709.GC31943@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C01A4FC37@fmsmsx414.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D2C22909C6E774EBFB8B5583AE5291C01A4FC37@fmsmsx414.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 06:14:11PM -0800, Chen, Tim C wrote:
> Bill Huey (hui) wrote:
> http://mmlinux.sf.net/public/patch-2.6.20-rc2-rt2.3.lock_stat.patch
> > If you can rerun it and post the results, it'll hopefully show the
> > behavior of that lock acquisition better.
> 
> Here's the run with fix to produce correct statistics.
> 
> Tim
> 
> @contention events = 848858
> @failure_events = 10
> @lookup_failed_scope = 175
> @lookup_failed_static = 47
> @static_found = 17
...
> [112584, 150, 6 -- 256, 0]              {init, kernel/futex.c, 2781}
> [597012, 183895, 136277 -- 9546, 0]             {mm_init, kernel/fork.c,
> 369}

Interesting. The second column means that those can be adaptively spun
on to prevent the blocking from happening. That's roughly 1/3rd of the
blocking events that happen (second/first). Something like that would
help out, but the problem is that contention on that lock in the first
place.

Also, Linux can do a hell of a lot of context switches per second. Is
the number of total contentions (top figure) in that run consistent with
the performance degradation ? and how much the reduction of those events
by 1/3rd would help out with the benchmark ? Those are the questions in
my mind at this moment.

bill

