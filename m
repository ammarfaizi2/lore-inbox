Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVAXWGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVAXWGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:04:47 -0500
Received: from d5152D246.access.telenet.be ([81.82.210.70]:28726 "EHLO
	svrmail.kunstmaan.be") by vger.kernel.org with ESMTP
	id S261686AbVAXWCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:02:01 -0500
From: Frank Dekervel |Smartlounge| <frank.dekervel@smartlounge.be>
Organization: Smartlounge
To: linux-kernel@vger.kernel.org
Subject: Badness in local_bh_enable at kernel/softirq.c:140
Date: Mon, 24 Jan 2005 23:02:04 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501242302.04493.frank.dekervel@smartlounge.be>
X-OriginalArrivalTime: 24 Jan 2005 22:01:59.0623 (UTC) FILETIME=[53D0B570:01C50260]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

when trying to use PPP over bluetooth (bluez), my syslog is filled with:

[see below]

it seems that this prevents me from having an actual succesful connection, 
altough some packets get thru (i get a succesful ppp connection sometimes,
i can ping the other end of the p-t-p link - but not anything else - i cannot reach
the nameservers). i use 2.6.11-rc2 with swsusp2 applied.

This one looks related (also ppp, but backtrace different)
https://bugzilla.redhat.com/beta/show_bug.cgi?id=125731

I guess this must be a known issue or a local problem, since google 
finds a lot of other references but i cannot figure out what's wrong/how to fix.

Someone has an idea ?
thanks,
frank

Jan 24 22:50:32 atlas kernel: Badness in local_bh_enable at kernel/softirq.c:140
Jan 24 22:50:32 atlas kernel:  [<c011df34>] local_bh_enable+0x74/0x80
Jan 24 22:50:32 atlas kernel:  [<f8ca5d28>] ppp_start_xmit+0xd8/0x250 [ppp_generic]
Jan 24 22:50:32 atlas kernel:  [<c011de7b>] __do_softirq+0x7b/0x90
Jan 24 22:50:32 atlas kernel:  [<c033df52>] qdisc_restart+0x62/0x100
Jan 24 22:50:32 atlas kernel:  [<c033148f>] dev_queue_xmit+0x1bf/0x250
Jan 24 22:50:32 atlas kernel:  [<c034866d>] ip_finish_output+0xdd/0x1f0
Jan 24 22:50:32 atlas kernel:  [<c03496fb>] ip_generic_getfrag+0x4b/0xc0
Jan 24 22:50:32 atlas kernel:  [<c034a7a2>] ip_push_pending_frames+0x2c2/0x460
Jan 24 22:50:32 atlas kernel:  [<c0365e3c>] udp_push_pending_frames+0x16c/0x2b0
Jan 24 22:50:32 atlas kernel:  [<c036636c>] udp_sendmsg+0x39c/0x690
Jan 24 22:50:32 atlas kernel:  [<c036dccd>] inet_sendmsg+0x4d/0x60
Jan 24 22:50:32 atlas kernel:  [<c0327afa>] sock_sendmsg+0xda/0x100
Jan 24 22:50:32 atlas kernel:  [<c014bd30>] prep_new_page+0x60/0x70
Jan 24 22:50:32 atlas kernel:  [<c014c236>] buffered_rmqueue+0xe6/0x200
Jan 24 22:50:32 atlas kernel:  [<c012c2e0>] autoremove_wake_function+0x0/0x60
Jan 24 22:50:32 atlas kernel:  [<c014c5dc>] __alloc_pages+0x1dc/0x3a0
Jan 24 22:50:32 atlas kernel:  [<c03278bc>] sockfd_lookup+0x1c/0x80
Jan 24 22:50:32 atlas kernel:  [<c0328fcc>] sys_sendto+0xdc/0x100
Jan 24 22:50:32 atlas kernel:  [<c0115c38>] recalc_task_prio+0x88/0x150
Jan 24 22:50:32 atlas kernel:  [<c0367932>] udp_poll+0x22/0x120
Jan 24 22:50:32 atlas kernel:  [<c0328459>] sock_poll+0x29/0x40
Jan 24 22:50:32 atlas kernel:  [<c017881b>] do_pollfd+0x5b/0xa0
Jan 24 22:50:32 atlas kernel:  [<c0329023>] sys_send+0x33/0x40
Jan 24 22:50:32 atlas kernel:  [<c0329883>] sys_socketcall+0x143/0x260
Jan 24 22:50:32 atlas kernel:  [<c0102f53>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:140
 [<c011df34>] local_bh_enable+0x74/0x80
 [<f8ca636b>] ppp_send_frame+0x27b/0x540 [ppp_generic]
 [<c0146d01>] __do_IRQ+0x51/0xf0
 [<f8ca608f>] ppp_xmit_process+0x5f/0xc0 [ppp_generic]
 [<f8ca5d28>] ppp_start_xmit+0xd8/0x250 [ppp_generic]
 [<c011de7b>] __do_softirq+0x7b/0x90
 [<c033df52>] qdisc_restart+0x62/0x100
 [<c033148f>] dev_queue_xmit+0x1bf/0x250
 [<c034866d>] ip_finish_output+0xdd/0x1f0
 [<c03496fb>] ip_generic_getfrag+0x4b/0xc0
 [<c034a7a2>] ip_push_pending_frames+0x2c2/0x460
 [<c0365e3c>] udp_push_pending_frames+0x16c/0x2b0
 [<c036636c>] udp_sendmsg+0x39c/0x690
 [<c036dccd>] inet_sendmsg+0x4d/0x60
 [<c0327afa>] sock_sendmsg+0xda/0x100
 [<c014bd30>] prep_new_page+0x60/0x70
 [<c014c236>] buffered_rmqueue+0xe6/0x200
 [<c012c2e0>] autoremove_wake_function+0x0/0x60
 [<c014c5dc>] __alloc_pages+0x1dc/0x3a0
 [<c03278bc>] sockfd_lookup+0x1c/0x80
 [<c0328fcc>] sys_sendto+0xdc/0x100
 [<c0115c38>] recalc_task_prio+0x88/0x150
 [<c0367932>] udp_poll+0x22/0x120
 [<c0328459>] sock_poll+0x29/0x40
 [<c017881b>] do_pollfd+0x5b/0xa0
 [<c0329023>] sys_send+0x33/0x40
 [<c0329883>] sys_socketcall+0x143/0x260
 [<c0102f53>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:140
 [<c011df34>] local_bh_enable+0x74/0x80
 [<f8c9cc41>] ppp_async_push+0x81/0x150 [ppp_async]
 [<f8c9cbb6>] ppp_async_send+0x46/0x50 [ppp_async]
 [<f8ca66ba>] ppp_push+0x8a/0xe0 [ppp_generic]
 [<f8ca636b>] ppp_send_frame+0x27b/0x540 [ppp_generic]
 [<c0146d01>] __do_IRQ+0x51/0xf0
 [<f8ca608f>] ppp_xmit_process+0x5f/0xc0 [ppp_generic]
 [<f8ca5d28>] ppp_start_xmit+0xd8/0x250 [ppp_generic]
 [<c011de7b>] __do_softirq+0x7b/0x90
 [<c033df52>] qdisc_restart+0x62/0x100
 [<c033148f>] dev_queue_xmit+0x1bf/0x250
 [<c034866d>] ip_finish_output+0xdd/0x1f0
 [<c03496fb>] ip_generic_getfrag+0x4b/0xc0
 [<c034a7a2>] ip_push_pending_frames+0x2c2/0x460
 [<c0365e3c>] udp_push_pending_frames+0x16c/0x2b0
 [<c036636c>] udp_sendmsg+0x39c/0x690
 [<c036dccd>] inet_sendmsg+0x4d/0x60
 [<c0327afa>] sock_sendmsg+0xda/0x100
 [<c014bd30>] prep_new_page+0x60/0x70
 [<c014c236>] buffered_rmqueue+0xe6/0x200
 [<c012c2e0>] autoremove_wake_function+0x0/0x60
 [<c014c5dc>] __alloc_pages+0x1dc/0x3a0
 [<c03278bc>] sockfd_lookup+0x1c/0x80
 [<c0328fcc>] sys_sendto+0xdc/0x100
 [<c0115c38>] recalc_task_prio+0x88/0x150
 [<c0367932>] udp_poll+0x22/0x120
 [<c0328459>] sock_poll+0x29/0x40
 [<c017881b>] do_pollfd+0x5b/0xa0
 [<c0329023>] sys_send+0x33/0x40
 [<c0329883>] sys_socketcall+0x143/0x260
 [<c0102f53>] syscall_call+0x7/0xb

Badness in local_bh_enable at kernel/softirq.c:140
 [<c011df34>] local_bh_enable+0x74/0x80
 [<f8c9cc41>] ppp_async_push+0x81/0x150 [ppp_async]
 [<f8a81d10>] uhci_irq+0x1a0/0x1c0 [uhci_hcd]
 [<f8a665a4>] snd_intel8x0_interrupt+0x54/0x1d0 [snd_intel8x0m]
 [<f8c9cb85>] ppp_async_send+0x15/0x50 [ppp_async]
 [<f8ca66ba>] ppp_push+0x8a/0xe0 [ppp_generic]
 [<f8ca636b>] ppp_send_frame+0x27b/0x540 [ppp_generic]
 [<c0146d01>] __do_IRQ+0x51/0xf0
 [<f8ca608f>] ppp_xmit_process+0x5f/0xc0 [ppp_generic]
 [<f8ca5d28>] ppp_start_xmit+0xd8/0x250 [ppp_generic]
 [<c011de7b>] __do_softirq+0x7b/0x90
 [<c033df52>] qdisc_restart+0x62/0x100
 [<c033148f>] dev_queue_xmit+0x1bf/0x250
 [<c034866d>] ip_finish_output+0xdd/0x1f0
 [<c03496fb>] ip_generic_getfrag+0x4b/0xc0
 [<c034a7a2>] ip_push_pending_frames+0x2c2/0x460
 [<c0365e3c>] udp_push_pending_frames+0x16c/0x2b0
 [<c036636c>] udp_sendmsg+0x39c/0x690
 [<c036dccd>] inet_sendmsg+0x4d/0x60
 [<c0327afa>] sock_sendmsg+0xda/0x100
 [<c014bd30>] prep_new_page+0x60/0x70
 [<c014c236>] buffered_rmqueue+0xe6/0x200
 [<c012c2e0>] autoremove_wake_function+0x0/0x60
 [<c014c5dc>] __alloc_pages+0x1dc/0x3a0
 [<c03278bc>] sockfd_lookup+0x1c/0x80
 [<c0328fcc>] sys_sendto+0xdc/0x100
 [<c0115c38>] recalc_task_prio+0x88/0x150
 [<c0367932>] udp_poll+0x22/0x120
 [<c0328459>] sock_poll+0x29/0x40
 [<c017881b>] do_pollfd+0x5b/0xa0
 [<c0329023>] sys_send+0x33/0x40
 [<c0329883>] sys_socketcall+0x143/0x260
 [<c0102f53>] syscall_call+0x7/0xb


Linux atlas 2.6.11-rc2swsusp2 #1 Mon Jan 24 20:48:51 CET 2005 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.36-rc3
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.20
quota-tools            3.12.
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
ver_linux: line 90: udevinfo: command not found
Modules Loaded         ppp_deflate zlib_deflate bsd_comp ppp_async ppp_generic slhc tun af_packet arc4 ieee80211_crypt_wep nvram rfcomm l2cap lp thermal fan ac battery md5 ipv6 eth1394 ohci1394 ieee1394 snd_intel8x0m 8250_pci i2c_i801 i2c_core hci_usb bluetooth uhci_hcd intel_agp agpgart irtty_sir sir_dev irda crc_ccitt parport_pc parport 8250_pnp 8250 serial_core pcspkr tsdev joydev evdev e1000 ipw2100 firmware_class ieee80211 ieee80211_crypt ehci_hcd usbcore snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ibm_acpi button speedstep_centrino freq_table processor cpufreq_userspace cpufreq_powersave rtc

CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
CONFIG_BT_HCIVHCI=m
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m




-- 
=========================
Frank Dekervel
frank.dekervel@smartlounge.be
=========================
Smartlounge
Stapelhuisstraat 15
3000 Leuven
phone:+32 16 311 411
fax:+32 16 311 410
mobile:+32 473 943 421
=========================
http://www.smartlounge.be
=========================
