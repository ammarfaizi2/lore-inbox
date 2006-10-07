Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWJGRen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWJGRen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJGRem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:34:42 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:56272 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932422AbWJGRem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:34:42 -0400
Message-ID: <4527E537.4030604@free.fr>
Date: Sat, 07 Oct 2006 19:34:47 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ueagle <ueagleatm-dev@gna.org>, Ernst Herzberg <list-lkml@net4u.de>
Subject: Re: 2.6.19-rc1 [ueagle-atm] Oops
References: <200610071858.22641.duncan.sands@math.u-psud.fr>
In-Reply-To: <200610071858.22641.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the report.

Duncan Sands wrote:
> 
> ----------  Forwarded Message  ----------
> 
> Subject: 2.6.19-rc1 [ueagle-atm] Oops
> Date: Saturday 7 October 2006 03:53
> From: Ernst Herzberg <list-lkml@net4u.de>
> To: linux-kernel@vger.kernel.org
> 
> Moin.
> 
> Works without problems on 2.6.18. 
> 
> 2.6.19-rc1: 
> (no, it does not work. The message 
> "usb 2-2: [ueagle-atm] modem operational" below is a lie;)
> 
> usb 2-2: new full speed USB device using uhci_hcd and address 3
> usb 2-2: configuration #1 chosen from 1 choice
> usb 2-2: [ueagle-atm] ADSL device founded vid (0X1110) pid (0X900F) : Eagle I
> usb 2-2: reset full speed USB device using uhci_hcd and address 3
> BUG: unable to handle kernel paging request at virtual address 74617473
>  printing eip:
> c018c5ab
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: dvb_bt8xx bt878 dvb_pll cx24110 bttv ir_common compat_ioctl32
> btcx_risc tveeprom stv0299 ves1x93 ueagle_atm usbatm atm dvb_ttpci ttpci_eeprom
> saa7146_vv video_buf videodev v4l1_compat v4l2_common saa7146 dvb_core processor
> button ohci_hcd uhci_hcd ehci_hcd usbcore iptable_nat ipt_MASQUERADE ip_nat
> ip_conntrack nfnetlink iptable_filter ip_tables x_tables pppoe pppox ppp_async
> ppp_generic slhc crc_ccitt tun ebtables ppdev parport_pc lp parport evdev psmouse
> CPU:    0
> EIP:    0060:[<c018c5ab>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.19-rc1 #1)
> EIP is at sysfs_dirent_exist+0x4b/0x6f
> eax: f99e9573   ebx: f7e41a04   ecx: 00000004   edx: 00000004
> esi: f99e9561   edi: 74617473   ebp: f55593e0   esp: f54b7c68
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 4078, ti=f54b7000 task=f54bc540 task.ti=f54b7000)
> Stack: 74617473 f99e948a f56fc714 00000000 f55593d4 c018bec6 00008124 00000004
>        00000004 c0117574 0000000f f553ba50 f54b7cc0 f56fc714 f99eae24 00000000
>        f99ead4c c018dab0 f56fc714 f553ba50 f5432180 00000000 f54d24e0 f99e800c
> Call Trace:
>  [<c018bec6>] sysfs_add_file+0x2e/0x70
>  [<c0117574>] nr_processes+0x4/0x6
>  [<c018dab0>] sysfs_create_group+0x5b/0xcb
>  [<f99e800c>] uea_bind+0x215/0x53c [ueagle_atm]
>  [<f99e6e73>] uea_kthread+0x0/0xb98 [ueagle_atm]
>  [<f99e7df7>] uea_bind+0x0/0x53c [ueagle_atm]
>  [<f99e23b9>] usbatm_usb_probe+0x109/0x7b2 [usbatm]
>  [<f99e83a6>] uea_probe+0x73/0x17d [ueagle_atm]
>  [<f9996da3>] usb_probe_interface+0x56/0x83 [usbcore]
>  [<c0275c4e>] really_probe+0x2e/0xbf
>  [<c0275d1e>] driver_probe_device+0x3f/0x93
>  [<c02752da>] bus_for_each_drv+0x3e/0x5c
>  [<c0275dd9>] device_attach+0x62/0x66
>  [<c0275d72>] __device_attach+0x0/0x5
>  [<c027527b>] bus_attach_device+0x1e/0x3f
>  [<c02745b7>] device_add+0x3c6/0x476
>  [<f999551a>] usb_set_configuration+0x394/0x4b1 [usbcore]
>  [<f999c509>] generic_probe+0x15c/0x223 [usbcore]
>  [<f9996a75>] usb_probe_device+0x33/0x38 [usbcore]
>  [<c0275c4e>] really_probe+0x2e/0xbf
>  [<c0275d1e>] driver_probe_device+0x3f/0x93
>  [<c02752da>] bus_for_each_drv+0x3e/0x5c
>  [<c0275dd9>] device_attach+0x62/0x66
>  [<c0275d72>] __device_attach+0x0/0x5
>  [<c027527b>] bus_attach_device+0x1e/0x3f
>  [<c02745b7>] device_add+0x3c6/0x476
>  [<f9995182>] usb_cache_string+0x7e/0x82 [usbcore]
>  [<f9990dc5>] usb_new_device+0x5d/0xcb [usbcore]
>  [<f9991bd5>] hub_thread+0x4d6/0xbc8 [usbcore]
>  [<c0360571>] schedule+0x2b1/0x64a
>  [<c012b1fe>] autoremove_wake_function+0x0/0x37
>  [<f99916ff>] hub_thread+0x0/0xbc8 [usbcore]
>  [<c012b0a5>] kthread+0xc9/0xcd
>  [<c012afdc>] kthread+0x0/0xcd
>  [<c01038eb>] kernel_thread_helper+0x7/0x1c
>  =======================
> Code: 16 eb 42 8b 5b 04 83 eb 04 8b 43 04 0f 18 00 90 8d 43 04 39 e8 74 2e 8b 43 14 85 c0 74 e5 89 d8 e8 6b ee ff ff 89 c6 8b 3c 24 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 c5 b8 ef
> EIP: [<c018c5ab>] sysfs_dirent_exist+0x4b/0x6f SS:ESP 0068:f54b7c68
> 
> 
I found where it comes from : somebody patch ueagle-atm and broke it : 
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e7ccdfec087f02930c5cdc81143d4a045ae8d361

I have to investigate why this patch is need, but it is nice to see that 
the patch wasn't forwarded to the maintainers and I wasn't aware of it...


Matthieu
