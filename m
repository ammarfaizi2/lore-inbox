Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265669AbSJSTxa>; Sat, 19 Oct 2002 15:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSJSTxa>; Sat, 19 Oct 2002 15:53:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45812 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262145AbSJSTx2>; Sat, 19 Oct 2002 15:53:28 -0400
Date: Sat, 19 Oct 2002 12:59:27 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: andy barlak <andyb@island.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 scsi _eh_ buslogic
Message-ID: <20021019195926.GB2556@beaverton.ibm.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	andy barlak <andyb@island.net>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20021018224311.GB1066@beaverton.ibm.com> <Pine.LNX.3.96.1021019150909.29078A-300000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021019150909.29078A-300000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,
	In 2.5.44. I submitted a patch that changed the way scsi_host* is
	accessed. This patch also removed put_device which is replaced
	by device_unregister. That should fix one problem.

The other issue is that this driver like the BusLogic is using the old
error handler. Did it run on previous 2.5 versions?

If you go to 2.5.44 I believe you will also need the patch posted by
John Levon.


Bill Davidsen [davidsen@tmr.com] wrote:

> > > scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
> > >  error recovery: host 0 channel 0 id 3 lun 0
> > >   Vendor:           Model:                   Rev:
> > >   Type:   Direct-Access                      ANSI SCSI revision: 00

I am looking at this right now I believe when we offline a device we are
not setting the result if no action was performed on the command which
would happen if the device has no error handling.

> kernel BUG at drivers/base/core.c:269!
> invalid operand: 0000
> ncr53c8xx ide-scsi  
> CPU:    0
> EIP:    0060:[<c01e2d90>]    Not tainted
> EFLAGS: 00010202
> EIP is at put_device+0x50/0x80
> eax: 00000001   ebx: cf53b964   ecx: c03ee5d0   edx: cf53b9fc
> esi: cf948c98   edi: cf948c00   ebp: d08bf2e0   esp: cf60ff14
> ds: 0068   es: 0068   ss: 0068
> Process modprobe (pid: 332, threadinfo=cf60e000 task=cf7c7980)
> Stack: 00000000 cf53b800 c022b8c9 cf53b964 fffffff4 cfde6000 00000286 c014febe 
>        cfde6009 00000008 ff883e60 fffffffe c03bda00 00000000 c0138b4f c0138b66 
>        c12562a0 c12562a0 000001ff 00000000 c03be400 00000000 c0138ea2 c03bda00 
> Call Trace:
>  [<c022b8c9>] scsi_unregister_host+0x259/0x540
>  [<c014febe>] getname+0x5e/0xa0
>  [<c0138b4f>] buffered_rmqueue+0x12f/0x150
>  [<c0138b66>] buffered_rmqueue+0x146/0x150
>  [<c0138ea2>] __alloc_pages+0xb2/0x290
>  [<d08b988a>] exit_this_scsi_driver+0xa/0xc [ncr53c8xx]
>  [<d08bf2e0>] driver_template+0x0/0x80 [ncr53c8xx]
>  [<c011c07e>] free_module+0x1e/0xf0
>  [<c011b454>] sys_delete_module+0x154/0x2e0
>  [<c010736f>] syscall_call+0x7/0xb

2.5.44 scsi_unregister_host update to device_unregister should fix this
problem.


-andmike
--
Michael Anderson
andmike@us.ibm.com

