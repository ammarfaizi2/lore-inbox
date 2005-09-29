Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVI2Nsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVI2Nsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVI2Nsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:48:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932155AbVI2Nsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:48:45 -0400
Date: Thu, 29 Sep 2005 15:48:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: marcel@holtmann.org, bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Problems with CF bluetooth
Message-ID: <20050929134802.GA6042@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some problems with Billionton CF card: if I insert card,
hciattach to it, eject it, hciattach again, I get an oops.

[Pretty recent kernel: Linux amd 2.6.14-rc2-g5fb2493e #106 Thu Sep 29
01:35:25 CEST 2005 i686 GNU/Linux]

Another problem is that... it works well on my PC. When I try to do
the same hciattach on sharp zaurus handheld, I get

(I had to hack serial driver a bit to default to 921600 bitrate; it
does not have setserial).

# hciattach -s 921600 /dev/ttyS0 bcsp
BCSP initialization timed out
								Pavel

Sep 29 15:42:34 amd kernel: EIP:    0060:[<c02d4e2c>]    Not tainted
VLI
Sep 29 15:42:34 amd kernel: EFLAGS: 00010082   (2.6.14-rc2-g5fb2493e)
Sep 29 15:42:34 amd kernel: EIP is at uart_flush_buffer+0xc/0x30
Sep 29 15:42:34 amd kernel: eax: f658a000   ebx: f6741400   ecx:
00000282   edx: 00000000
Sep 29 15:42:34 amd kernel: esi: f658a000   edi: 00000000   ebp:
00000000   esp: f4b49d80
Sep 29 15:42:34 amd kernel: ds: 007b   es: 007b   ss: 0068
Sep 29 15:42:34 amd kernel: Process hciattach (pid: 5971,
threadinfo=f4b48000 task=f7141070)
Sep 29 15:42:34 amd kernel: Stack: c03f9df6 f6741400 f5e7ca00 c03f9e27
c03f9f86 f658a000 00000001 c02a5ed7
Sep 29 15:42:34 amd kernel:        0000000f f27f0424 00001000 f7384e00
00000000 00000000 00000000 00000001
Sep 29 15:42:34 amd kernel:        00000000 00000000 00000000 f7d58000
f4b49e14 f27f03c0 f70fde3c 00000000
Sep 29 15:42:34 amd kernel: Call Trace:
Sep 29 15:42:34 amd kernel:  [<c03f9df6>] hci_uart_flush+0x66/0x80
Sep 29 15:42:34 amd kernel:  [<c03f9e27>] hci_uart_close+0x17/0x20
Sep 29 15:42:34 amd kernel:  [<c03f9f86>] hci_uart_tty_close+0x26/0x60
Sep 29 15:42:34 amd kernel:  [<c02a5ed7>] release_dev+0x587/0x670
Sep 29 15:42:34 amd kernel:  [<c016c521>] update_atime+0x51/0xa0
Sep 29 15:42:34 amd kernel:  [<c0146a14>] free_pte_range+0x34/0x40
Sep 29 15:42:34 amd kernel:  [<c0146af7>] free_pgd_range+0xd7/0x190
Sep 29 15:42:34 amd kernel:  [<c0169b7e>] dput+0x1e/0x180
Sep 29 15:42:34 amd kernel:  [<c02a63f7>] tty_release+0x7/0x10
Sep 29 15:42:34 amd kernel:  [<c0155796>] __fput+0x136/0x150
Sep 29 15:42:34 amd kernel:  [<c0153f03>] filp_close+0x43/0x70
Sep 29 15:42:34 amd kernel:  [<c011e721>] put_files_struct+0x61/0x90
Sep 29 15:42:34 amd kernel:  [<c011f24b>] do_exit+0xeb/0x350
Sep 29 15:42:34 amd kernel:  [<c011f51f>] do_group_exit+0x2f/0x70
Sep 29 15:42:34 amd kernel:  [<c012740a>]
get_signal_to_deliver+0x1ca/0x290
Sep 29 15:42:34 amd kernel:  [<c0102c57>] do_signal+0x87/0x110
Sep 29 15:42:34 amd kernel:  [<c0515c5e>] schedule+0x30e/0x590
Sep 29 15:42:34 amd kernel:  [<c05165e1>] schedule_timeout+0x61/0xb0
Sep 29 15:42:34 amd kernel:  [<c0231806>] copy_to_user+0x36/0x60
Sep 29 15:42:34 amd kernel:  [<c01251e7>] sys_nanosleep+0xf7/0x140
Sep 29 15:42:34 amd kernel:  [<c0102d17>] do_notify_resume+0x37/0x3c
Sep 29 15:42:34 amd kernel:  [<c0102eaa>] work_notifysig+0x13/0x19
Sep 29 15:42:34 amd kernel: Code: 80 7c 09 00 00 8b 50 10 8b 42 08 8b
4a 0c 29 c8 25 ff 0f 00 00 c3 89 f6 8d bc 27 00 00 00 00 8b 90 7c 09
00 00 9c 59 fa 8b 52 10 <c7> 42 0c 00 00 00 00 c7 42 08 00 00 00
00 51 9d e9 ef f9 fc ff
Sep 29 15:42:34 amd kernel:  <1>Fixing recursive fault but reboot is
needed!
Sep 29 15:43:10 amd pam_limits[5869]: wrong limit value 'unlimited'

-- 
if you have sharp zaurus hardware you don't need... you know my address
