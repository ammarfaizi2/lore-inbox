Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUAWWbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUAWWbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:31:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:46995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266706AbUAWWbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:31:16 -0500
Date: Fri, 23 Jan 2004 14:32:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mike Black" <mblack@csi-inc.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.1.6 st.o sleeping invalid context
Message-Id: <20040123143208.54b4f962.akpm@osdl.org>
In-Reply-To: <000701c3e1a6$ac762330$c8de11cc@black>
References: <000701c3e1a6$ac762330$c8de11cc@black>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike Black" <mblack@csi-inc.com> wrote:
>
> Testing 2.6.1 and got the following message during boot -- apparently when loading the st.o module -- although the modules still
> loads successfully.
> 
> Jan 23 06:41:49 yeti kernel: Debug: sleeping function called from invalid context at mm/slab.c:1856
> Jan 23 06:41:49 yeti kernel: in_atomic():1, irqs_disabled():0
> Jan 23 06:41:49 yeti kernel: Call Trace:
> Jan 23 06:41:49 yeti kernel:  [<c011da0c>] __might_sleep+0xab/0xc9
> Jan 23 06:41:49 yeti kernel:  [<c0142a4a>] kmem_cache_alloc+0x74/0x76
> Jan 23 06:41:49 yeti kernel:  [<c0162e81>] cdev_alloc+0x24/0x5e
> Jan 23 06:41:49 yeti kernel:  [<f8871743>] st_probe+0x3f4/0x7c1 [st]
> Jan 23 06:41:49 yeti kernel:  [<c018f7b0>] init_dir+0x0/0x22
> Jan 23 06:41:49 yeti kernel:  [<c01f7d29>] bus_match+0x3d/0x65
> Jan 23 06:41:49 yeti kernel:  [<c01f7e42>] driver_attach+0x59/0x83
> Jan 23 06:41:49 yeti kernel:  [<c01f810b>] bus_add_driver+0x9e/0xb1
> Jan 23 06:41:49 yeti kernel:  [<f881905e>] init_st+0x5e/0x9c [st]
> Jan 23 06:41:49 yeti kernel:  [<c013898f>] sys_init_module+0x13e/0x29a
> Jan 23 06:41:49 yeti kernel:  [<c01091e3>] syscall_call+0x7/0xb
> 

st_probe() is calling cdev_alloc() under write_lock(&st_dev_arr_lock);

Optimistically Cc'ing linux-scsi...
