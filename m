Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJWCuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJWCuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:50:00 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:4288 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261602AbTJWCt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:49:56 -0400
Message-ID: <3F97418E.5080304@cyberone.com.au>
Date: Thu, 23 Oct 2003 12:48:46 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Fredrik Tolf <fredrik@dolda2000.com>
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Elevator bug in concert with usb-storage
References: <16279.15393.575929.983297@pc7.dolda2000.com>
In-Reply-To: <16279.15393.575929.983297@pc7.dolda2000.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fredrik Tolf wrote:

>Hello,
>
>I believe that there is a bug in the usb-storage code. I'm using
>2.6.0-test8-mm1, but I have experienced this in essentially all
>2.6.0-test* kernels. Mostly anytime when I remove a usb-storage device
>(especially before umounting it), I get a SEGV followed by general
>unstability in the SCSI subsys.
>
>After doing some research, I believe it is because the I/O scheduler
>is released before the SCSI subsys stops using it. Here is the SEGV
>report:
>
>Unable to handle kernel NULL pointer dereference at virtual address 00000001
> printing eip:
>00000001
>*pde = 00000000
>Oops: 0000 [#1]
>PREEMPT 
>CPU:    0
>EIP:    0060:[<00000001>]    Not tainted VLI
>EFLAGS: 00010202
>EIP is at 0x1
>eax: d8b83180   ebx: dafc4e00   ecx: 00000000   edx: dafc4e00
>esi: dafc4e10   edi: c03465e0   ebp: d990fe64   esp: d990fe58
>ds: 007b   es: 007b   ss: 0068
>Process umount (pid: 1744, threadinfo=d990e000 task=d8ba4080)
>Stack: c02173d7 dafc4e00 d8b83180 d990fe78 c0218f5d dafc4e00 df774800 c03465b0 
>       d990fe8c e0952fb5 dafc4e00 db8e3ca0 c03465b0 d990fe9c e0953f83 df774800 
>       00000000 d990feac c021480a df774980 df7749a8 d990fec4 c01c26e3 df7749a8 
>Call Trace:
> [<c02173d7>] elevator_exit+0x2d/0x3c
> [<c0218f5d>] blk_cleanup_queue+0x65/0x70
> [<e0952fb5>] scsi_free_sdev+0x11f/0x15a [scsi_mod]
> [<e0953f83>] scsi_device_dev_release+0x15/0x22 [scsi_mod]
> [<c021480a>] device_release+0x1a/0x60
> [<c01c26e3>] kobject_cleanup+0x63/0x70
> [<e094eb1c>] scsi_device_put+0x68/0xa6 [scsi_mod]
> [<e08a94cb>] sd_release+0x27/0x46 [sd_mod]
> [<c01569c5>] blkdev_put+0x1a7/0x1bc
> [<c015698f>] blkdev_put+0x171/0x1bc
> [<c015566b>] kill_block_super+0x25/0x2c
> [<c01548c7>] deactivate_super+0x67/0xae
> [<c01686c2>] sys_umount+0x36/0x84
> [<c014e9c5>] filp_close+0x43/0x66
> [<c016871d>] sys_oldumount+0xd/0x10
> [<c02bafeb>] syscall_call+0x7/0xb
>
>Code:  Bad EIP value.
>
>It seems as if the elevator_exit_fn is set to 1, and there is a
>message logged just before the SEGV report spits out that an I/O
>scheduler is released, which makes me draw the conclusion that the
>kernel tries to free the I/O scheduler twice.
>
>My apologies for taking up your time if this is a known a fixed
>problem. However, if it is, can you point me to some information on
>how to remedy it?
>

James is having a look at refounting issues now. So it will be fixed.



