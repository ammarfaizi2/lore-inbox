Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDEANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDEANb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 20:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDDWzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:55:04 -0400
Received: from orb.pobox.com ([207.8.226.5]:20903 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261455AbVDDWq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:46:28 -0400
Date: Mon, 4 Apr 2005 17:46:20 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [RFC 5/6]clean cpu state after hotremove CPU
Message-ID: <20050404224620.GD3611@otto>
References: <1112580367.4194.344.camel@sli10-desk.sh.intel.com> <20050404052844.GB3611@otto> <1112593338.4194.362.camel@sli10-desk.sh.intel.com> <20050404153345.GC3611@otto> <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112652864.3757.31.camel@desktop.cunningham.myip.net.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel!

On Tue, Apr 05, 2005 at 08:14:25AM +1000, Nigel Cunningham wrote:
> 
> On Tue, 2005-04-05 at 01:33, Nathan Lynch wrote:
> > > Yes, exactly. Someone who understand do_exit please help clean up the
> > > code. I'd like to remove the idle thread, since the smpboot code will
> > > create a new idle thread.
> > 
> > I'd say fix the smpboot code so that it doesn't create new idle tasks
> > except during boot.
> 
> Would that mean that CPUs that were physically hotplugged wouldn't get
> idle threads?

No, that wouldn't work.  I am saying that there's little to gain by
adding all this complexity for destroying the idle tasks when it's
fairly simple to create num_possible_cpus() - 1 idle tasks* to
accommodate any additional cpus which may come along.  This is what
ppc64 does now, and it should be feasible on any architecture which
supports cpu hotplug.


Nathan

* num_possible_cpus() - 1 because the idle task for the boot cpu is
  created in sched_init.
