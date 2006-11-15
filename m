Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966715AbWKOJUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966715AbWKOJUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966716AbWKOJUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:20:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966715AbWKOJUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:20:36 -0500
Date: Wed, 15 Nov 2006 01:20:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: sleeping functions called in invalid context during resume
Message-Id: <20061115012025.13c72fc1.akpm@osdl.org>
In-Reply-To: <20061114223002.10c231bd@localhost.localdomain>
References: <20061114223002.10c231bd@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 22:30:02 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Lots of sleeping while atomic warnings on 2.6.19-rc5
> During resume I see the following:
> 
> 
> platform floppy.0: EARLY resume
> APIC error on CPU0: 00(00)
> PM: Finishing wakeup.
> BUG: sleeping function called from invalid context at drivers/base/power/resume.c:99
> in_atomic():1, irqs_disabled():0
> 
> Call Trace:
>  [<ffffffff80266117>] show_trace+0x34/0x47
>  [<ffffffff8026613c>] dump_stack+0x12/0x17
>  [<ffffffff803734e5>] device_resume+0x19/0x51
>  [<ffffffff80292157>] enter_state+0x19b/0x1b5
>  [<ffffffff802921cf>] state_store+0x5e/0x79
>  [<ffffffff802cc157>] sysfs_write_file+0xc5/0xf8
>  [<ffffffff80215059>] vfs_write+0xce/0x174
>  [<ffffffff802159a5>] sys_write+0x45/0x6e
>  [<ffffffff802593de>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> Leftover inexact backtrace:

Could mean that someone somewhere forgot to release a spinlock.

Ingo had a patch which would find the culprit (preempt-tracing.patch).

Does it still live?
