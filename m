Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVDZDSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDZDSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDZDSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:18:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:2210 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261198AbVDZDSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:18:32 -0400
Date: Mon, 25 Apr 2005 20:17:50 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       eike-kernel@sf-tec.de
Subject: Re: 2.6.12-rc2-mm3
Message-ID: <20050426031750.GA30088@kroah.com>
References: <20050411012532.58593bc1.akpm@osdl.org> <20050425174900.688f18fa.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425174900.688f18fa.rddunlap@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 05:49:00PM -0700, Randy.Dunlap wrote:
> On Mon, 11 Apr 2005 01:25:32 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> 
> I'm seeing some badness and a panic, goes away if I disable
> PCI Express.
> 
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> fakephp: Fake PCI Hot Plug Controller Driver
> Badness in kref_get at lib/kref.c:32
>  [<c1003368>] dump_stack+0x16/0x18
>  [<c10f7b32>] kref_get+0x28/0x32
>  [<c10f7173>] kobject_get+0x14/0x1c
>  [<c114b216>] get_bus+0x1a/0x2c
>  [<c114b0e1>] bus_add_driver+0x12/0x93
>  [<c13e67f7>] pcied_init+0x31/0x9d
>  [<c13da714>] do_initcalls+0x4e/0xa0
>  [<c10002a7>] init+0x25/0xce
>  [<c1000b09>] kernel_thread_helper+0x5/0xb
> Badness in kref_get at lib/kref.c:32
>  [<c1003368>] dump_stack+0x16/0x18
>  [<c10f7b32>] kref_get+0x28/0x32
>  [<c10f7173>] kobject_get+0x14/0x1c
>  [<c10f6d52>] kobject_init+0x2c/0x3f
>  [<c10f7024>] kobject_register+0x17/0x4f
>  [<c114b118>] bus_add_driver+0x49/0x93
>  [<c13e67f7>] pcied_init+0x31/0x9d
>  [<c13da714>] do_initcalls+0x4e/0xa0
>  [<c10002a7>] init+0x25/0xce
>  [<c1000b09>] kernel_thread_helper+0x5/0xb
> lib/kobject.c:171: spin_is_locked on uninitialized spinlock c133e1b8.

Hm, what happens if you disable the fakephp driver?  I haven't tried
that out with pci express.  Do you have pci express slots on this box?

thanks,

greg k-h
