Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTDPEbW (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbTDPEbW 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 00:31:22 -0400
Received: from granite.he.net ([216.218.226.66]:34822 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264227AbTDPEbR 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 00:31:17 -0400
Date: Tue, 15 Apr 2003 21:45:26 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor - take 2
Message-ID: <20030416044525.GC15478@kroah.com>
References: <20030414190032.GA4459@kroah.com> <20030414224607.GC6411@kroah.com> <3E9C5B57.4020106@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9C5B57.4020106@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 12:19:51PM -0700, David Brownell wrote:
> Greg KH wrote:
> >Ok, based on the comments so far, how about this proposed version of
> >/sbin/hotplug to provide a multiplexor?
> 
> It'd be a reduction in functionality.  I could no longer just
> type "/sbin/hotplug" to see what agents disabled or missing ...
> or notice that since hotplugging was on, the problem had to be
> RH9 storing /bin/true into /proc/sys/kernel/hotplug again!  :P

Well you can still do that, the current scripts will get run that way
too.

> If the idea is just to loosen today's "one agent per event"
> rule (I've had that idea too), then wouldn't it be simpler to
> just (a1) pay an extra process context, not using "exec" to run
> /etc/hotplug/$1.agent, and when it returns (a2) THEN try other
> programs?  Or even (b) just modify appropriate agent scripts
> to do so, instead of /sbin/hotplug?
> 
> I'd think better about this problem if I had a handful of
> examples showing why category-specific or event-specific
> dispatch wouldn't be preferable.

udev is such an example.  I want it to run for every hotplug event.  To
do that with the current scripts, I have to either modify the current
scripts to always call it (not a big deal, I have CVS access :) or add a
handler for every type of device, and every type of those devices.

devlabel is also another type of example.  The author of that had to
persuade us to modify the scripts in order to get support for his
program.  I don't want to be a gating function, with this simple
proposal, he could just dump the devlabel script into the /etc/hotplug.d
directory in the proper place and everything would just work.

I've also been hearing from lots of other people (interestingly, not
publicly, I guess they like to stay hidden for some reason) that also
hook the hotplug scripts.  They have usually been either recommending
that their users patch the current script, or just replace the current
ones all together (thereby loosing the module load functionality) in
order to support their devices.  This proposal would also help them, and
their users.

thanks,

greg k-h
