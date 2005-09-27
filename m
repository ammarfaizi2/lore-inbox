Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVI0LHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVI0LHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVI0LHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:07:38 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:57478 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964898AbVI0LHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:07:38 -0400
Message-ID: <433927B0.9020108@gmx.net>
Date: Tue, 27 Sep 2005 13:06:24 +0200
From: Daniel Link <stagger@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050924)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS: Suspend2+iptables when loading ipw2200
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ID: rffjRiZfwe0Aee1ViTH4KhW8+WxT-AjcK5CoSZT5xk9o3I7j6uqMEF@t-dialin.net
X-TOI-MSGID: a97bf85d-25ac-43a4-a2c0-dbad9bd39653
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my Suspend2-2.6.12-r1 kernel from Gentoo's portage worked almost
perfectly until I decided to prepare it for using iptables. I've had
only one system freeze before, which I didn't think much about. After
adding numerous modules about firewalling to the kernel config and
recompiling everything I finally rebooted the system. But some seconds
after loading the ipw2200 module (1.0.6) there was an OOPS. I also tried
not to use modules but to put the iptables stuff directly into the
kernel, but that didn't help.

Here's some output from dmesg. First I thought it had come from the new
iptables kernel, but that's not the case. It's the one from yesterday's
kernel without iptables. During normal work with GNOME the computer just
froze and I had to do a hard reboot.

Sep 26 13:07:54 hermes ------------[ cut here ]------------
Sep 26 13:07:54 hermes kernel BUG at kernel/workqueue.c:131!
Sep 26 13:07:54 hermes invalid operand: 0000 [#1]
Sep 26 13:07:54 hermes PREEMPT
Sep 26 13:07:54 hermes Modules linked in: ieee80211_crypt_tkip ipw2200
ieee80211 ieee80211_crypt
Sep 26 13:07:54 hermes CPU:    0
Sep 26 13:07:54 hermes EIP:    0060:[<c012f0bb>]    Not tainted VLI
Sep 26 13:07:54 hermes EFLAGS: 00010286   (2.6.12-suspend2-r6)
Sep 26 13:07:54 hermes EIP is at queue_delayed_work+0x6b/0x80
Sep 26 13:07:54 hermes eax: c053f9c0   ebx: 00000000   ecx: c04b13b8
edx: c04b13a0
Sep 26 13:07:54 hermes esi: c145e880   edi: 0000000a   ebp: 00000000
esp: def03f14
Sep 26 13:07:54 hermes ds: 007b   es: 007b   ss: 0068
Sep 26 13:07:54 hermes Process events/0 (pid: 3, threadinfo=def02000
task=c1469020)
Sep 26 13:07:54 hermes Stack: dea75f00 c04b13a0 c04b13a0 00000202
c04b13a4 c0329e26 00000000 c012f2e0
Sep 26 13:07:54 hermes 00000000 def03f68 00000000 def02000 c145e898
def02000 c145e888 c145e890
Sep 26 13:07:54 hermes def02000 c0329de0 def02000 ffffffff ffffffff
00000001 00000000 c011b140
Sep 26 13:07:54 hermes Call Trace:
Sep 26 13:07:54 hermes [<c0329e26>] do_dbs_timer+0x46/0x60
Sep 26 13:07:54 hermes [<c012f2e0>] worker_thread+0x210/0x300
Sep 26 13:07:54 hermes [<c0329de0>] do_dbs_timer+0x0/0x60
Sep 26 13:07:54 hermes [<c011b140>] default_wake_function+0x0/0x20
Sep 26 13:07:54 hermes [<c011b140>] default_wake_function+0x0/0x20
Sep 26 13:07:54 hermes [<c0133a07>] kthread+0xd7/0x120
Sep 26 13:07:54 hermes [<c012f0d0>] worker_thread+0x0/0x300
Sep 26 13:07:54 hermes [<c0133930>] kthread+0x0/0x120
Sep 26 13:07:54 hermes [<c010133d>] kernel_thread_helper+0x5/0x18
Sep 26 13:07:54 hermes Code: 14 c7 41 10 30 f0 12 c0 01 f8 89 41 08 89
44 24 04 89 0c 24 e8 b7 85 ff ff 89 d8 8b 74 24 0c 8b 5c 24 08 8b 7c 24
10 83 c4 14 c3 <0f> 0b 83  00 36 a7 40 c0 eb b4 0f 0b 84 00 36 a7 40 c0
eb b2 90

There was no other OOPS in /var/log/messages. It seems like when using
the iptables kernel the OOPS comes too fast for logging something, but
who am I to make any assumptions. Since there is no proof in the logs I
have made a photo with a digital camera. The first lines look similar to
the ones above. I haven't compared any more. Just tell me where to send
the image. I can also send you the working/panic kernel, its config and
the System.map.

Bye, Daniel
