Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVIUF5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVIUF5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 01:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVIUF5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 01:57:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750800AbVIUF5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 01:57:41 -0400
Date: Tue, 20 Sep 2005 22:56:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>
Subject: Re: one more oops on sensor modules removal
Message-Id: <20050920225647.167325f7.akpm@osdl.org>
In-Reply-To: <20050921004230.64ed395d@werewolf.able.es>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<20050921004230.64ed395d@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Fri, 16 Sep 2005 02:23:19 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)
> > 
> 
> Sep 20 23:55:58 werewolf kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000038
> Sep 20 23:55:58 werewolf kernel:  printing eip:
> Sep 20 23:55:58 werewolf kernel: b01baebb
> Sep 20 23:55:58 werewolf kernel: *pde = 00000000
> Sep 20 23:55:58 werewolf kernel: Oops: 0000 [#1]
> Sep 20 23:55:58 werewolf kernel: PREEMPT SMP
> Sep 20 23:55:58 werewolf kernel: last sysfs file: /class/vc/vcsa12/dev
> Sep 20 23:55:58 werewolf kernel: Modules linked in: soundcore w83627hf hwmon_vid hwmon i2c_isa i2c_i801 i2c_core ohci1394 eth1394 ieee1394 usblp e1000 3c59x usbhid intel_agp agpgart ide_floppy ehci_hcd uhci_hcd
> Sep 20 23:55:58 werewolf kernel: CPU:    1
> Sep 20 23:55:58 werewolf kernel: EIP:    0060:[kref_put+21/138]    Not tainted VLI
> Sep 20 23:55:58 werewolf kernel: EIP:    0060:[<b01baebb>]    Not tainted VLI
> Sep 20 23:55:58 werewolf kernel: EFLAGS: 00010206   (2.6.13-jam5)
> Sep 20 23:55:58 werewolf kernel: EIP is at kref_put+0x15/0x8a
> Sep 20 23:55:58 werewolf kernel: eax: 00000038   ebx: 00000038   ecx: b18ff400   edx: b01ba6de
> Sep 20 23:55:58 werewolf kernel: esi: b01ba6de   edi: 0805c178   ebp: ee03b000   esp: ee03bf54
> Sep 20 23:55:58 werewolf kernel: ds: 007b   es: 007b   ss: 0068
> Sep 20 23:55:58 werewolf kernel: Process modprobe (pid: 2070, threadinfo=ee03b000 task=ef384a90)
> Sep 20 23:55:58 werewolf kernel: Stack: ee50dea0 00000000 ee50de80 00000000 f0a86a00 00000000 b0132bd6 6e756f73
> Sep 20 23:55:58 werewolf kernel:        726f6364 b0140065 a7f03000 eeb89a80 b0149fc7 a7f03000 a7f04000 ef08e284
> Sep 20 23:55:58 werewolf kernel:        eeb89a80 eeb89ab0 ffff0001 ee03b000 b014a02d 00000004 00000000 0805c178
> Sep 20 23:55:58 werewolf kernel: Call Trace:
> Sep 20 23:55:58 werewolf kernel:  [sys_delete_module+296/356] sys_delete_module+0x128/0x164
> Sep 20 23:55:58 werewolf kernel:  [<b0132bd6>] sys_delete_module+0x128/0x164
> Sep 20 23:55:58 werewolf kernel:  [kmem_cache_create+1083/1748] kmem_cache_create+0x43b/0x6d4
> Sep 20 23:55:58 werewolf kernel:  [<b0140065>] kmem_cache_create+0x43b/0x6d4
> Sep 20 23:55:58 werewolf kernel:  [do_munmap+202/247] do_munmap+0xca/0xf7
> Sep 20 23:55:58 werewolf kernel:  [<b0149fc7>] do_munmap+0xca/0xf7
> Sep 20 23:55:58 werewolf kernel:  [sys_munmap+57/85] sys_munmap+0x39/0x55
> Sep 20 23:55:58 werewolf kernel:  [<b014a02d>] sys_munmap+0x39/0x55
> Sep 20 23:55:58 werewolf kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
> Sep 20 23:55:58 werewolf kernel:  [<b0102b53>] sysenter_past_esp+0x54/0x75
> Sep 20 23:55:58 werewolf kernel: Code: 24 2d b0 c7 04 24 3e ce 2d b0 e8 6b fc f5 ff e8 3e 8b f4 ff eb cd 56 53 83 ec 10 89 c3 89 d6 85 d2 74 3e 81 fa 39 0f 14 b0 74 61 <8b> 03 85 c0 74 1d f0 ff 0b 0f 94 c0 31 d2 84 c0 74 09 89 d8 ff
> 

Is 2.6.14-rc2 OK?

Please send the .config.
