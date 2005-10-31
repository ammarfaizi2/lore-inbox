Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVJaBDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVJaBDW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVJaBDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:03:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932391AbVJaBDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:03:21 -0500
Date: Sun, 30 Oct 2005 17:02:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: oops with USB Storage on 2.6.14
Message-Id: <20051030170244.4a8c06b7.akpm@osdl.org>
In-Reply-To: <38bdcd1f0510301641l3a211e41n3c571a98eef6185e@mail.gmail.com>
References: <38bdcd1f0510290511t65bb16cfkfd1e84fb301424f9@mail.gmail.com>
	<20051030110354.3a9d2a41.akpm@osdl.org>
	<38bdcd1f0510301641l3a211e41n3c571a98eef6185e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masanari Iida <standby24x7@gmail.com> wrote:
>

You removed linux-scis and linux-usb from cc.  Please retain them.

> >
> > Could you please try disabling CONFIG_DEBUG_PAGEALLOC and retest?  If that
> > works OK, it's probably a use-after-free.
> >
> Hello Andrew,
> 
> I did disabled CONFIG_DEBUG_PAGEALLOC and re-tested on 2.6.14-rc1.
> Now the oops didn't happen when I connect digital camera to the USB.

So the first oops was probably use-after-free.

> I could mount the camera as USB storage.
> But oops still happen when I turned the camera power off.
> (This oops didn't halt my system, BTW)
> 
> # Unable to handle kernel paging request at virtual address 6b6b6bb3
>   printing eip:
> c02b88ca
> *pde = 00000000
> Oops: 0002 [#1]
> SMP
> Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
> ipt_recent iptable_filter ip_tables video rtc
> CPU:    0
> EIP:    0060:[<c02b88ca>]    Not tainted VLI
> EFLAGS: 00010296   (2.6.14-rc1)
> EIP is at scsi_remove_device+0x3a/0x50
> eax: 00000001   ebx: dee9f478   ecx: 00000000   edx: 6b6b6b6b
> esi: de6655c4   edi: de6655bc   ebp: dfd4fdb4   esp: dfd4fda4
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 15, threadinfo=dfd4e000 task=dff1f030)
> Stack: dee9f478 00000066 dee9f478 de6655c4 dfd4fdcc c02b89a1 dee9f478 de6655c8
>        de213c98 de6655c4 dfd4fde8 c02b8a16 de213c84 dfd4fde8 00000282 de6655c8
>        de6655c8 dfd4fe04 c02b7655 de213c98 de6655cc de6655c4 de6656e0 de213a8c
> Call Trace:
>  [<c0103aaf>] show_stack+0x7f/0xa0
>  [<c0103c62>] show_registers+0x162/0x1d0
>  [<c0103e74>] die+0xf4/0x1a0
>  [<c039cfce>] do_page_fault+0x31e/0x640
>  [<c0103753>] error_code+0x4f/0x54
>  [<c02b89a1>] __scsi_remove_target+0xc1/0xe0
>  [<c02b8a16>] scsi_remove_target+0x26/0x60
>  [<c02b7655>] scsi_forget_host+0x45/0x70
>  [<c02afd97>] scsi_remove_host+0x57/0xa0
>  [<c02e5145>] quiesce_and_remove_host+0x75/0xb0
>  [<c02e55fd>] storage_disconnect+0x1d/0x2c
>  [<c02c8286>] usb_unbind_interface+0x86/0x90
>  [<c025617b>] __device_release_driver+0x8b/0x90
>  [<c02561b6>] device_release_driver+0x36/0x50
>  [<c02557c9>] bus_remove_device+0x79/0x90
>  [<c0254525>] device_del+0x35/0x70
>  [<c02d00fb>] usb_disable_device+0xfb/0x130
>  [<c02caa46>] usb_disconnect+0xc6/0x180
>  [<c02cbe2f>] hub_port_connect_change+0x3cf/0x400
>  [<c02cc12e>] hub_events+0x2ce/0x410
>  [<c02cc285>] hub_thread+0x15/0xf0
>   [<c0131aaa>] kthread+0xba/0xc0
>  [<c0100ecd>] kernel_thread_helper+0x5/0x18
> Code: 5d 08 89 75 fc 8b 33 89 44 24 04 c7 04 24 e8 a8 3b c0 e8 9a 14
> e6 ff f0 ff 4e 48 0f 88 a8 04 00 00 89 1c
>   24 e8 38 ff ff ff 8b 13 <f0> ff 42 48 0f 8e a1 04 00 00 8b 5d f8 8b
> 75 fc 89 ec 5d c3 89
> 
> If you need some more test, let me know.
> In that case, please specify which version of kernel you want me to test.
> 

OK, thanks.  This is a different bug.  Presumably in USB.

