Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHPAhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHPAhe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHPAhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:37:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2710 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750734AbWHPAhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:37:33 -0400
Date: Tue, 15 Aug 2006 20:37:28 -0400
From: Dave Jones <davej@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: peculiar suspend/resume bug.
Message-ID: <20060816003728.GA3605@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060815221035.GX7612@redhat.com> <1155687599.3193.12.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155687599.3193.12.camel@nigel.suspend2.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:19:59AM +1000, Nigel Cunningham wrote:
 > Hi Dave.
 > 
 > On Tue, 2006-08-15 at 18:10 -0400, Dave Jones wrote:
 > > Here's a fun one.
 > > - Get a dual core cpufreq aware laptop (Like say, a core-duo)
 > > - Add a cpufreq monitor to gnome-panel. Configure it
 > >   to watch the 2nd core.
 > > - Suspend.
 > > - Resume.
 > > 
 > > Watch the cpufreq monitor die horribly.
 > > 
 > > I believe this is because we take down the 2nd core at suspend
 > > time with cpu hotplug, and for some reason we're scheduling
 > > userspace before we bring that second core back up.
 > > 
 > > Anyone have any clues why this is happening?
 > 
 > If you hotunplug and replug the cpu using the sysfs interface, rather
 > than suspending and resuming, does the same thing happen?

cpufreq-applet crashes as soon as the cpu goes offline.
Now, the applet should be written to deal with this scenario more
gracefully, but I'm questioning whether or not userspace should
*see* the unplug/replug that suspend does at all.

IMO, when we shouldn't schedule userspace until the system is
in the exact state it was before we suspended.

		Dave

-- 
http://www.codemonkey.org.uk
