Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVDEB52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDEB52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 21:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDEB52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 21:57:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:35519 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261530AbVDEB5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 21:57:23 -0400
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
From: Li Shaohua <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <20050404153345.GC3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com>
	 <20050404052844.GB3611@otto>
	 <1112593338.4194.362.camel@sli10-desk.sh.intel.com>
	 <20050404153345.GC3611@otto>
Content-Type: text/plain
Message-Id: <1112666106.17861.62.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Apr 2005 09:55:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, 2005-04-04 at 23:33, Nathan Lynch wrote:
> 
> I'd say fix the smpboot code so that it doesn't create new idle tasks
> except during boot.
I'd like the the CPU hotremove case just likes the case that CPU isn't
boot. A non-boot CPU hasn't a idle thread. But you may think it's not
worthy doing. Anyway, I will keep the idle thread in a updated patch
like what you said.

> > > We've been
> > > doing cpu removal on ppc64 logical partitions for a while and never
> > > needed to do anything like this. 
> > Did it remove idle thread? or dead cpu is in a busy loop of idle?
> 
> Neither.  The cpu is definitely offline, but there is no reason to
> free the idle thread.
> 
> > 
> > >  Maybe idle_task_exit would suffice?
> > idle_task_exit seems just drop mm. We need destroy the idle task for
> > physical CPU hotplug, right?
> 
> No.
> 
> > > 
> > > I don't understand the need for this, either.  The existing cpu
> > > hotplug notifier in the scheduler takes care of initializing the sched
> > > domains and groups appropriately for online/offline events; why do you
> > > need to touch the runqueue structures?
> > If a CPU is physically hotremoved from the system, shouldn't we clean
> > its runqueue?
> 
> No.  It should make zero difference to the scheduler whether the "play
> dead" cpu hotplug or "physical" hotplug is being used.  
Keeping some fields like 'cpu_load' are meanless for a hotadded CPU to
me. Just ignore them?

Thanks,
Shaohua

