Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWFGAhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWFGAhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFGAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:37:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23471 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750752AbWFGAhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:37:50 -0400
Date: Tue, 6 Jun 2006 20:42:17 -0400
From: Don Zickus <dzickus@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       shaohua.li@intel.com, miles.lane@gmail.com, jeremy@goop.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060607004217.GF11696@redhat.com>
References: <4480C102.3060400@goop.org> <200606070134.29292.ak@suse.de> <20060606235551.GE11696@redhat.com> <200606071005.14307.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606071005.14307.ncunningham@linuxmail.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:05:07AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 07 June 2006 09:55, Don Zickus wrote:
> > > > So my question is/was what is the proper way to handle processor level
> > > > subsystems during the suspend/resume path on an SMP system.  I really
> > > > don't understand the hotplug path nor the suspend/resume path very
> > > > well.
> > >
> > > Make it work properly for CPU hotplug for individual CPU and then in
> > > suspend you take care of "global" state and the last CPU.
> >
> > So the assumption is treat all the cpus the same either all on or all off,
> > no mixed mode (some cpus on, some cpus off).  I guess I was trying to hard
> > to work on the per-cpu level.
> 
> This sounds wrong to me. Shouldn't the the effect of hotunplugging a cpu be to 
> put the driver in a state equivalent to if that cpu simply didn't exist? 
> Unplugging shouldn't assume we're going to subsequently have either a driver 
> suspend, or a replug.

This is my biggest problem or maybe my complete lack of understanding, is
that I don't know how to determine what state I am in during a hotplug
event, either a cpu removal or a suspend.  Therefore I feel like I have to
store some persistant data around _just_ in case this is a suspend event.
Also at the opposite end, how to separate a cpu insert vs. a cpu resume.
The different being initialize to a global state vs. initialize to a last
known state.  

I thought it would make more sense if a few more states were to the
hotplug event list.  For example, in addition to CPU_ONLINE and CPU_DEAD,
there could also be something like CPU_SUSPEND, CPU_FREEZE, CPU_RESUME,
and CPU_THAW.  

Anyway, I am probably complicating the matter.  I'll whip something up and
post it for review.

Cheers,
Don

> 
> Regards,
> 
> Nigel
> -- 
> Nigel, Michelle and Alisdair Cunningham
> 5 Mitchell Street
> Cobden 3266
> Victoria, Australia


