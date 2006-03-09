Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWCIKfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWCIKfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCIKfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:35:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751796AbWCIKfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:35:00 -0500
Date: Thu, 9 Mar 2006 02:32:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.16-rc5-mm3 -- BUG: sleeping function called from invalid
 context at include/linux/rwsem.h:43 in_atomic():0, irqs_disabled():1
Message-Id: <20060309023234.02ba4517.akpm@osdl.org>
In-Reply-To: <a44ae5cd0603082253sfb4a1e1q687c56a6f6a386fb@mail.gmail.com>
References: <a44ae5cd0603082253sfb4a1e1q687c56a6f6a386fb@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miles Lane" <miles.lane@gmail.com> wrote:
>
> Apologies.  This bug caused my video to get messed up.  I was able to
> run Gnome, but the apps weren't rendering correctly, so I couldn't be
> sure my subject line was correct.
> I would have edited out some of the context info, but that was tough
> as well.  Here's the BUG message by itself.  Perhaps all the dmesg
> output in the previous message will be helpful.
> As you can see in the dmesg output, I hit this by suspending and
> resuming.  I am running Fedora Core 5 Test 3 + all yum updates.
> Andrew, the full dmesg output is in the LKML message with the subject
> line set to "v".  Let me know if you would like me to send it directly
> to you.
> 
> BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
>  <c1003f81> show_trace+0xd/0xf   <c100401b> dump_stack+0x17/0x19
>  <c1015f77> __might_sleep+0x86/0x90   <c1024738>
> blocking_notifier_call_chain+0x1b/0x4d
>  <c1183bb2> cpufreq_resume+0xf5/0x11d   <c112b27c> __sysdev_resume+0x23/0x57
>  <c112b3c9> sysdev_resume+0x19/0x4b   <c112f736> device_power_up+0x8/0xf
>  <c1033339> swsusp_suspend+0x6e/0x8b   <c1033918> pm_suspend_disk+0x51/0xf3
>  <c10328c7> enter_state+0x53/0x1c1   <c1032abe> state_store+0x89/0x97
>  <c108af00> subsys_attr_store+0x20/0x25   <c108b020> sysfs_write_file+0xb5/0xdc
>  <c1056578> vfs_write+0xab/0x154   <c1056aa3> sys_write+0x3b/0x60
>  <c1002b43> syscall_call+0x7/0xb
> PM: Image restored success

ho-hum.  That's swsusp insisting on running things which it shouldn't run
with local interrupts disabled.

I wouldn't expect this to cause the display to get mucked up though.
