Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVDEJC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVDEJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVDEJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:02:59 -0400
Received: from fmr20.intel.com ([134.134.136.19]:6290 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261630AbVDEJC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:02:57 -0400
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
Message-Id: <1112691621.17861.80.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Apr 2005 17:00:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 23:33, Nathan Lynch wrote:
> > > 
> > > I don't understand why this is needed at all.  It looks like a fair
> > > amount of code from do_exit is being duplicated here.  
> > Yes, exactly. Someone who understand do_exit please help clean up the
> > code. I'd like to remove the idle thread, since the smpboot code will
> > create a new idle thread.
> 
> I'd say fix the smpboot code so that it doesn't create new idle tasks
> except during boot.
I tried what you said. But I must use a ugly method to adjust
idle->thread.esp (stack pointer in IA32). otherwise, the stack will soon
overflow after several rounds of hotplug. I'll take close look at if
other fields in thread_info cause problems.
Did you reinitialize the idle's thread_info in ppc? I have no problem to
do it in IA32, but is this a good approach? Creating a new idle thread
for upcoming CPU looks more graceful to me.

Thanks,
Shaohua

