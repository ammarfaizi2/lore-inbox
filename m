Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUK1AVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUK1AVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUK1AVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:21:05 -0500
Received: from basillia.speedxs.net ([83.98.255.13]:64978 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S261371AbUK1AVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:21:00 -0500
Subject: kernel BUG in reiser4 tail_conversion.c:32 (2.6.10-rc1-mm5)
From: Tom Wirschell <lkml@wirschell.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 28 Nov 2004 01:20:51 +0100
Message-Id: <1101601252.4558.228.camel@LEV8>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apt-get segfaulted for no apparent reason. Attempts to restart apt-get
failed (basically hung when accessing the harddisk) and eventually it
became impossible to log in. Inspection at the actual machine reveiled
the following dumped onto the console:

kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:32!
invalid operand: 0000 [#1]
Modules linked in: ipt_multiport ipt_MASQUERADE ipt_LOG ipt_state
iptable_nat ip_conntrack iptable_filter ip_tables
CPU:    0
EIP:    0060:[<c01b874e>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc1-mm5)
EIP is at get_exclusive_access+0x2e/0x40
eax: c784fa40   ebx: 00000001   ecx: c5596dd8   edx: 00000000
esi: 00000000   edi: c5596dd8   ebp: c5596e30   esp: c42d1e18
ds: 007b   es: 007b   ss: 0068
Process apt-get (pid: 9964, threadinfo=c42d0000 task=c9df9040)
Stack: c01b7a05 00000001 c42d1e4c c42d1e20 c42d0000 c4171120 00000001 00000001
       005650e9 00000000 00000000 b7137000 c921d600 00008000 005650e9 c1054a40
       c10f4120 c1072780 c112eec0 c1036340 c1105600 c10a67c0 c115a220 00000000
Call Trace:
 [<c01b7a05>] write_unix_file+0x1a5/0x3c0
 [<c01912a1>] reiser4_write+0x61/0xa0
 [<c0145ea8>] sys_fchmod+0x98/0xc0
 [<c0191240>] reiser4_write+0x0/0xa0
 [<c0146eb4>] vfs_write+0xa4/0x130
 [<c0147007>] sys_write+0x47/0x80
 [<c0103aef>] syscall_call+0x7/0xb
Code: 00 e0 ff ff 21 e0 8b 00 8b 80 b8 04 00 00 8b 40 3c 8b 40 08 85 c0 75 13 ba 
01 00 ff ff 89 c8 0f c1 10 85 d2 0f 85 8b 0f 00 00 c3 <0f> 0b 20 00 e0 b7 2a c0
eb e3 90 8d b4 26 00 00 00 00 ba ff ff

All the above has been copied over onto a handheld by hand, and from
that same handheld onto this machine in much the same way. I
double-checked the values, but it's possible I got something wrong.
The BUG unfortunately never made it to any logfile.

This problem closely resembles this report:
http://www.mail-archive.com/reiserfs-list@namesys.com/msg16236.html
Unfortunately I'm unable to figure out if they've actually found and
fixed the bug during that discussion...

The machine is a Celeron 900 on an MSI board, with a 200 GB Western
Digital (JB) IDE harddisk.
The MSI board is old enough to not be able to figure out what the
correct size of the harddisk is (reports it as 137.4 GB), forcing me to
boot from a different, smaller harddisk. Linux then detects the big
harddisk correctly and is able to take it from there.

If you need additional info, feel free to ask.

Please CC me in your replies as I'm not on the list.

Kind regards,

Tom Wirschell

