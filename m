Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946236AbWJSRIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946236AbWJSRIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946248AbWJSRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:07:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946236AbWJSRH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:07:26 -0400
Date: Thu, 19 Oct 2006 10:03:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Message-Id: <20061019100342.4e4895fb.akpm@osdl.org>
In-Reply-To: <200610191645.40308.m.kozlowski@tuxland.pl>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<200610191645.40308.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 16:45:39 +0200
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	Multiple of verif were found with 2.6.19-rc2-mm1 kernel:
> 
> slab error in verify_redzone_free(): cache `size-32': memory outside object 
> was overwritten
>  [<c0103765>] dump_trace+0x1c1/0x1f1
>  [<c01037af>] show_trace_log_lvl+0x1a/0x30
>  [<c0103ed8>] show_trace+0x12/0x14
>  [<c0103f7b>] dump_stack+0x19/0x1b
>  [<c0158357>] __slab_error+0x26/0x28
>  [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
>  [<c0158bb0>] kfree+0x54/0xa5
>  [<c037fba4>] ioctl_standard_call+0x187/0x2a1
>  [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
>  [<c03763d4>] dev_ioctl+0x1fd/0x372
>  [<c036b080>] sock_ioctl+0x34/0x1e8
>  [<c0167a92>] do_ioctl+0x22/0x71
>  [<c0167b36>] vfs_ioctl+0x55/0x29b
>  [<c0167daf>] sys_ioctl+0x33/0x50
>  [<c0102ff5>] sysenter_past_esp+0x56/0x79
>  [<b7f4e410>] 0xb7f4e410
>  =======================
> dd20cb64: redzone 1:0x170fc2a5, redzone 2:0x170fc200.
> slab error in verify_redzone_free(): cache `size-32': memory outside object 
> was overwritten
>  [<c0103765>] dump_trace+0x1c1/0x1f1
>  [<c01037af>] show_trace_log_lvl+0x1a/0x30
>  [<c0103ed8>] show_trace+0x12/0x14
>  [<c0103f7b>] dump_stack+0x19/0x1b
>  [<c0158357>] __slab_error+0x26/0x28
>  [<c0158496>] cache_free_debugcheck+0x13d/0x1d8
>  [<c0158bb0>] kfree+0x54/0xa5
>  [<c037fba4>] ioctl_standard_call+0x187/0x2a1
>  [<c037ffe6>] wireless_process_ioctl+0x328/0x3c7
>  [<c03763d4>] dev_ioctl+0x1fd/0x372
>  [<c036b080>] sock_ioctl+0x34/0x1e8
>  [<c0167a92>] do_ioctl+0x22/0x71
>  [<c0167b36>] vfs_ioctl+0x55/0x29b
>  [<c0167daf>] sys_ioctl+0x33/0x50 
>  [<c0102ff5>] sysenter_past_esp+0x56/0x79
>  [<b7f4e410>] 0xb7f4e410

The wireless ioctls are still blowing up?  I thought we'd fixed that,
or is this something new?

> Full dmesg and config attached. System info:
> 
> Linux orion 2.6.19-rc2 #3 PREEMPT Thu Oct 19 16:04:17 CEST 2006 i686 Intel(R) 
> Pentium(R) 4 CPU 2.40GHz GNU/Linux
>  
> Gnu C                  4.1.1
> Gnu make               3.81
> binutils               2.16.1
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.2.2
> e2fsprogs              1.39
> pcmcia-cs              3.2.8
> nfs-utils              1.0.6
> Linux C Library        > libc.2.4
> Dynamic linker (ldd)   2.4
> Procps                 3.2.6
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.94
> udev                   087
> Modules Loaded         orinoco_cs orinoco hermes pcmcia firmware_class 
> yenta_socket rsrc_nonstatic pcmcia_core
> 
> Regards,
> 
> 	Mariusz Kozlowski
> 
