Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVDZQTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDZQTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVDZQRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:17:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:1227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbVDZQPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:15:51 -0400
Date: Tue, 26 Apr 2005 09:15:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, eike-kernel@sf-tec.de
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050426091537.2582529e.rddunlap@osdl.org>
In-Reply-To: <20050426031750.GA30088@kroah.com>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<20050425174900.688f18fa.rddunlap@osdl.org>
	<20050426031750.GA30088@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 20:17:50 -0700
Greg KH <greg@kroah.com> wrote:

> On Mon, Apr 25, 2005 at 05:49:00PM -0700, Randy.Dunlap wrote:
> > On Mon, 11 Apr 2005 01:25:32 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> > 
> > 
> > I'm seeing some badness and a panic, goes away if I disable
> > PCI Express.
> > 
> > pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> > fakephp: Fake PCI Hot Plug Controller Driver
> > Badness in kref_get at lib/kref.c:32
> >  [<c1003368>] dump_stack+0x16/0x18
> >  [<c10f7b32>] kref_get+0x28/0x32
> >  [<c10f7173>] kobject_get+0x14/0x1c
> >  [<c114b216>] get_bus+0x1a/0x2c
> >  [<c114b0e1>] bus_add_driver+0x12/0x93
> >  [<c13e67f7>] pcied_init+0x31/0x9d
> >  [<c13da714>] do_initcalls+0x4e/0xa0
> >  [<c10002a7>] init+0x25/0xce
> >  [<c1000b09>] kernel_thread_helper+0x5/0xb
> > Badness in kref_get at lib/kref.c:32
> >  [<c1003368>] dump_stack+0x16/0x18
> >  [<c10f7b32>] kref_get+0x28/0x32
> >  [<c10f7173>] kobject_get+0x14/0x1c
> >  [<c10f6d52>] kobject_init+0x2c/0x3f
> >  [<c10f7024>] kobject_register+0x17/0x4f
> >  [<c114b118>] bus_add_driver+0x49/0x93
> >  [<c13e67f7>] pcied_init+0x31/0x9d
> >  [<c13da714>] do_initcalls+0x4e/0xa0
> >  [<c10002a7>] init+0x25/0xce
> >  [<c1000b09>] kernel_thread_helper+0x5/0xb
> > lib/kobject.c:171: spin_is_locked on uninitialized spinlock c133e1b8.
> 
> Hm, what happens if you disable the fakephp driver?  I haven't tried
> that out with pci express.  Do you have pci express slots on this box?

Same still happens without fakephp (this is in pciehp_core).

Same OOPS still happens also (pcied_init near middle of stack trace).

No, I don't have *any* PCI Express slots....

-- 
~Randy
