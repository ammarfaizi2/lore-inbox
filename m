Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUJXKAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUJXKAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUJXKAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:00:05 -0400
Received: from lorien.s2s.msu.ru ([193.232.119.108]:61142 "EHLO
	lorien.s2s.msu.ru") by vger.kernel.org with ESMTP id S261418AbUJXJ7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:59:34 -0400
Date: Sun, 24 Oct 2004 13:59:32 +0400
From: Alexander Vodomerov <alex@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Cc: alex@sectorb.msk.ru
Subject: oops on 2.6.9 in 'ip ro del'
Message-ID: <20041024095932.GA25487@lorien.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

After upgrading kernel from 2.6.9-rc2 to 2.6.9, deconfiguring network
interfaces started to cause oops.

Machine: Athlon XP 2500+, 1Gb RAM (no highmem), all hardware is linux-friendly,
working fine for more than year.
Kernel: stock vanilla 2.6.9 kernel, no special patches, except PAGE_OFFSET
moved to 0x80000000.
Distro: Debian unstable/sid i386 (with the most recent updates).
GCC: Debian 3.3.5-1 from Debian package.
Oops: 100% reproducible.

I will be glad to provide any additional information.
Please Cc: me beacuse I'm not subscribed to mailing list.

Here is screenshot (copied by hand because system was unusable):

Deconfiguring network interfaces... Unable to handle kernel NULL pointer derefer
ence at virtual address 00000000
 printing eip:
802c5101
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ieee1394 mga_vid 8139too mii crc32 tg3 snd_pcm_oss snd_pcm sn
d_timer snd_page_alloc snd_mixer_oss snd soundcore psmouse usbhid evdev usb_stor
age ehci_hcd uhci_hcd usbcore sd_mod sg scsi_mod asb100 i2c_sensor i2c_viapro i2
c_dev i2c_core tun mga via_agp agpgart
CPU:	0
EIP:	0060:[<802c5101>]	Not tainted VLI
EFLAGS:	00010246   (2.6.9)
EIP is at fib_release_info+0x71/0xc0
eax: 00000000	ebx: bf5271c0	ecx: 00000000	edx:bf527160
esi: bf5271c4	edi: 5e2fb280	ebp: bffd0650	esp:bf203c24
ds: 007b   es: 007b   ss:0068
Process ip (pid: 1304, threadinfo=bf202000 task=bf7b1020)
Stack: 00000001 be730268 802c71c3 bf527160 be730260 be2fb280 00000000 000000cd
       bffd0640 bed52f58 00143653 bf3211e0 00000000 be730260 bf32c77c bffd0650
       bffd0640 bfff24a0 bffd0640 802c48aa bee0a8c0 bffd0650 bfff24a0 bffd0640
Call Trace:
 [<802c71c3>] fn_hash_delete+0x1c3/0x270
 [<802c48aa>] inet_rtm_delroute+0x6a/0x80
 [<8028e390>] rtnetlink_rcv+0x2d0/0x390
 [<802933c1>] netlink_data_ready+0x61/0x70
 [<802929a3>] netlink_sendskb+0xa3/0xb0
 [<80293062>] netlink_sendmsg+0x202/0x2f0
 [<8027cf05>] sock_sendmsg+0xe5/0x100
 [<80104a45>] error_code+0x2d/0x38
 [<80168c12>] update_atime+0x92/0xe0
 [<801f0142>] copy_from_user+0x42/0x80
 [<8011b1d0>] autoremove_wake_function+0x0/0x60
 [<8027e8d9>] sys_sendmsg+0x189/0x1f0
 [<80143a71>] handle_mm_fault+0xd1/0x140
 [<80115962>] do_page_fault+0x192/0x585
 [<8027db47>] __sock_create+0xa7/0x190
 [<801f0142>] copy_from_user+0x42/0x80
 [<8027ed76>] sys_socketcall+0x236/0x260
 [<80109d5a>] do_gettimeofday+0x1a/0xb0
 [<801157d0>] do_page_fault+0x0/0x585
 [<80104a45>] error_code+0x2d/0x38
 [<8010403b>] syscall_call+0x7/0xb
Code: 8d 5a 08 8b 4b 04 85 c0 89 01 74 03 89 48 04 c7 42 08 00 01 10 00 c7 43 04
 00 02 20 00 8d 5a 60 8d 72 64 8b 43 04 8b 4e 04 85 c0 <89> 01 74 03 89 48 04 c7
 43 04 00 01 10 00 c7 46 04 00 02 20 00
 /bin/sh: line 1:  1304 Segmentation fault      ip ro del table mh.hackers unrea
chable default
