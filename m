Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUHJSuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUHJSuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHJSsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:48:10 -0400
Received: from ida.rowland.org ([192.131.102.52]:32772 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267545AbUHJSqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:46:40 -0400
Date: Tue, 10 Aug 2004 14:46:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Norbert Preining <preining@logic.at>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
In-Reply-To: <20040810171809.GA4217@gamma.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.4.44L0.0408101439320.7558-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Norbert Preining wrote:

> Ok, here are two new ones with 2.6.8-rc4-mm1: The one from lsusb, the
> other from cat /proc/bus/usb/devices ...
> 
> 
> lsusb         D C0CE8B00     0  2605      1          2611  2351 (NOTLB)
> d71f0eec 00000086 00000000 c0ce8b00 c015a30d 08088000 d71f0ef0 00000000 
>        000f83ad 98a6d31f 0000007b dfb8b110 dfb8b2b8 c0d2f024 00000282 d71f0000 
>        dfb8b110 c02d9d6b c0d2f02c 00000001 dfb8b110 c0118fd7 c0d2f02c c0d2f02c 
> Call Trace:
>  [<c015a30d>] link_path_walk+0xa56/0xd91
>  [<c02d9d6b>] __down+0x8b/0x122
>  [<c0118fd7>] default_wake_function+0x0/0xc
>  [<c0205ffc>] get_device+0xe/0x14
>  [<e08cf8ae>] usb_get_dev+0x12/0x16 [usbcore]
>  [<c02d9f68>] __down_failed+0x8/0xc
>  [<e08da6c5>] .text.lock.devio+0x5/0x150 [usbcore]
>  [<c014cdeb>] dentry_open+0xfe/0x210
>  [<c014d8ee>] vfs_read+0xa9/0xf5
>  [<c014db4c>] sys_read+0x47/0x76
>  [<c0105e4f>] syscall_call+0x7/0xb
> 
> cat           D 80000180     0  3902   3131                     (NOTLB)
> d6c23e0c 00000086 d6c26530 80000180 c15dbe80 d702cc00 80000180 d2c0b840 
>        00163790 8d5506e2 000000ff d50fee70 d50ff018 e08e58ac d6c23e1c d50fee70 
>        e08e58ac c02daa87 00000409 e08e58b0 e08e58b0 e08e58b0 d50fee70 00000001 
> Call Trace:
>  [<c02daa87>] rwsem_down_read_failed+0x8f/0x191
>  [<e08dc5cb>] .text.lock.devices+0x7/0x98 [usbcore]
>  [<e08dbbc7>] usb_dump_interface+0x38/0x79 [usbcore]
>  [<e08dbcfc>] usb_dump_config+0x91/0xcc [usbcore]
>  [<e08dbfa7>] usb_dump_desc+0x94/0xad [usbcore]
>  [<e08dc12e>] usb_device_dump+0x16e/0x2fa [usbcore]
>  [<e08dc3b6>] usb_device_read+0xfc/0x12f [usbcore]
>  [<c014d8ee>] vfs_read+0xa9/0xf5
>  [<c014db4c>] sys_read+0x47/0x76
>  [<c0105e4f>] syscall_call+0x7/0xb

Maybe the -mm series didn't get my USB device locking patches fully
reverted.  They certainly didn't get fully corrected, because the patch
for that was never accepted.  Your traces do make it look as though this
is the problem.

Check in drivers/usb/core/usb.c and see if it mentions
usb_all_devices_rwsem anywhere.  I'd do it myself, but I don't know _any_
way to get hold of a single source file from a particular kernel tree,
other than the ones currently visible via the web at bkbits.net.  :-(

Alan Stern

