Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424321AbWKQFWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424321AbWKQFWN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162362AbWKQFWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:22:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162361AbWKQFWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:22:12 -0500
Date: Thu, 16 Nov 2006 21:21:58 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sleeping functions called in invalid context during resume
Message-ID: <20061116212158.0ef99842@localhost.localdomain>
In-Reply-To: <20061115180436.GB29795@elte.hu>
References: <20061114223002.10c231bd@localhost.localdomain>
	<20061115012025.13c72fc1.akpm@osdl.org>
	<20061115093354.GA30813@elte.hu>
	<20061115100119.460b7a4e@localhost.localdomain>
	<20061115180436.GB29795@elte.hu>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > Lots of sleeping while atomic warnings on 2.6.19-rc5
> > During resume I see the following:
> > 
> > 
> > platform floppy.0: EARLY resume
> > APIC error on CPU0: 00(00)
> > PM: Finishing wakeup.
> > BUG: sleeping function called from invalid context at drivers/base/power/resume.c:99
> > in_atomic():1, irqs_disabled():0
> > 
> > Call Trace:  
> >  [<ffffffff80266117>] show_trace+0x34/0x47
> >  [<ffffffff8026613c>] dump_stack+0x12/0x17
> >  [<ffffffff803734e5>] device_resume+0x19/0x51
> >  [<ffffffff80292157>] enter_state+0x19b/0x1b5
> >  [<ffffffff802921cf>] state_store+0x5e/0x79
> >  [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
> >  [<ffffffff80215059>] vfs_write+0xce/0x174
> >  [<ffffffff802159a5>] sys_write+0x45/0x6e
> >  [<ffffffff802593de>] system_call+0x7e/0x83  
> > DWARF2 unwinder stuck at system_call+0x7e/0x83
> > 

Ingo, the later version of your lockdep patch (with the x86_64 fix), worked.
There is nothing locked during these errors.

The problem was the APIC error is leaving preempt-disabled.

I have no idea what causes:

APIC error on CPU0: 00(00)

Is it an ACPI problem?

