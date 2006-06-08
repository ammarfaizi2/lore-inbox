Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWFHU2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWFHU2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFHU2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:28:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24337 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964911AbWFHU2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:28:09 -0400
Date: Thu, 8 Jun 2006 20:27:54 +0000
From: Pavel Machek <pavel@suse.cz>
To: Don Zickus <dzickus@redhat.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com,
       miles.lane@gmail.com, jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060608202754.GE4006@ucw.cz>
References: <4480C102.3060400@goop.org> <200606070134.29292.ak@suse.de> <20060606235551.GE11696@redhat.com> <200606071005.14307.ncunningham@linuxmail.org> <20060607004217.GF11696@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607004217.GF11696@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This sounds wrong to me. Shouldn't the the effect of hotunplugging a cpu be to 
> > put the driver in a state equivalent to if that cpu simply didn't exist? 
> > Unplugging shouldn't assume we're going to subsequently have either a driver 
> > suspend, or a replug.
> 
> This is my biggest problem or maybe my complete lack of understanding, is
> that I don't know how to determine what state I am in during a hotplug

Basically you can't/shouldn't determine that. 

> I thought it would make more sense if a few more states were to the
> hotplug event list.  For example, in addition to CPU_ONLINE and CPU_DEAD,
> there could also be something like CPU_SUSPEND, CPU_FREEZE, CPU_RESUME,
> and CPU_THAW.  
> 
> Anyway, I am probably complicating the matter.  I'll whip something up and
> post it for review.

I think you are overcomplicating this. Just forget about
suspend/resume, and reinit cpus from the scratch each time. It may
lead into some 'interesting' behaviour if someone tries to suspend
while profiling, but I believe we can live with that.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
