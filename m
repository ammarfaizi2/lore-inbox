Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWHNVXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWHNVXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWHNVXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:23:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36063 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964953AbWHNVXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:23:30 -0400
Date: Mon, 14 Aug 2006 17:22:00 -0400
From: Dave Jones <davej@redhat.com>
To: Ben B <kernel@bb.cactii.net>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814212200.GC30814@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben B <kernel@bb.cactii.net>, Andrew Morton <akpm@osdl.org>,
	Maciej Rutecki <maciej.rutecki@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net> <20060813232549.GG28540@redhat.com> <20060814115556.GA13159@cactii.net> <20060814202004.GE16280@redhat.com> <20060814211338.GA30680@cactii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814211338.GA30680@cactii.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 11:13:38PM +0200, Ben B wrote:
 > Dave Jones <davej@redhat.com> uttered the following thing:
 > >  > > > [  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310 [cpufreq_ondemand]
 > >  > > 
 > >  > > This makes no sense at all, because in -mm __create_workqueue doesn't
 > >  > > call lock_cpu_hotplug().
 > >  > > 
 > >  > > Are you sure this was from a tree with -mm1 applied ?
 > >  > 
 > >  > Definitely 2.6.18-rc4-mm1, and I've done a clean rebuild + removal of
 > >  > all modules under /lib/modules beforehand.
 > > 
 > > It's a real mystery.  Andrew ?
 > 
 > This seems to be specific to the ondemand governor - I just tried with
 > conservative, and alternating it with performance, with no problems, but
 > as soon as I loaded ondemand, the message appeared. It seems to fire off
 > the message as soon as I either set the governor to ondemand, or revert
 > it from ondemand to something else. But going from, eg performance to
 > conservative, wont give the message, even with ondemand loaded.

on-demand is unique in the sense that its the only governor that
creates a workqueue.

 > I wonder if this might also be related to my 1.83GHz cpu only being set
 > to a maximum of 1.33GHz via cpufreq? cpuinfo_max_freq is correct, but
 > scaling_max_freq is wrong. Though doing "cat cpuinfo_max_freq >
 > scaling_max_freq" has fixed it up, it should be correct already.

That's come up a lot lately. I'm still of the opinion that something
changed in acpi that's the explanation for this.

		Dave

-- 
http://www.codemonkey.org.uk
