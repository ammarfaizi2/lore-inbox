Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbSI1BRd>; Fri, 27 Sep 2002 21:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbSI1BRd>; Fri, 27 Sep 2002 21:17:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:35728 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262669AbSI1BRc>;
	Fri, 27 Sep 2002 21:17:32 -0400
Message-ID: <3D950465.9F4D2462@digeo.com>
Date: Fri, 27 Sep 2002 18:22:45 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Patrick Mochel <mochel@osdl.org>, Thomas Molina <tmolina@cox.net>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB23.9040109@easynet.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 01:22:45.0564 (UTC) FILETIME=[8CA1EFC0:01C2668D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck wrote:
> 
> With CONFIG_PREEMPT=y on an SMP AMD (2CPU):
> 
> Sleeping function called from illegal context at /kernel/l-2.5.39/include/asm/semaphore.h:119
> c1b75e20 c0117094 c0280b00 c028d480 00000077 c1b41cf0 c016bcf9 c028d480
>         00000077 c1b41c50 ffffffea c1b74000 00001000 c01937c6 c02e9578 c1b41cf0
>         c1b41c50 f7f0b840 c1b75eda c018ad0a c1b41c50 c02e9578 00000020 00000000
> Call Trace:
>   [<c0117094>]__might_sleep+0x54/0x58
>   [<c016bcf9>]driverfs_create_file+0x39/0xa0
>   [<c01937c6>]device_create_file+0x26/0x40
>   [<c018ad0a>]pci_pool_create+0xea/0x170
>   [<c02034af>]hcd_buffer_create+0x3f/0x80
>   [<c02039c3>]usb_hcd_pci_probe+0x253/0x370
>   [<c01563d8>]alloc_inode+0x58/0x190
>   [<c018b751>]pci_device_probe+0x41/0x60
>   [<c0191b88>]probe+0x18/0x30
>   [<c0191c2b>]found_match+0x2b/0x60
>   [<c0191d57>]do_driver_attach+0x37/0x50
>   [<c019296c>]bus_for_each_dev+0x9c/0x130
>   [<c0191d83>]driver_attach+0x13/0x20
>   [<c0191d20>]do_driver_attach+0x0/0x50
>   [<c0192ee4>]driver_register+0x94/0xb0
>   [<c018b856>]pci_register_driver+0x36/0x50
>   [<c01050b7>]init+0x47/0x1c0
>   [<c0105070>]init+0x0/0x1c0
>   [<c010553d>]kernel_thread_helper+0x5/0x18
> 

pci_pool_create() is calling device_create_file() under pools_lock.
