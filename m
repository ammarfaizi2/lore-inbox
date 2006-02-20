Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWBTW6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWBTW6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBTW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:58:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50304 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964810AbWBTW6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:58:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
Date: Mon, 20 Feb 2006 23:58:21 +0100
User-Agent: KMail/1.9.1
Cc: MIke Galbraith <efault@gmx.de>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9DB1D.4090305@aitel.hist.no> <1140449123.7563.2.camel@homer>
In-Reply-To: <1140449123.7563.2.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202358.22732.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 16:25, MIke Galbraith wrote:
> On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
> > pentium IV single processor, gcc (GCC) 4.0.3 20060128
> > 
> > During boot, I normally get:
> > parport0: irq 7 detected
> > lp0: using parport0 (polling).
> > 
> > Instead, I got this, written by hand:
> 
> ........
> 
> > This oops is simplified. I can get the exact text if
> > that really matters.  It is much more to write down and
> > I don't usually have my camera at work.
> 
> I get the same, and already have the serial console hooked up.

Similar thing on x86-64 (Asus L5D), but less drastic.  I can boot, but get:

Unable to handle kernel NULL pointer dereference at 00000000000001bc RIP: 
<ffffffff8024f7dc>{kref_get+12}
PGD 2c788067 PUD 2c796067 PMD 0 
Oops: 0000 [1] PREEMPT 
last sysfs file: /block/hdc/range
CPU 0 
Modules linked in: parport_pc lp parport dm_mod
Pid: 1452, comm: modprobe Not tainted 2.6.16-rc4-mm1 #56
RIP: 0010:[<ffffffff8024f7dc>] <ffffffff8024f7dc>{kref_get+12}
RSP: 0018:ffff81002c7bbca8  EFLAGS: 00010292
RAX: ffff81002acd8970 RBX: 00000000000001bc RCX: ffff81002acd8000
RDX: ffff81002acd8977 RSI: ffffffff803af6a6 RDI: 00000000000001bc
RBP: ffff81002c7bbcb8 R08: 0000000000000000 R09: ffff81002acd8970
R10: 0000000000000001 R11: 2222222222222222 R12: ffffffff803af69f
R13: ffff81002c7641f0 R14: 00000000fffffff4 R15: ffff81002a574160
FS:  00002b1185fabb00(0000) GS:ffffffff8058a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000001bc CR3: 000000002de28000 CR4: 00000000000006e0
Process modprobe (pid: 1452, threadinfo ffff81002c7ba000, task ffff81002fecf830)
Stack: ffff81002c7bbcd8 00000000000001a0 ffff81002c7bbcd8 ffffffff8024eb4a 
       ffff81002c7641f0 ffff81002acd89a8 ffff81002c7bbd18 ffffffff801c442d 
       00000000000001a0 ffff81002e76c5b0 
Call Trace: <ffffffff8024eb4a>{kobject_get+26} <ffffffff801c442d>{sysfs_create_link+173}
       <ffffffff802b6b76>{class_device_add+550} <ffffffff802b6cb9>{class_device_register+25}
       <ffffffff802b6dc2>{class_device_create+258} <ffffffff88016ce2>{:parport:parport_device_proc_register+242}
       <ffffffff88014207>{:parport:parport_register_device+663}
       <ffffffff88021040>{:lp:lp_preempt+0} <ffffffff88013abc>{:parport:parport_register_driver+44}
       <ffffffff8802174e>{:lp:lp_register+158} <ffffffff880217db>{:lp:lp_attach+75}
       <ffffffff88013adf>{:parport:parport_register_driver+79}
       <ffffffff880262a3>{:lp:lp_init_module+675} <ffffffff8014b9a4>{sys_init_module+212}
       <ffffffff80109cca>{system_call+126}

Code: 8b 07 85 c0 75 24 48 c7 c1 50 f3 37 80 ba 20 00 00 00 48 c7 
RIP <ffffffff8024f7dc>{kref_get+12} RSP <ffff81002c7bbca8>
CR2: 00000000000001bc
 BUG: modprobe/1452, lock held at task exit time!
 [ffffffff8801eb20] {registration_lock}
.. held by:          modprobe: 1452 [ffff81002fecf830, 116]
... acquired at:               parport_register_driver+0x2c/0x90 [parport]

and the thing called /sbin/udevstart ends up in the D state because of this.

Greetings,
Rafael
