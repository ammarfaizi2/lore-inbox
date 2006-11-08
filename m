Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754311AbWKHFf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbWKHFf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbWKHFf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:35:28 -0500
Received: from xenotime.net ([66.160.160.81]:50611 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1754308AbWKHFf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:35:27 -0500
Date: Tue, 7 Nov 2006 21:35:32 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Bryce Harrington <bryce@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       vatsa@in.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       shaohua.li@intel.com, hotplug_sig@osdl.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-Id: <20061107213532.a0db2aae.rdunlap@xenotime.net>
In-Reply-To: <20061023222624.GG6555@osdl.org>
References: <20060316174447.GA8184@in.ibm.com>
	<20060316170814.02fa55a1.akpm@osdl.org>
	<20060317084653.GA4515@in.ibm.com>
	<20060317010412.3243364c.akpm@osdl.org>
	<20061006231012.GH22139@osdl.org>
	<20061007215749.GC4277@ucw.cz>
	<20061009144024.6364b6ba.rdunlap@xenotime.net>
	<20061023222624.GG6555@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 15:26:24 -0700 Bryce Harrington wrote:

> On Mon, Oct 09, 2006 at 02:40:24PM -0700, Randy Dunlap wrote:
> > On Sat, 7 Oct 2006 21:57:49 +0000 Pavel Machek wrote:
> > 
> > > Hi!
> > > 
> > > > 1.  Oops offlining cpu twice on AMD64 (but not on EM64t)
> > > >     with the 2.6.18-git22 kernel
> > > > 
> > > >     Reported to hotplug lists 10/05:
> > > >       http://lists.osdl.org/pipermail/hotplug_sig/2006-October/000680.html
> > > > 
> > > >     To recreate: offline, online, and then offline a CPU, then oopses
> > > >       http://crucible.osdl.org/runs/2397/sysinfo/amd01.console
> > > >       http://crucible.osdl.org/runs/2397/sysinfo/amd01.2/proc/config
> > > > 
> > > >     Here's a snippet of the oops:
> > > > 
> > > > # echo 0 > /sys/devices/system/cpu/cpu1/online
> > > > 
> > > >  Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
> > > >  [<ffffffff80255287>] __drain_pages+0x29/0x5f
> > > > PGD 7e56d067 PUD 7ee80067 PMD 0
> > > > Oops: 0000 [1] PREEMPT SMP
> > > > CPU 0
> > > > Modules linked in:
> > > > Pid: 7203, comm: bash Tainted: G   M  2.6.18-git22 #1
> > >                                  ~~~~~
> > > kernel is unhappy here. Forced module unload?
> > 
> > Machine check exception.  'G' is Good, same place where 'P'
> > for proprietary would be.  But yes, kernel or machine is unhappy.
> 
> To followup on this issue...
> 
> I found a BIOS update for the motherboard of this machine indicating it
> includes a fix for MCE during hibernate operations; my guess is that
> cpu hotplug may be triggering this bug.
> 
> Meanwhile, we checked against a couple other different AMD64 systems;
> these are behaving correctly.
> 
> Anyway, thanks for the pointers, it sounds like this is probably just a
> hardware issue.  I'll report back if I find differently.

Regarding the MCE (that the BIOS update did not fix for this one
particular machine), I don't see the actual Machine Check Exception
kernel message log anywhere.  It would have happened before the
oops that is printed by this CPU hotplug test.  Is the complete
kerne log available or can it be reproduced?

---
~Randy
