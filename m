Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUBFTxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265597AbUBFTxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:53:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:33457 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261807AbUBFTxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:53:41 -0500
Date: Fri, 6 Feb 2004 11:55:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 - errors during boot
Message-Id: <20040206115508.61f6460a.akpm@osdl.org>
In-Reply-To: <1076094927.6331.5.camel@moria.arnor.net>
References: <1076094927.6331.5.camel@moria.arnor.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman <thoffman@arnor.net> wrote:
>
> I didn't have these with 2.6.2-rc3-mm1.
> 
> (snipped from dmesg log:)
> ...
> found reiserfs format "3.6" with standard journal
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508d0000f42af5]
> Badness in kobject_get at lib/kobject.c:431
> Call Trace:
>  [<c02078dc>] kobject_get+0x3c/0x50
>  [<c0272fd1>] get_device+0x11/0x20
>  [<c0273c68>] bus_for_each_dev+0x78/0xd0
>  [<fc876185>] nodemgr_node_probe+0x45/0x100 [ieee1394]
>  [<fc876030>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
>  [<fc87654b>] nodemgr_host_thread+0x14b/0x180 [ieee1394]
>  [<fc876400>] nodemgr_host_thread+0x0/0x180 [ieee1394]
>  [<c010b285>] kernel_thread_helper+0x5/0x10

Ben and Greg are currently arguing over whose fault this is ;)

> Unable to handle kernel paging request at virtual address 57e58955
>  printing eip:
> 57e58955
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> CPU:    0
> EIP:    0060:[<57e58955>]    Not tainted VLI
> EFLAGS: 00010206
> EIP is at 0x57e58955
> eax: fc87f5a8   ebx: fc87f5a8   ecx: fc87f584   edx: 57e58955
> esi: fc875af0   edi: 00000000   ebp: f7265f6c   esp: f7265f58
> ds: 007b   es: 007b   ss: 0068
> Process knodemgrd_0 (pid: 28, threadinfo=f7264000 task=f7267780)
> Stack: c0207974 fc874940 fc87f584 fc87f58c fc87f4e0 f7265f90 c0273c7a
> fc87f52c
>        00000000 f7350244 f7265fa4 f735023c f7265fa4 f7c46398 f7265fc8
> fc876185
>        fc876030 f7fa8000 00000001 f7c46398 f7350200 0000ffff f7265fb8
> 00000004
> Call Trace:
>  [<c0207974>] kobject_cleanup+0x84/0x90
>  [<fc874940>] nodemgr_bus_match+0x0/0xb0 [ieee1394]
>  [<c0273c7a>] bus_for_each_dev+0x8a/0xd0
>  [<fc876185>] nodemgr_node_probe+0x45/0x100 [ieee1394]
>  [<fc876030>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
>  [<fc87654b>] nodemgr_host_thread+0x14b/0x180 [ieee1394]
>  [<fc876400>] nodemgr_host_thread+0x0/0x180 [ieee1394]
>  [<c010b285>] kernel_thread_helper+0x5/0x10

OK.  There will be a big 1394 update in 2.6.2-mm2.  Could you please retest
and let us know?

