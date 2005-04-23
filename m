Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVDWWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVDWWhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDWWhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:37:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:14017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVDWWfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:35:38 -0400
Date: Sat, 23 Apr 2005 15:35:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Shaohua <shaohua.li@intel.com>, "Antonino A. Daplas" <adaplas@pol.net>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       zwane@linuxpower.ca, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-Id: <20050423153501.5286b6c6.akpm@osdl.org>
In-Reply-To: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	<20050412105115.GD17903@elf.ucw.cz>
	<1113309627.5155.3.camel@sli10-desk.sh.intel.com>
	<20050413083202.GA1361@elf.ucw.cz>
	<1113467253.2568.10.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Shaohua <shaohua.li@intel.com> wrote:
>
> CPU0 attaching NULL sched-domain.
> CPU1 attaching NULL sched-domain.
> CPU0 attaching NULL sched-domain.
> Booting processor 1/1 eip 3000
> Initializing CPU#1
> masked ExtINT on CPU#1
> Unable to handle kernel paging request at virtual address f000acb2
>  printing eip:
> c014e4cc
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP 
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c014e4cc>]    Not tainted VLI
> EFLAGS: 00010097   (2.6.12-rc2-mm3) 
> EIP is at check_poison_obj+0x4c/0x1e0
> eax: 0000006b   ebx: 0000005a   ecx: dff6e080   edx: dff6e480
> esi: 00000000   edi: f000acb2   ebp: 00000080   esp: c14fdcd4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c14fc000 task=dff42560)
> Stack: dff6e480 5a5a5a5a 5a5a5a5a 0000007f 5a5a5a5a 00000000 0000005a f000acae 
>        dff6e480 c021192e c0150031 dff6e480 f000acae 5a5a5a5a 5a5a5a5a dff6e480 
>        00000046 00000020 00000010 c015044b dff6e480 00000020 f000acae c021192e 
> Call Trace:
>  [<c021192e>] soft_cursor+0x5e/0x260
>  [<c0150031>] cache_alloc_debugcheck_after+0x181/0x1a0
>  [<c015044b>] __kmalloc+0x9b/0xd0
>  [<c021192e>] soft_cursor+0x5e/0x260
>  [<c021192e>] soft_cursor+0x5e/0x260
>  [<c020a459>] bit_cursor+0x339/0x540
>  [<c0118998>] recalc_task_prio+0x88/0x150
>  [<c0205c32>] fbcon_cursor+0x1a2/0x270
>  [<c0265475>] hide_cursor+0x25/0x40
>  [<c026843a>] vt_console_print+0x2aa/0x2b0
>  [<c0120d32>] __call_console_drivers+0x62/0x70
>  [<c0120e66>] call_console_drivers+0x96/0x130
>  [<c0121361>] release_console_sem+0x51/0xc0
>  [<c01211df>] vprintk+0x19f/0x250
>  [<c01264b6>] __do_softirq+0xd6/0xf0
>  [<c0438f5b>] preempt_schedule_irq+0x4b/0x80
>  [<c0121037>] printk+0x17/0x20
>  [<c0114132>] setup_local_APIC+0xe2/0x1d0
>  [<c01130ba>] smp_callin+0x7a/0x120
>  [<c011316e>] start_secondary+0xe/0x190
> Code: 24 30 89 14 24 01 c7 e8 13 f8 ff ff 39 44 24 14 89 c5 0f 8d b7 00 00 00 8d 40 ff 89 44 24 0c 3b 74 24 0c b0 6b 0f 84 8c 01 00 00 <38> 04 3e 74 46 8b 44 24 14 85 c0 0f 84 48 01 00 00 89 3c 24 83 
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
>

fbcon is trying to call kmalloc before the slab system is initialised. 
It would be best to fix that within fbcon.


> > Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
> > 00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
> > a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
> >  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> >  Stuck ??
> > Inquiring remote APIC #0...
> > ... APIC #0 ID: 00000000
> > ... APIC #0 VERSION: 00040011
> > ... APIC #0 SPIV: 000000ff
> > root@hobit:/sys/devices/system/cpu/cpu1#
> Andrew,
> Below patch fixed Pavel's oops. But strange is the 'system_state' check
> is added for CPU hotplug by Rusty. This really makes me confused. Could
> you please look at it.

Well as the comment says, if this CPU isn't online yet, and if the system
has not yet reached SYSTEM_RUNNING state then we bale out of the printk
because this cpu's per-cpu resources may not yet be fully set up.


> This can be reproduced 100% with radeonfb driver load. Attached is the
> dmesg of an oops. It seems the 'objp' parameter for
> 'cache_alloc_debugcheck_after' is invalid.
> 
> --- a/kernel/printk.c	2005-04-12 10:12:19.000000000 +0800
> +++ b/kernel/printk.c	2005-04-13 17:22:40.912897328 +0800
> @@ -624,8 +624,7 @@ asmlinkage int vprintk(const char *fmt, 
>  			log_level_unknown = 1;
>  	}
>  
> -	if (!cpu_online(smp_processor_id()) &&
> -	    system_state != SYSTEM_RUNNING) {
> +	if (!cpu_online(smp_processor_id())) {
>  		/*
>  		 * Some console drivers may assume that per-cpu resources have
>  		 * been allocated.  So don't allow them to be called by this
> 

That being said, I don't see why your patch should fix the oops.  The test
(system_state != SYSTEM_RUNNING) should be returning true at this time.


