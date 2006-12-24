Return-Path: <linux-kernel-owner+w=401wt.eu-S1752871AbWLXV0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbWLXV0H (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbWLXV0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:26:07 -0500
Received: from [61.49.148.102] ([61.49.148.102]:56265 "EHLO
	freya.yggdrasil.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752878AbWLXV0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:26:06 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 16:26:05 EST
Date: Mon, 25 Dec 2006 05:21:24 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: selinux networking: sleeping functin called from invalid context in 2.6.20-rc[12]
Message-ID: <20061225052124.A10323@freya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
for several network programs running on my system:

[  156.381868] BUG: sleeping function called from invalid context at net/core/sock.c:1523
[  156.381876] in_atomic():1, irqs_disabled():0
[  156.381881] no locks held by kio_http/9693.
[  156.381886]  [<c01057a2>] show_trace_log_lvl+0x1a/0x2f
[  156.381900]  [<c0105dab>] show_trace+0x12/0x14
[  156.381908]  [<c0105e48>] dump_stack+0x16/0x18
[  156.381917]  [<c011e30f>] __might_sleep+0xe5/0xeb
[  156.381926]  [<c025942a>] lock_sock_nested+0x1d/0xc4
[  156.381937]  [<c01cc570>] selinux_netlbl_inode_permission+0x5a/0x8e
[  156.381946]  [<c01c2505>] selinux_file_permission+0x96/0x9b
[  156.381954]  [<c0175a0a>] vfs_write+0x8d/0x167
[  156.381962]  [<c017605a>] sys_write+0x3f/0x63
[  156.381971]  [<c01040c0>] syscall_call+0x7/0xb
[  156.381980]  =======================

	I have 35 of these messages is my console log at the moment.
The only difference that I've noticed between the messages is
that they are for variety of processes: most for tor, xntpd, sendmail,
procmail.  The processes get to this point by sys_write, sys_send, or
sys_sendto (procmail was doing a sys_sendto, so it was also doing something
related to networking, even though it is not a program one normally
would think of as doing any networking system calls).

	My system seems to work OK even with these warning messages.
I can debug it futher.  I just figure I should report it now, because
I may have done everyone a disservice by putting off reporting it in
rc1 in the hopes of finding time to debug it.

Adam Richter
