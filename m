Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWBMM03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWBMM03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBMM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:26:28 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60382 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932406AbWBMM02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:26:28 -0500
Date: Mon, 13 Feb 2006 13:26:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213114612.GA30500@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131323520.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> > [...] and this patch doesn't break anything either.
> 
> your patch makes code larger on gcc3. Please investigate why.

The size change can actually go either way:

@@ -1826,7 +1826,7 @@
 00000000  w    F .text 00000006 sys_mq_timedsend
 00000000         *UND* 00000000 __per_cpu_offset
 00000000         *UND* 00000000 cpu_gdt_descr
-00000000 g     F .text 0000004f posix_cpu_clock_getres
+00000000 g     F .text 00000049 posix_cpu_clock_getres
 00000000 g     F .text 00000006 do_posix_clock_nonanosleep
 00000000 g     F .text 00000020 idle_cpu
 00000000 g     F .text 00000030 sys_chown16
@@ -2081,7 +2081,7 @@
 00000000  w    F .text 00000006 sys_epoll_ctl
 00000000 g     F .text 00000005 sys_syslog
 00000000         *UND* 00000000 cap_capset_check
-00000000 g     F .text 00000246 posix_cpu_nsleep
+00000000 g     F .text 00000251 posix_cpu_nsleep
 00000000 g     F .text 000000c6 sysctl_jiffies
 00000000 g     F .text 0000002e __wake_up_locked
 00000000         *UND* 00000000 module_arch_cleanup

The const _is_ bogus.

bye, Roman
