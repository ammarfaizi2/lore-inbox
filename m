Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVCXXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVCXXta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVCXXta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:49:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:28832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261247AbVCXXtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:49:24 -0500
Date: Thu, 24 Mar 2005 15:49:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: rjw@sisk.pl, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-rc1-mm2
Message-Id: <20050324154920.4e506d76.akpm@osdl.org>
In-Reply-To: <42434E59.2060805@free.fr>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<1111682812.23440.6.camel@mindpipe>
	<20050324121722.759610f4.akpm@osdl.org>
	<200503242331.46985.rjw@sisk.pl>
	<42434E59.2060805@free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> hello,
> 
> Same kinds of problem here. It depends on the removed module. I mean:
> "rmmod loop" or "rmmod pcspkr" works. But "rmmod snd_ens1371" or "rmmod
> ohci1394" hangs.
> 
> Sysrq-T when rmmoding snd_ens1371 :
> 
>   rmmod         D C92EBE8C     0  8231   8159                     (NOTLB)
>   c92ebea0 00000082 00000003 c92ebe8c 00000000 5685fc00 000f4253 cd624530
>          cd624658 cff60874 cff60844 c92ebebc c92ebef0 c02618c7 00000000
> cd624530
>          c0113137 00000000 00000000 00000282 cd248c20 cd248c07 00000001
> cd624530
>   Call Trace:
>    [wait_for_completion+124/193] wait_for_completion+0x7c/0xc1
>    [<c02618c7>] wait_for_completion+0x7c/0xc1
>    [device_release_driver+52/116] device_release_driver+0x34/0x74
>    [<c01f0ae3>] device_release_driver+0x34/0x74
>    [__remove_driver+8/12] __remove_driver+0x8/0xc
>    [<c01f0b2b>] __remove_driver+0x8/0xc
>    [driver_for_each_device+50/87] driver_for_each_device+0x32/0x57
>    [<c01f0bd8>] driver_for_each_device+0x32/0x57
>    [driver_detach+17/19] driver_detach+0x11/0x13
>    [<c01f0b40>] driver_detach+0x11/0x13
>    [bus_remove_driver+76/130] bus_remove_driver+0x4c/0x82
>    [<c01f05eb>] bus_remove_driver+0x4c/0x82
>    [driver_unregister+14/23] driver_unregister+0xe/0x17
>    [<c01f0cb2>] driver_unregister+0xe/0x17
>    [pci_unregister_driver+14/23] pci_unregister_driver+0xe/0x17
>    [<c019b242>] pci_unregister_driver+0xe/0x17
>    [sys_delete_module+322/379] sys_delete_module+0x142/0x17b
>    [<c0128356>] sys_delete_module+0x142/0x17b

It looks like we're getting stuck in the wait_for_completion() in the new
klist_remove().

