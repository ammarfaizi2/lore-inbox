Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUB0Kwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUB0Kwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:52:54 -0500
Received: from a.frontend.um.mediaways.net ([62.53.231.6]:2274 "HELO
	a.frontend.um.mediaways.net") by vger.kernel.org with SMTP
	id S261790AbUB0Kws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:52:48 -0500
From: Rudorff <leitzentrale@telebel.de>
Organization: Ministerium =?utf-8?q?f=C3=BCr?= =?utf-8?q?=20=C3=84u=C3=9Ferstes?=
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.3] kernel BUG at include/linux/list.h:149
Date: Fri, 27 Feb 2004 11:52:44 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402271152.44669.leitzentrale@telebel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: kernel BUG at include/linux/list.h:149! 
Kernel Version: 2.6.3
Status: NEW, looks like BUG #892
http://bugme.osdl.org/show_bug.cgi?id=892 
Severity: normal
System: Mandrake 9.2, glibc-2.3.2-14mdk, XFree 4.3-24.4.92mdk, kde 3.1.3

Hello!

2.6.3 runs fine on my box. But after 14h uptime, my kde session was 
killed, fallback to loginscreen. Found this in the logs:

CROND[1253]: (root) CMD (nice -n 19 run-parts /etc/cron.hourly)
kernel: ------------[ cut here ]------------
kernel: kernel BUG at include/linux/list.h:149!
kernel: invalid operand: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[remove_wait_queue+78/88]    Not tainted VLI
kernel: EIP:    0060:[<c011fdef>]    Not tainted VLI
kernel: EFLAGS: 00010006
kernel: EIP is at remove_wait_queue+0x4e/0x58
kernel: eax: d7f7cb18   ebx: d3d1707c   ecx: d7f7cb18   edx: d3d17088
kernel: esi: 00000286   edi: d3d17000   ebp: d8169ec8   esp: d8169ec0
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process kdeinit (pid: 2379, threadinfo=d8168000 task=db554cc0)
kernel: Stack: d3d17078 d3d17008 d8169edc c0164088 00000001 00000000 
00000029 d8169f54
kernel:        c01644bd d8169f38 00000000 00000000 00000000 00000000 
00000009 00000304
kernel:        00000106 00000000 00000000 00000106 d8168000 c51d7298 
c51d7290 c51d7288
kernel: Call Trace:
kernel:  [poll_freewait+36/67] poll_freewait+0x24/0x43
kernel:  [<c0164088>] poll_freewait+0x24/0x43
kernel:  [do_select+633/652] do_select+0x279/0x28c
kernel:  [<c01644bd>] do_select+0x279/0x28c
kernel:  [__pollwait+0/187] __pollwait+0x0/0xbb
kernel:  [<c01640a7>] __pollwait+0x0/0xbb
kernel:  [sys_select+625/1190] sys_select+0x271/0x4a6
kernel:  [<c016476a>] sys_select+0x271/0x4a6
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:  [<c010b037>] syscall_call+0x7/0xb
kernel:
kernel: Code: 2a 89 48 04 89 01 c7 42 04 00 02 20 00 c7 43 0c 00 01 10 
00 56 9d 8b 74 24 04 8b 1c 24 89 e
 2f c0 eb ce <0f> 0b 95 00 1d 10 2f c0 eb cc 55 89 e5 83 ec 0c 89 1c 24 
89 7c
kde3(pam_unix)[1774]: session closed for user chris
modprobe: FATAL: Module /dev/:0 not found.


