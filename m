Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271007AbTHCU4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHCU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:56:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:54922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271184AbTHCUzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:55:32 -0400
Date: Sun, 3 Aug 2003 13:56:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3-1: Badness in class_dev_release followed by 5
 NFS server hangs
Message-Id: <20030803135641.49d6316e.akpm@osdl.org>
In-Reply-To: <200308040328.26830.mflt1@micrologica.com.hk>
References: <200308040328.26830.mflt1@micrologica.com.hk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mflt1@micrologica.com.hk> wrote:
>
> pppd is version 2.4.1 and has been used without problems since 2.5.5x
> 
>  Did a bit of web and this got inthe logs:
> 
>  Aug  4 00:45:08 mhfl2 pppd[8622]: Terminating on signal 15.
>  Aug  4 00:45:08 mhfl2 pppd[8622]: Connection terminated.
>  Aug  4 00:45:08 mhfl2 pppd[8622]: Connect time 11.9 minutes.
>  Aug  4 00:45:08 mhfl2 pppd[8622]: Sent 81253 bytes, received 660560 bytes.
>  Aug  4 00:45:09 mhfl2 kernel: kobject 'statistics' does not have a release() function, it is broken and must be fixed.
>  Aug  4 00:45:09 mhfl2 kernel: Badness in kobject_cleanup at lib/kobject.c:402
>  Aug  4 00:45:09 mhfl2 kernel: Call Trace:
>  Aug  4 00:45:09 mhfl2 kernel:  [<c01d939c>] kobject_cleanup+0x5c/0x74
>  Aug  4 00:45:09 mhfl2 kernel:  [<c01d93ca>] kobject_put+0x16/0x1c
>  Aug  4 00:45:09 mhfl2 kernel:  [<c01d92fb>] kobject_unregister+0x13/0x1c
>  Aug  4 00:45:09 mhfl2 kernel:  [<c028c100>] netdev_unregister_sysfs+0x1c/0x34
>  Aug  4 00:45:09 mhfl2 kernel:  [<c028b696>] netdev_run_todo+0xfa/0x16c
>  Aug  4 00:45:09 mhfl2 kernel:  [<c028eb65>] rtnl_unlock+0x3d/0x44
>  Aug  4 00:45:09 mhfl2 kernel:  [<c0247e6f>] unregister_netdev+0x17/0x1e
>  Aug  4 00:45:09 mhfl2 kernel:  [<c024b8f1>] ppp_shutdown_interface+0x55/0xa0
>  Aug  4 00:45:09 mhfl2 kernel:  [<c0248645>] ppp_ioctl+0x55/0x7e4
>  Aug  4 00:45:09 mhfl2 kernel:  [<c0158eaf>] sys_ioctl+0x1ef/0x20c
>  Aug  4 00:45:09 mhfl2 kernel:  [<c0149907>] sys_close+0x4b/0x60
>  Aug  4 00:45:09 mhfl2 kernel:  [<c02eb9c7>] syscall_call+0x7/0xb
> 
>  [ 2 more times the above ]
> 
>  There is a change to ppp_async for xonxoff in -mm2 and -mm3, 
>  could this be related?

No.  This is due to extra debug code which was added to mm2.

All netdevices will generate this warning on unregistration.  The net guys
are cooking up a fix, but it is not available yet.

