Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272410AbTGZD3n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 23:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272411AbTGZD3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 23:29:43 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:772 "EHLO
	lap") by vger.kernel.org with ESMTP id S272410AbTGZD3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 23:29:39 -0400
Date: Fri, 25 Jul 2003 05:41:41 -0600 (CST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@lap
To: linux-kernel@vger.kernel.org
Subject: Re: Presario oops on 2.6.0-test1
In-Reply-To: <Pine.LNX.4.44.0307200023450.1232-100000@lap>
Message-ID: <Pine.LNX.4.44.0307250518230.822-100000@lap>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This laptop is a Compaq Presario model 12XL325 with a 650 MHz Pentium 
III.
> The software is RedHat 8.0-based with updates necessary to run dev
> kernels, including the latest module-init-tools.  The last version I was
> able to test before the move was 2.5.73 which appeared to work as
> expected.  However, on the laptop I get a panic during bootup, at the
> point in the RedHat startup script (right after it prints the "Press I 
to
> enter interactive startup." message) where proc is mounted and kernel
> parameters are set using a sysctl command.  I tried selective commenting
> out of various script activity and was not able to narrow it down to a
> single thing.  I also tried using a simple init=/bin/bash and also got 
the
> same panic.  This appears to me to discount anything RedHat might be
> doing.  My laptop doesn't have a serial port and I don't have a null 
modem
> cable with USB connectors, so I had to take a picture of the screen.
> Therefore I had to type in the following by hand and errors are 
possible.
>
> It gives me Unable to handle kernel paging request at virtual address
> c035800
> *pde = 00102027
> *pte = 00358000
>
> Oops: 0000[#1]
> CPU:    0
> EIP:    0060:[<C014CE95>]    Not tainted
> EFLAGS: 00010002
> EIP is at store_stackinfo+0x85/0xc0


I have an update to this.  I went back and tested various kernel 
revisions.  The above panic started happening in 2.5.74-bk1.  This appears 
to be where the store_stackinfo function was added, protected by 
CONFIG_DEBUG_PAGEALLOC.  Sure enough, building a 2.6.0-test1 with the same 
configuration minus page allocation debugging produces a kernel which 
boots without the above panic.  However, now I get the following oops, 
which at least makes it into the message log.  This oops happens during 
bootup, followed a minute or two later by a followon oops which I am 
unable to capture.  The oops does not happen with every boot 
unfortunately.

Jul 25 04:54:24 lap last message repeated 2 times
Jul 25 04:54:24 lap kernel: Unable to query/initialize Synaptics hardware.
Jul 25 04:54:24 lap kernel: input: PS/2 Synaptics TouchPad on 
isa0060/serio1
Jul 25 04:54:24 lap kernel: slab error in cache_free_debugcheck(): cache 
`size-32': double free, or memory before object was overwritten
Jul 25 04:54:24 lap kernel: Call Trace:
Jul 25 04:54:24 lap kernel:  [<c014f130>] kfree+0xf0/0x310
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c025560d>] serio_handle_events+0xad/0xc0
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255665>] serio_thread+0x45/0x100
Jul 25 04:54:24 lap kernel:  [<c010a126>] work_resched+0x5/0x16
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:24 lap kernel:
Jul 25 04:54:24 lap kernel: slab error in cache_free_debugcheck(): cache 
`size-32': double free, or memory after  object was overwritten
Jul 25 04:54:24 lap kernel: Call Trace:
Jul 25 04:54:24 lap kernel:  [<c014f15e>] kfree+0x11e/0x310
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c02540fc>] psmouse_disconnect+0x2c/0x40
Jul 25 04:54:24 lap kernel:  [<c025560d>] serio_handle_events+0xad/0xc0
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255665>] serio_thread+0x45/0x100
Jul 25 04:54:24 lap kernel:  [<c010a126>] work_resched+0x5/0x16
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c0255620>] serio_thread+0x0/0x100
Jul 25 04:54:24 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:24 lap kernel:
Jul 25 04:54:24 lap kernel: synaptics reset failed
Jul 25 04:54:24 lap last message repeated 2 times
Jul 25 04:54:24 lap kernel: Synaptics Touchpad, model: 1
Jul 25 04:54:24 lap kernel:  Firware: 4.6
Jul 25 04:54:24 lap kernel:  Sensor: 15
Jul 25 04:54:24 lap kernel:  new absolute packet format
Jul 25 04:54:24 lap kernel:  Touchpad has extended capability bits
Jul 25 04:54:24 lap kernel:  -> four buttons
Jul 25 04:54:24 lap kernel:  -> multifinger detection
Jul 25 04:54:24 lap kernel:  -> palm detection
Jul 25 04:54:24 lap kernel: input: Synaptics Synaptics TouchPad on 
isa0060/serio1
Jul 25 04:54:24 lap kernel: Slab corruption: start=c11c3d34, 
expend=c11c3d53, problemat=c11c3d34
Jul 25 04:54:24 lap kernel: Last user: [<c010c4ae>](request_irq+0x5e/0xd0)
Jul 25 04:54:24 lap kernel: Data: 10 63 25 C0 00 00 00 04 00 00 00 00 89 
8D 2D C0 20 A4 38 C0 00 00 00 00 .......A5
Jul 25 04:54:24 lap kernel: Next: A5 C2 0F 17 AE C4 10 C0 A5 C2 0F 17 00 
00 00 00 00 00 00 00 0D F0 AD BA 00 00 00 00 ....
Jul 25 04:54:25 lap kernel: slab error in check_poison_obj(): cache 
`size-32': object was modified after freeing
Jul 25 04:54:25 lap kernel: Call Trace:
Jul 25 04:54:25 lap kernel:  [<c014cb7c>] check_poison_obj+0x17c/0x1d0
Jul 25 04:54:25 lap kernel:  [<c014ed39>] __kmalloc+0x169/0x1d0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f92f>] enable_cpucache+0x6f/0xa0
Jul 25 04:54:25 lap kernel:  [<c014d2ff>] kmem_cache_create+0x56f/0x640
Jul 25 04:54:25 lap kernel:  [<c0366f54>] ip_rt_init+0x64/0x3f0
Jul 25 04:54:25 lap kernel:  [<c026a2ef>] 
neigh_sysctl_register+0x14f/0x1b0
Jul 25 04:54:25 lap kernel:  [<c03673a7>] ip_init+0x17/0x20
Jul 25 04:54:25 lap kernel:  [<c0367f26>] inet_init+0x176/0x210
Jul 25 04:54:25 lap kernel:  [<c03547ab>] do_initcalls+0x2b/0xa0
Jul 25 04:54:25 lap kernel:  [<c0137432>] init_workqueues+0x12/0x30
Jul 25 04:54:25 lap kernel:  [<c0105068>] init+0x28/0x150
Jul 25 04:54:25 lap kernel:  [<c0105040>] init+0x0/0x150
Jul 25 04:54:25 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:25 lap kernel:
Jul 25 04:54:25 lap kernel: slab error in cache_alloc_debugcheck_after(): 
cache `size-32': memory before object was overwritten
Jul 25 04:54:25 lap kernel: Call Trace:
Jul 25 04:54:25 lap kernel:  [<c014ecc3>] __kmalloc+0xf3/0x1d0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f92f>] enable_cpucache+0x6f/0xa0
Jul 25 04:54:25 lap kernel:  [<c014d2ff>] kmem_cache_create+0x56f/0x640
Jul 25 04:54:25 lap kernel:  [<c0366f54>] ip_rt_init+0x64/0x3f0
Jul 25 04:54:25 lap kernel:  [<c026a2ef>] 
neigh_sysctl_register+0x14f/0x1b0
Jul 25 04:54:25 lap kernel:  [<c03673a7>] ip_init+0x17/0x20
Jul 25 04:54:25 lap kernel:  [<c0367f26>] inet_init+0x176/0x210
Jul 25 04:54:25 lap kernel:  [<c03547ab>] do_initcalls+0x2b/0xa0
Jul 25 04:54:25 lap kernel:  [<c0137432>] init_workqueues+0x12/0x30
Jul 25 04:54:25 lap kernel:  [<c0105068>] init+0x28/0x150
Jul 25 04:54:25 lap kernel:  [<c0105040>] init+0x0/0x150
Jul 25 04:54:25 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:25 lap kernel:
Jul 25 04:54:25 lap kernel:
Jul 25 04:54:25 lap kernel: slab error in cache_alloc_debugcheck_after(): 
cache `size-32': memory after object was overwritten
Jul 25 04:54:25 lap kernel: Call Trace:
Jul 25 04:54:25 lap kernel:  [<c014eceb>] __kmalloc+0x11b/0x1d0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f62c>] do_tune_cpucache+0x22c/0x4c0
Jul 25 04:54:25 lap kernel:  [<c014f92f>] enable_cpucache+0x6f/0xa0
Jul 25 04:54:25 lap kernel:  [<c014d2ff>] kmem_cache_create+0x56f/0x640
Jul 25 04:54:25 lap kernel:  [<c0366f54>] ip_rt_init+0x64/0x3f0
Jul 25 04:54:25 lap /sbin/hotplug: no runnable 
/etc/hotplug/pcmcia_socket.agent is installed
Jul 25 04:54:25 lap kernel:  [<c026a2ef>] 
neigh_sysctl_register+0x14f/0x1b0
Jul 25 04:54:25 lap pcmcia: Starting PCMCIA services:
Jul 25 04:54:25 lap kernel:  [<c03673a7>] ip_init+0x17/0x20
Jul 25 04:54:25 lap kernel:  [<c0367f26>] inet_init+0x176/0x210
Jul 25 04:54:25 lap kernel:  [<c03547ab>] do_initcalls+0x2b/0xa0
Jul 25 04:54:25 lap kernel:  [<c0137432>] init_workqueues+0x12/0x30
Jul 25 04:54:25 lap kernel:  [<c0105068>] init+0x28/0x150
Jul 25 04:54:25 lap kernel:  [<c0105040>] init+0x0/0x150
Jul 25 04:54:25 lap kernel:  [<c01073b9>] kernel_thread_helper+0x5/0xc
Jul 25 04:54:25 lap kernel:
Jul 25 04:54:25 lap kernel: IP: routing cache hash table of 128 buckets, 
4Kbytes


