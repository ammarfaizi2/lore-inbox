Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUEKKxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUEKKxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 06:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUEKKxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 06:53:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22750 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262766AbUEKKxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 06:53:20 -0400
Date: Wed, 6 Oct 2004 16:20:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at include/linux/dcache.h:277!
Message-ID: <20041006105039.GC2004@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200405110037.13819@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405110037.13819@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:44:40PM +0000, Alexander Gran wrote:
[snip]
> - ------------[ cut here ]------------
> kernel BUG at include/linux/dcache.h:277!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c015bf2a>]    Tainted: PF  VLI
> EFLAGS: 00010246   (2.6.6-mm1)
> EIP is at d_alloc+0x13f/0x17f
> eax: 00000000   ebx: d15dd6b4   ecx: 00000000   edx: cdc2b474
> esi: cdc2b474   edi: d15dd72a   ebp: df55fe70   esp: df55fe30
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 452, threadinfo=df55f000 task=c169ae50)
> Stack: cdc2b474 df55fe70 cdc2b474 00000000 c0153107 fffffff4 cdc2b474 00000000
>        dc2f5418 c015403b df55fe70 baf3f719 cdc2b474 c042172f e1d65220 c0174f60
>        baf3f719 c0421729 00000006 00000001 e1d65220 d99fd330 e1d651c0 c0174f92
> Call Trace:
>  [<c0153107>] cached_lookup+0x6e/0x76
>  [<c015403b>] __lookup_hash+0x74/0xac
>  [<c0174f60>] sysfs_get_dentry+0x5d/0x64
>  [<c0174f92>] sysfs_hash_and_remove+0x2b/0x171
>  [<c029e131>] class_device_del+0x70/0xa1
>  [<e1d5bb47>] hci_unregister_dev+0x8/0x90 [bluetooth]
>  [<e1d4c9bc>] hci_usb_disconnect+0x2f/0x6f [hci_usb]
>  [<e18e0b74>] usb_disable_interface+0x28/0x35 [usbcore]
>  [<e18db0b8>] usb_unbind_interface+0x60/0x62 [usbcore]
>  [<c029d77d>] device_release_driver+0x56/0x58
>  [<c029d874>] bus_remove_device+0x48/0x84
>  [<c029cae4>] device_del+0x5a/0x8f
>  [<c029cb21>] device_unregister+0x8/0x10
>  [<e18e0be2>] usb_disable_device+0x61/0xa5 [usbcore]
>  [<e18dba91>] usb_disconnect+0x90/0xd7 [usbcore]
>  [<e18ddc57>] hub_port_connect_change+0x247/0x26d [usbcore]
>  [<e18dd154>] hub_port_status+0x3c/0xa8 [usbcore]
>  [<c03dc19a>] schedule+0x282/0x475
>  [<e18ddf09>] hub_events+0x28c/0x2fd [usbcore]
>  [<e18ddfa5>] hub_thread+0x2b/0xd8 [usbcore]
>  [<c0113086>] default_wake_function+0x0/0xc
>  [<e18ddf7a>] hub_thread+0x0/0xd8 [usbcore]
>  [<c0103a49>] kernel_thread_helper+0x5/0xb
> 


It looks like parent kobject is gone before the child can be deleted. Do you
see similar problem in 2.6.6 also?

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
