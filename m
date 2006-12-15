Return-Path: <linux-kernel-owner+w=401wt.eu-S932885AbWLSSiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbWLSSiF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbWLSSiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:38:05 -0500
Received: from mail.pxnet.com ([195.227.45.3]:34238 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932885AbWLSSiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:38:04 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 13:38:03 EST
Message-Id: <200612191815.kBJIFF4O018306@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
To: Andrew Morton <akpm@osdl.org>
Subject: BUG: NMI Watchdog detected LOCKUP (was: 2.6.20-rc1-mm1)
CC: linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2006 22:59:13 -0800
References: <20061214225913.3338f677.akpm@osdl.org>
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried kernel 2.6.20-rc1-mm1 with the "tickless" option on my P3/933
but it has now for the second time in a row caused a system freeze
as soon as I left the system idle for a couple of hours. The second
time I was warned and switched to a text console before I left the
system, and was able to collect this BUG message (copied manually,
beware of typos):

BUG: NMI Watchdog detected LOCKUP on CPU0, eip c021cf4d, registers:
Modules linked in: xt_pkttype ipt_LOG xt_limit usbserial snd_rtctimer snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device thermal processor fan button battery ac af_packet bas_gigaset gigaset isdn slhc crc_ccitt ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat nf_nat iptable_filter ip6table_mangle nf_conntrack_ipv4 nf_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 uhci_hcd ipv6 nls_iso8859_1 nls_cp437 vfat fat nsl_utf8 ntfs dm_mod
CPU:    0
EIP:    0060:[<c021cf4d>]    Not tainted VLI
EFLAGS: 00200082   (2.6.20-rc1-mm1-noinitrd #0)
EIP is at __rb_rotate_right+0x1/0x54
eax: dea0c77c   ebx: dea0c77c   ecx: dae0c77c   edx: c04beb8c
esi: dea0c77c   edi: dea0c77c   ebp: deaf3d74   esp: deaf3d54
ds: 007b   es: 007b   fs: 00d8   gs: 0033   ss: 0068
Process X (pid: 3255, ti=deaf2000 task=c14deb00 task.ti=deaf2000)
Stack: deaf3d74 c021d049 c04beb8c 00000000 00000000 dea0c77c de8d5f3e 00000995
       deaf3d98 c012d15b 00000001 c04beb84 dea0c780 dea0c77c de8d5f3e 00000995
       c04beb84 deaf3dc4 c012d9b4 c012d323 dea0c77c 00200096 00000000 dea0c77c
Call Trace:
 [<c021d049>] rb_insert_color+0x55/0xbe
 [<c012d15b>] enqueue_hrtimer+0x10a/0x116
 [<c012d9b4>] hrtimer_start+0x78/0x93
 [<c0123453>] get_signal_to_deliver+0xf3/0x74e
 [<c01026ee>] do_notify_resume+0x93/0x655
 [<c0102ef5>] work_notifysig+0x13/0x1a
 [<b7f5f410>] 0xb7f5f410
 =======================
Code: 39 d0 74 22 8b 4a 08 85 c9 74 0d 8b 41 04 85 c0 74 14 89 c1 eb f5 89 c2 8b 02 83 e0 fc 74 05 3b 50 08 74 f2 89 c1 5d 89 c8 c3 55 <89> e5 57 89 d7 56 53 89 c3 8b 50 08 8b 30 8b 4a 04 83 e6 fc 85

Config file available upon request. (The system won't boot right now,
it wants a manual fsck first.) Bisecting this promises to take about
8 hours per iteration if I add up the wait for the hang, the fsck
afterwards and the time this system needs for compiling a kernel, so
I'll wait for you to tell me if it's really necessary. ;-)

HTH
Tilman

