Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWHFTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWHFTdG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHFTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:33:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751339AbWHFTdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:33:05 -0400
Date: Sun, 6 Aug 2006 12:32:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: davej@redhat.com, torvalds@osdl.org, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
 /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-Id: <20060806123243.826105fc.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	<Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	<20060804222400.GC18792@redhat.com>
	<20060805003142.GH18792@redhat.com>
	<20060805021051.GA13393@redhat.com>
	<20060805022356.GC13393@redhat.com>
	<20060805024947.GE13393@redhat.com>
	<20060805064727.GF13393@redhat.com>
	<6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 18:59:54 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> caller is lock_cpu_hotplug+0x25/0xc5
>  [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
>  [<c029fa95>] store+0x37/0x48
>  [<c0104007>] show_trace_log_lvl+0x58/0x159
>  [<c0104765>] show_trace+0xd/0x10
>  [<c010482d>] dump_stack+0x19/0x1b
>  [<c01fc842>] debug_smp_processor_id+0x96/0xac
>  [<c01a8197>] sysfs_write_file+0xa6/0xcc
>  [<c013e0db>] lock_cpu_hotplug+0x25/0xc5
>  [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
>  [<c029fa95>] store+0x37/0x48
>  [<c01a8197>] sysfs_write_file+0xa6/0xcc
>  [<c0171577>] vfs_write+0xcd/0x179
>  [<c0171c20>] sys_write+0x3b/0x71
>  [<c010318d>] sysenter_past_esp+0x56/0x8d
> DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Leftover inexact backtrace:
>  [<c0104765>] show_trace+0xd/0x10
>  [<c010482d>] dump_stack+0x19/0x1b
>  [<c01fc842>] debug_smp_processor_id+0x96/0xac
>  [<c013e0db>] lock_cpu_hotplug+0x25/0xc5
>  [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
>  [<c029fa95>] store+0x37/0x48
>  [<c01a8197>]  [<c0171577>] vfs_write+0xcd/0x179
> 
> It's from 2.6.18-rc3-mm2.

This "unwinder stuck" thing seems to be very common.

It's a false-positive in this case - the backtrace was complete.  It would
be good if we could make the did-we-get-stuck detector a bit smarter.  Even
special-casing "sysenter_past_esp" would stop a lot of this..
