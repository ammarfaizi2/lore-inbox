Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUDTNL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUDTNL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 09:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUDTNL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 09:11:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:23200 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262956AbUDTNLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 09:11:24 -0400
X-Authenticated: #9338391
Message-Id: <6.1.0.6.0.20040420151204.02965030@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.0.6
Date: Tue, 20 Apr 2004 15:13:04 +0200
To: linux-kernel@vger.kernel.org
From: Claus <claus_99@gmx.net>
Subject: mysqld crashes redhat 9.0 server
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we are having problems with the following setup

rh 9.0 (kernel 2.4.20)
mysqld 4.0.15
php 4.3.3
apache 1.3.29


and a quite large (10.000 unique visitors/day) server and messageboard
(phpbb, more or less always the newest available version).
The biggest load comes from the messageboard. There's also a movie
section which generates a lot of traffic too.

It happens that the server crashes every 2 or 3 days, sometimes the
server stays up for a week, sometimes even 1 and a half.

first mysqld crashes, then all myslqd_safe and httpd processes crashes
one after one.
there is no stacktrace in the mysql-data-dir/xyz.err logfile. it simply
shows a message that the database wasn't shutdown normally after the
crash, nothing more.

however there is a stacktrace in /var/log/messages of the crashed mysqld.
I tried the use stack trace method of the mysql documentation (chapter
D.1.4) with the stack trace of /var/log/messages but without success. it
only shows some numbers and some "?" at every "zero" offset (like
0x000000f ).

I already postet at the mysql mailinglist where I got a hint that redhat
9.0 is eventually using an experimental thread library, but that wasn't
the case.

I enclose a sample output of /var/log/messages (rather old, but the
problems are the same).

any help would be greatly appreciated.

thank you for your time,

claus goettfert


Unable to handle kernel paging request at virtual address 95a8e154
Mar  1 18:17:34 web kernel:  printing eip:
Mar  1 18:17:34 web kernel: c015bee2
Mar  1 18:17:34 web kernel: *pde = 00000000
Mar  1 18:17:34 web kernel: Oops: 0002
Mar  1 18:17:34 web kernel: 8139too mii ipt_limit iptable_filter
ip_tables
keybdev mousedev hid input usb-uhci usbcore ext3 jbd
Mar  1 18:17:34 web kernel: CPU:    0
Mar  1 18:17:34 web kernel: EIP:    0060:[<c015bee2>]    Not tainted
Mar  1 18:17:34 web kernel: EFLAGS: 00010212
Mar  1 18:17:34 web kernel:
Mar  1 18:17:34 web kernel: EIP is at remove_dquot_ref [kernel] 0x242
(2.4.20-28.9)
Mar  1 18:17:34 web kernel: eax: 00000000   ebx: 00000000   ecx: 0000002c
edx: 95a8e154
Mar  1 18:17:34 web kernel: esi: 95a8e040   edi: 95a8e154   ebp: bffe1598
esp: d87cdee0
Mar  1 18:17:34 web kernel: ds: 0068   es: 0068   ss: 0068
Mar  1 18:17:34 web kernel: Process httpd (pid: 13437,
stackpage=d87cd000)
Mar  1 18:17:34 web kernel: Stack: c0346224 c367d400 c015a484 95a8e154
00000000 000000b0 c0346224 00000001
Mar  1 18:17:34 web kernel:        00000001 c015b537 c367d400 c01ead37
c367d400 edb9fbc0 00000000 f88ec7f6
Mar  1 18:17:34 web kernel:        05b9fbc0 c0346224 c01eb786 c0344684
00000008 c01f305e edb9fbc0 f7b14400
Mar  1 18:17:34 web kernel: Call Trace:   [<c015a484>] alloc_inode
[kernel]
0x144 (0xd87cdee8))
Mar  1 18:17:34 web kernel: [<c015b537>] new_inode [kernel] 0x17
(0xd87cdf04))
Mar  1 18:17:34 web kernel: [<c01ead37>] sock_alloc [kernel] 0x17
(0xd87cdf0c))
Mar  1 18:17:34 web kernel: [<f88ec7f6>] rtl8139_rx_interrupt [8139too]
0x166 (0xd87cdf1c))
Mar  1 18:17:34 web kernel: [<c01eb786>] sock_create [kernel] 0x66
(0xd87cdf28))
Mar  1 18:17:34 web kernel: [<c01f305e>] netif_receive_skb [kernel] 0x12e
(0xd87cdf34))
Mar  1 18:17:34 web kernel: [<c01f319d>] process_backlog [kernel] 0x6d
(0xd87cdf54))
Mar  1 18:17:34 web kernel: [<c01eb86b>] sys_socket [kernel] 0x2b
(0xd87cdf64))
Mar  1 18:17:34 web kernel: [<c01ec772>] sys_socketcall [kernel] 0x72
(0xd87cdf80))
Mar  1 18:17:34 web kernel: [<c010939f>] system_call [kernel] 0x33
(0xd87cdfc0))
Mar  1 18:17:34 web kernel:
Mar  1 18:17:34 web kernel:
Mar  1 18:17:34 web kernel: Code: f3 ab eb ae c1 e9 02 89 d7 f3 ab aa eb
a4
83 ec 08 89 1c 24

