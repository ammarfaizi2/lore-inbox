Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275056AbTHFX4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275057AbTHFX4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:56:06 -0400
Received: from genericorp.net ([64.191.13.250]:39070 "EHLO
	nofrills.genericorp.net") by vger.kernel.org with ESMTP
	id S275056AbTHFXzy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:55:54 -0400
Date: Wed, 6 Aug 2003 19:54:29 -0400 (EDT)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@nofrills.genericorp.net
To: =?utf-8?b?RGFnZmlubiBJbG1hcmkg?= =?utf-8?b?TWFubnPDpWtlcg==?= 
	<ilmari@ilmari.org>
cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:113 (2.6.0-test2,
 bluetooth)
In-Reply-To: <d8ju18u2w5k.fsf@wirth.ping.uio.no>
Message-ID: <Pine.LNX.4.53.0308061951450.5362@nofrills.genericorp.net>
References: <d8ju18u2w5k.fsf@wirth.ping.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I also get this message when running the following (in 2.6.0-test1):

/usr/sbin/pppd updetach pty /bin/false

with this trace:

Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c011d401>] local_bh_enable+0x85/0x87
 [<e08afb49>] ppp_async_push+0xa1/0x186 [ppp_async]
 [<e08af478>] ppp_asynctty_wakeup+0x2d/0x59 [ppp_async]
 [<c029860f>] pty_unthrottle+0x56/0x58
 [<c0295243>] check_unthrottle+0x3b/0x3d
 [<c02952e3>] n_tty_flush_buffer+0x14/0x54
 [<c02989b9>] pty_flush_buffer+0x62/0x64
 [<c0291be6>] do_tty_hangup+0x471/0x4d7
 [<c02931e4>] release_dev+0x6f7/0x727
 [<c0182fe4>] ext3_release_file+0x0/0x5a
 [<c0293549>] tty_release+0x0/0x66
 [<c0293577>] tty_release+0x2e/0x66
 [<c014b097>] __fput+0x11c/0x12e
 [<c014978c>] filp_close+0x4b/0x74
 [<c011aed3>] put_files_struct+0x8d/0x100
 [<c011ba38>] do_exit+0x138/0x4ab
 [<c013e03d>] sys_brk+0x32/0x10d
 [<c011be39>] do_group_exit+0x3a/0xac
 [<c01090d3>] syscall_call+0x7/0xb


On Thu, 7 Aug 2003, [utf-8] Dagfinn Ilmari [utf-8] Mannsåker wrote:

> When unplugging my MSI USB Bluetooth adapter on 2.6.0-test2 I got two
> instances of the following backtrace:
>
> Badness in local_bh_enable at kernel/softirq.c:113
> Call Trace:
>  [<c011f6c6>] local_bh_enable+0x86/0x90
>  [<d090482a>] hci_dev_do_close+0xba/0x410 [bluetooth]
>  [<c011f6c6>] local_bh_enable+0x86/0x90
>  [<d09056cf>] hci_unregister_dev+0x4f/0xa0 [bluetooth]
>  [<d0976d8a>] hci_usb_disconnect+0x3a/0x80 [hci_usb]
>  [<d08ae237>] usb_device_remove+0x77/0x80 [usbcore]
>  [<c01df116>] device_release_driver+0x66/0x70
>  [<c01df26e>] bus_remove_device+0x5e/0xb0
>  [<c01dd99d>] device_del+0x5d/0xa0
>  [<c01dd9f3>] device_unregister+0x13/0x30
>  [<d08aee77>] usb_disconnect+0xd7/0x180 [usbcore]
>  [<d08b1f9f>] hub_port_connect_change+0x37f/0x390 [usbcore]
>  [<d08b2360>] hub_events+0x3b0/0x480 [usbcore]
>  [<d08b2465>] hub_thread+0x35/0x110 [usbcore]
>  [<c0109192>] ret_from_fork+0x6/0x14
>  [<c0118670>] default_wake_function+0x0/0x30
>  [<d08b2430>] hub_thread+0x0/0x110 [usbcore]
>  [<c01071e5>] kernel_thread_helper+0x5/0x10
>
> --
> ilmari
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
