Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWFFXvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWFFXvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWFFXvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:51:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751376AbWFFXvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:51:38 -0400
Date: Tue, 6 Jun 2006 19:55:51 -0400
From: Don Zickus <dzickus@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com, miles.lane@gmail.com,
       jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060606235551.GE11696@redhat.com>
References: <4480C102.3060400@goop.org> <20060606151507.613edaad.akpm@osdl.org> <20060606230504.GC11696@redhat.com> <200606070134.29292.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606070134.29292.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So my question is/was what is the proper way to handle processor level
> > subsystems during the suspend/resume path on an SMP system.  I really
> > don't understand the hotplug path nor the suspend/resume path very well.
> 
> Make it work properly for CPU hotplug for individual CPU and then in suspend
> you take care of "global" state and the last CPU.

So the assumption is treat all the cpus the same either all on or all off,
no mixed mode (some cpus on, some cpus off).  I guess I was trying to hard
to work on the per-cpu level.  
> 
> > I didn't want to register a hotplug handler because a hotplug event is
> > really different than a suspend event (I want to _save_ info during a
> > suspend event).  The documentation I was reading seemed to suggest that
> > hotplug/suspend/smp was a work-in-progress.
> 
> You need to disable the nmi watchdog on CPU hotunplug too,
> it's no good to keep the NMI running.

Don't you want to make sure those CPUs are actually sleeping.  :^D

-Don
> 
> 
> -Andi
