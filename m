Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWFGAKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWFGAKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFGAKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:10:19 -0400
Received: from ns.suse.de ([195.135.220.2]:62908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751393AbWFGAKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:10:17 -0400
From: Andi Kleen <ak@suse.de>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 02:04:11 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com, miles.lane@gmail.com,
       jeremy@goop.org, linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606070134.29292.ak@suse.de> <20060606235551.GE11696@redhat.com>
In-Reply-To: <20060606235551.GE11696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070204.11909.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 01:55, Don Zickus wrote:
> > > So my question is/was what is the proper way to handle processor level
> > > subsystems during the suspend/resume path on an SMP system.  I really
> > > don't understand the hotplug path nor the suspend/resume path very
> > > well.
> >
> > Make it work properly for CPU hotplug for individual CPU and then in
> > suspend you take care of "global" state and the last CPU.
>
> So the assumption is treat all the cpus the same either all on or all off,
> no mixed mode (some cpus on, some cpus off).  I guess I was trying to hard
> to work on the per-cpu level.

No, mixed should work of course.

>
> > > I didn't want to register a hotplug handler because a hotplug event is
> > > really different than a suspend event (I want to _save_ info during a
> > > suspend event).  The documentation I was reading seemed to suggest that
> > > hotplug/suspend/smp was a work-in-progress.
> >
> > You need to disable the nmi watchdog on CPU hotunplug too,
> > it's no good to keep the NMI running.
>
> Don't you want to make sure those CPUs are actually sleeping.  :^D

That is what i meant - they can't sleep if the NMI keeps running.
Ok it would run only for a short time for local APIC, but longer
for io apic

-Andi
