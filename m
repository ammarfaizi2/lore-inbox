Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263953AbUKZVeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUKZVeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUKZVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:34:24 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:44492 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264057AbUKZVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:30:49 -0500
Date: Fri, 26 Nov 2004 22:33:37 +0100
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2-mm3, reiser4 and subversion
Message-ID: <20041126223337.44e2366a@discovery.hal.lan>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i had some serious trouble with stability in the last time. Sometimes my
box freezes and was not leaving any log messages in /var/log but
yesterday, when i was trying to commit a few changes to my local
repository, i got some strange error messages from subversion, followed
by a complete freezed computer :(
After i was rebooting, i found this error message in /var/log/kern.log

------------[ cut here ]------------
kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:58!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: lirc_serial lirc_dev
CPU:    0
EIP:    0060:[<c0212918>]    Tainted: P      VLI
EFLAGS: 00010282   (2.6.10-rc2-mm3) 
EIP is at get_nonexclusive_access+0x28/0x40
eax: f56f5f24   ebx: f5346330   ecx: f716bc40   edx: f53462d8
esi: f5346300   edi: f53462d8   ebp: f6d0fcd4   esp: f56f5c70
ds: 007b   es: 007b   ss: 0068
Process svnadmin (pid: 10782, threadinfo=f56f4000 task=f707c040)
Stack: c02114d7 f53462d8 f783f800 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 Call Trace:
[<c02114d7>] unix_file_filemap_nopage+0x67/0xd0
[<c0145386>] do_no_page+0xc6/0x390
[<c0145940>] handle_mm_fault+0x1c0/0x200
[<c0143c17>] follow_page+0x27/0x30
[<c0143dbe>] get_user_pages+0x15e/0x3d0
[<c021099a>] reiser4_get_user_pages+0x9a/0xd0
[<c0210f96>] read_unix_file+0x266/0x2f0
[<c01c92a5>] init_context+0x75/0xc0
[<c01e20df>] reiser4_read+0x8f/0xf0
[<c0160581>] sys_fstat64+0x31/0x40
[<c015584a>] vfs_read+0x13a/0x180
[<c0155c84>] sys_pread64+0x64/0x80
[<c0103191>] sysenter_past_esp+0x52/0x71
Code: 00 00 00 b8 00 e0 ff ff 8b 54 24 04 21 e0 8b 00 8b 80 b8 04 00 00
8b 40 3c 8b 48 08 85 c9 75 0b 89 d0 ff 00 0f 88 5a 12 00 00 c3 <0f> 0b
3a 00 1c ed 49 c0 eb eb 8d b4 26 00 00 00 00 8d bc 27 00 

>From now on, every time i try to do execute "svnadmin recover" (to
recover the repository) or "svnadmin create", the system freezes. I am
not able to start any new programms, nor can i save open files to the
harddisk, but i am able to execute some simple commands like ls and i
can edit opened files in vi. If i execute "svnadmin create" for the
second time, the system totaly freezes and i am unable to anything, only
hit the reboot button.

Executing "fsck.reiser4 --check /dev/sda2" (my root partition) just
tells me that everything is fine.

Kind regards

Florian Engelhardt

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
