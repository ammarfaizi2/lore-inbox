Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933711AbWKQQaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711AbWKQQaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933713AbWKQQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:30:39 -0500
Received: from [65.172.181.25] ([65.172.181.25]:6109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933711AbWKQQai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:30:38 -0500
Date: Fri, 17 Nov 2006 08:30:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061117083008.7758149a@localhost.localdomain>
In-Reply-To: <200611171646.05860.rjw@sisk.pl>
References: <20061114223002.10c231bd@localhost.localdomain>
	<20061116212158.0ef99842@localhost.localdomain>
	<20061117065202.GA11877@elte.hu>
	<200611171646.05860.rjw@sisk.pl>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 16:46:05 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 17 November 2006 07:52, Ingo Molnar wrote:
> > 
> > * Stephen Hemminger <shemminger@osdl.org> wrote:
> > 
> > > > > BUG: sleeping function called from invalid context at drivers/base/power/resume.c:99
> > > > > in_atomic():1, irqs_disabled():0
> > > > > 
> > > > > Call Trace:  
> > > > >  [<ffffffff80266117>] show_trace+0x34/0x47
> > > > >  [<ffffffff8026613c>] dump_stack+0x12/0x17
> > > > >  [<ffffffff803734e5>] device_resume+0x19/0x51
> > > > >  [<ffffffff80292157>] enter_state+0x19b/0x1b5
> > > > >  [<ffffffff802921cf>] state_store+0x5e/0x79
> > > > >  [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
> > > > >  [<ffffffff80215059>] vfs_write+0xce/0x174
> > > > >  [<ffffffff802159a5>] sys_write+0x45/0x6e
> > > > >  [<ffffffff802593de>] system_call+0x7e/0x83  
> > > > > DWARF2 unwinder stuck at system_call+0x7e/0x83
> > > > > 
> > > 
> > > Ingo, the later version of your lockdep patch (with the x86_64 fix), 
> > > worked. There is nothing locked during these errors.
> > > 
> > > The problem was the APIC error is leaving preempt-disabled.
> > 
> > ah, that could be the case - do you have a fix-patch for that?
> > 
> > preempt-disabled leaks are only caught via CONFIG_PREEMPT_TRACE (not via 
> > lockdep), which debug feature you can find in the -rt tree:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > (there's no easy standalone patch for now.)
> > 
> > it will be enabled if you select CONFIG_DEBUG_PREEMPT.
> > 
> > > I have no idea what causes:
> > > 
> > > APIC error on CPU0: 00(00)
> > > 
> > > Is it an ACPI problem?
> > 
> > a 00 error code? Never seen that ... How frequently does it happen?
> 
> On my x86-64 boxes the "APIC error on CPU0" message appears on every resume,
> but it doesn't seem to be related to any visible problems.
> 
> It's been there forever, AFAICT.

Yes, it is there on every resume.
