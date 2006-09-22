Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWIVUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWIVUNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWIVUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:13:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964882AbWIVUNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:13:37 -0400
Date: Fri, 22 Sep 2006 16:12:46 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922201246.GA10002@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060921131433.GA4182@elte.hu> <20060922130648.GD4055@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922130648.GD4055@ucw.cz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 01:06:48PM +0000, Pavel Machek wrote:

 > > would be nice to merge the -hrt queue that goes right ontop this queue. 
 > > Even if HIGH_RES_TIMERS is "default n" in the beginning. That gives us 
 > > high-res timers and dynticks which are both very important features to 
 > > certain classes of users/devices.
 > 
 > dynticks give benefit of 0.3W, or 20minutes (IIRC) from 8hours on thinkpad
 > x60... and they were around for way too long. (When baseline is
 > hz=250, it is 0.5W from hz=1000 baseline). It would be cool to
 > finally merge them.

I actually saw much bigger wins when I tested with an Athlon XP based compaq laptop
a year or so back. dynticks moved idle from being stuck at 21W to a sinusoidal
cycle in single watt increments between 22W->18W.  It would never stay in the
lower ranges for long because of timers firing all the time.

See http://kernelslacker.livejournal.com/33637.html for details.

There is much interest right now in fixing up various bits of userspace
to not do braindead things with timers/polling.  The gnome people
have recently come up with a timertop-esque hack (that goes a bit further)
for eg. See http://blogs.gnome.org/ryanl for details.
Arjan also recently did battle with a huge amount of really dumb userspace,
and dwmw2 has been tracking a bunch of these for OLPC:
https://bugzilla.redhat.com/bugzilla/showdependencytree.cgi?id=204948

Damn all these busy people making me feel inadequate :)

	Dave
