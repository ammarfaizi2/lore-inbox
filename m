Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVLKRyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLKRyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVLKRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:54:37 -0500
Received: from xenotime.net ([66.160.160.81]:53694 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750758AbVLKRyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:54:37 -0500
Date: Sun, 11 Dec 2005 09:55:06 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: ashutosh.naik@gmail.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-Id: <20051211095506.176a26ae.rdunlap@xenotime.net>
In-Reply-To: <20051210223453.24f7515b.akpm@osdl.org>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com>
	<20051210223453.24f7515b.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2005 22:34:53 -0800 Andrew Morton wrote:

> Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> >
> > Distribution:
> > Fedora Core 2, 2.6.15-rc5 kernel
> > 
> > Hardware Environment:
> > Acer Travelmate 240 ,Intel Celeron 2.6 Ghz, lspci with 2.6.14 attached
> > 
> > Description
> > I am getting an early kernel panic when I compiled the Kernel
> > 2.6.15-rc5 on my Acer Laptop. The dump is as follows. It is
> > reproducible every time on bootup.
> > 
> > Uncompressing Linux... Ok, booting the kernel.
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >  printing eip:
> > *pde = 00000000
> > Oops: 0002 [#1]
> > PREEMPT
> > Modules linked in :
> > CPU:    0
> > EIP:    0060:[<c020e494>]    Not tainted VLI
> > EFLAGS: 00010292   (2.6.15-rc5)
> > EIP is at kobject_add+0x94/0xd0
> > eax: c0455d80   ebx: c0455b4c   ecx: 00000000 edx: c0455b68
> > esi: ffffffea   edi: c0455d88   ebp: 00000000 esp: c6e8bf4c
> > ds: 007b es: 007b ss: 0068
> > Process swapper (pid = 1 threadinfo = c6e8a00 task = c6e88a50)
> > Stack : c0455b4c ffffffea c0455d20 c020e4f2 00000000 c0455b38 c0455b4c c0455b38
> >         c0455b4c c0294b12 c0455b4c c040e7c2 c03cdd36 c0455b38 00000000 00000000
> >         00000000 c0295542 00000000 c021fa65 c011d377 c0411638 00000000 c04ed0dc
> > Call Trace:
> >  [<c020e4f2>] kobject_register+0x22/0x70
> >  [<c0294b12>] bus_add_driver+0x52/0xc0
> >  [<c0295542>] driver_register+0x32/0x40
> >  [<c0214a65>] pcie_start_thread+0x15/0x60
> >  [<c011d377>] printk+0x17/0x20
> >  [<c04ed0dc>] pcied_init+0x1c/0xa0
> >  [<c04ed055>] pci_proc_init+0x65/0x70
> >  [<c04da83b>] do_init_calls+0x2b/0xc0
> >  [<c01002a0>] init+0x0/0x160
> >  [<c01002a0>] init+0x0/0x160
> >  [<c01002d7>] init+0x37/0x160
> >  [<c01013c9>] kernel_thread_helper+0x5/0xc
> > Code: 74 df 89 f8 e8 ce 02 00 00 eb d6 b8 01 00 00 00 e8 42 af f0 ff 85 ff 74 36
> >  8b 43 28 8d 53 1c 83 c0 08 89 43 1c 8b 48 04 89 50 04 <89> 11 89 4a 04 b8 01 00
> >  00 00 e8 5d af f0 ff b8 00 e0 ff ff 21
> >  <0>Kernel panic - not syncing: Attempted to kill init!
> > 
> 
> Looks like this:
> 
>                 list_add_tail(&kobj->entry,&kobj->kset->list);
> 
> went oops over null pointers in kobj->kset->list.
> 
> At a wild guess, I'd say that pcie_port_bus_register() hasn't run yet.

I reported this about 2 weeks ago.  Rajesh (iirc) says that it's a
timing issue and he is reworking some of the init code...
(like Greg said, it won't be fixed real quickly).

---
~Randy
