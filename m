Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUEJVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUEJVSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUEJVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 17:18:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:9958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbUEJVSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 17:18:31 -0400
Date: Mon, 10 May 2004 14:18:29 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Richard A Nelson <cowboy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?)
Message-Id: <20040510141829.467a2bb6@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet>
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be easier to know what is wrong, if you said what you
did that started the problem.  Looks like ifrename or something
like that.


On Mon, 10 May 2004 16:59:54 -0400 (EDT)
Richard A Nelson <cowboy@debian.org> wrote:

> : divert: allocating divert_blk for dummy0
> : Unable to handle kernel NULL pointer dereference at virtual address 00000000
> :  printing eip:
> : c016dcad
> : *pde = 00000000
> :        ___      ______
> :       0--,|    /OOOOOO\
> :      {_o  /  /OO plop OO\
> :        \__\_/OO oh dear OOO\s
> :           \OOOOOOOOOOOOOOOO/
> :            __XXX__   __XXX__
> : Oops: 0000 [#1]
> : PREEMPT
> : CPU:    0
> : EIP:    0060:[d_move+109/576]    Not tainted VLI
> : EFLAGS: 00210246   (2.6.6-mm1)
> : EIP is at d_move+0x6d/0x240
> : eax: 00000000   ebx: c25549a4   ecx: c2554a0c   edx: 00000000
> : esi: c313d908   edi: c155f928   ebp: c496aebc   esp: c496aea8
> : ds: 007b   es: 007b   ss: 0068
> : Process ip (pid: 5604, threadinfo=c496a000 task=c7cc54c0)
> : Stack: 00000006 c0149c27 c480cca0 c313d908 c155f928 c496aedc c018e251 00200286
> :        c496af44 c480ce50 c480ce50 c480cca0 c50d5113 c496aeec c01d18b1 c480ce48
> :        c480cca0 c496aefc c0231ca8 c480cca0 c480cdcc c496af24 c028f56b c496af24
> : Call Trace:
> :  [show_stack+122/144] show_stack+0x7a/0x90
> :  [show_registers+324/432] show_registers+0x144/0x1b0
> :  [die+153/272] die+0x99/0x110
> :  [do_page_fault+485/1327] do_page_fault+0x1e5/0x52f
> :  [error_code+45/56] error_code+0x2d/0x38
> :  [sysfs_rename_dir+193/224] sysfs_rename_dir+0xc1/0xe0
> :  [kobject_rename+33/64] kobject_rename+0x21/0x40
> :  [class_device_rename+56/80] class_device_rename+0x38/0x50
> :  [dev_change_name+315/448] dev_change_name+0x13b/0x1c0
> :  [dev_ioctl+339/704] dev_ioctl+0x153/0x2c0
> :  [inet_ioctl+154/176] inet_ioctl+0x9a/0xb0
> :  [sock_ioctl+239/656] sock_ioctl+0xef/0x290
> :  [sys_ioctl+261/608] sys_ioctl+0x105/0x260
> :  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
> :
> : Code: 00 8b 46 10 39 43 10 74 37 8b 43 68 8d 4b 68 8b 51 04 85 c0 89 02 74 03 89 50 04 c7 41 04 00 02 20 00 8b
> 46 10 89 43 10 8b 56 10 <8b> 02 89 51 04 89 43 68 85 c0 74 03 89 48 04 89 0a 83 63 04 ef
> :  <6>note: ip[5604] exited with preempt_count 4
> : bad: scheduling while atomic!
> :  [dump_stack+23/32] dump_stack+0x17/0x20
> :  [schedule+1190/1200] schedule+0x4a6/0x4b0
> :  [shmem_file_write+523/624] shmem_file_write+0x20b/0x270
> :  [do_acct_process+780/816] do_acct_process+0x30c/0x330
> :  [acct_process+66/138] acct_process+0x42/0x8a
> :  [do_exit+128/1008] do_exit+0x80/0x3f0
> :  [die+260/272] die+0x104/0x110
> :  [do_page_fault+485/1327] do_page_fault+0x1e5/0x52f
> :  [error_code+45/56] error_code+0x2d/0x38
> :  [sysfs_rename_dir+193/224] sysfs_rename_dir+0xc1/0xe0
> :  [kobject_rename+33/64] kobject_rename+0x21/0x40
> :  [class_device_rename+56/80] class_device_rename+0x38/0x50
> :  [dev_change_name+315/448] dev_change_name+0x13b/0x1c0
> :  [dev_ioctl+339/704] dev_ioctl+0x153/0x2c0
> :  [inet_ioctl+154/176] inet_ioctl+0x9a/0xb0
> :  [sock_ioctl+239/656] sock_ioctl+0xef/0x290
> :  [sys_ioctl+261/608] sys_ioctl+0x105/0x260
> :  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
> :
> 
> -- 
> Rick Nelson
> <Crow_> hmm, is there a --now-dammit option for exim?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
