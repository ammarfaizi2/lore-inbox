Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTDHPQO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTDHPQO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:16:14 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:8678 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S261835AbTDHPQN (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:16:13 -0400
Subject: 2.5.67 kernel BUG at fs/buffer.c:2538
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049815653.32665.1135.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 08 Apr 2003 09:27:33 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a case of:

"It hurts when I do this:"
"Then don't do that!"

I started the latest security updated package of samba with
kernel 2.5.67, but I had forgotten to set CONFIG_SMB_FS.
The box became unresponsive, and then locked hard. Didn't respond
to pings, etc.  So I had to alt-sysrq-b. Now, samba is broken somehow, 
ERROR: Samba cannot create a SAM SID.
so I can't presently retest with SMB_FS=y and 2.5.67 or with
the vendor kernel (2.4.21-0.13mdk).  Unfortunately I had not yet 
tested the new security updated packages for samba with the vendor kernel.

However dumb it was to start samba without SMB_FS enabled,
the box shouldn't die like this.

I'm going to replace Bamboo with Shrike on that machine today,
so I won't be able to reproduce this anytime soon. (I hope).

Steven


Apr  8 07:30:34 spc1 smb: smbd startup succeeded
Apr  8 07:30:34 spc1 smb: nmbd startup succeeded
Apr  8 07:30:38 spc1 nmbd[8744]: [2003/04/08 07:30:38, 0] nmbd/nmbd_responserecordsdb.c:find_response_record(235) 
Apr  8 07:30:38 spc1 nmbd[8744]:   find_response_record: response packet id 19534 received with no matching record. 
Apr  8 07:30:38 spc1 nmbd[8744]: [2003/04/08 07:30:38, 0] nmbd/nmbd_responserecordsdb.c:find_response_record(235) 
Apr  8 07:30:38 spc1 nmbd[8744]:   find_response_record: response packet id 19535 received with no matching record. 
Apr  8 07:30:38 spc1 su(pam_unix)[8691]: session closed for user root
Apr  8 07:31:00 spc1 CROND[8752]: (mail) CMD (/usr/bin/python -S /var/lib/mailman/cron/qrunner) 
Apr  8 07:31:12 spc1 kernel: ------------[ cut here ]------------
Apr  8 07:31:12 spc1 kernel: kernel BUG at fs/buffer.c:2538!
Apr  8 07:31:12 spc1 kernel: invalid operand: 0000 [#1]
Apr  8 07:31:12 spc1 kernel: CPU:    0
Apr  8 07:31:12 spc1 kernel: EIP:    0060:[<c014b937>]    Not tainted
Apr  8 07:31:12 spc1 kernel: EFLAGS: 00010202
Apr  8 07:31:12 spc1 kernel: EIP is at submit_bh+0x1b7/0x1e0
Apr  8 07:31:12 spc1 kernel: eax: 00000010   ebx: c0b3f92c   ecx: 00000000   edx: cfcfd26c
Apr  8 07:31:12 spc1 kernel: esi: 00000002   edi: 00000001   ebp: c0b3f92c   esp: cfc39e10
Apr  8 07:31:12 spc1 kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 07:31:12 spc1 kernel: Process kjournald (pid: 16, threadinfo=cfc38000 task=cfc378a0)
Apr  8 07:31:12 spc1 kernel: Stack: 00000010 00000001 000092b0 00000000 c69e8260 00000001 00000002 00000001 
Apr  8 07:31:12 spc1 kernel:        c0b3f92c 00000002 00000001 00000001 c014b9cc 00000001 c0b3f92c c0b3fc38 
Apr  8 07:31:12 spc1 kernel:        cfc39ea0 c38538e0 cea92dc0 c01906a6 00000001 00000004 cfc39ea0 00000cfc 
Apr  8 07:31:12 spc1 kernel: Call Trace:
Apr  8 07:31:12 spc1 kernel:  [<c014b9cc>] ll_rw_block+0x6c/0x90
Apr  8 07:31:12 spc1 kernel:  [<c01906a6>] journal_commit_transaction+0x1056/0x1208
Apr  8 07:31:12 spc1 kernel:  [<c01157c9>] schedule+0x1a9/0x3b0
Apr  8 07:31:12 spc1 kernel:  [<c010b77a>] do_IRQ+0xba/0x120
Apr  8 07:31:12 spc1 kernel:  [<c0115a20>] default_wake_function+0x0/0x20
Apr  8 07:31:12 spc1 kernel:  [<c01929a0>] kjournald+0x130/0x1e0
Apr  8 07:31:12 spc1 kernel:  [<c0109192>] ret_from_fork+0x6/0x14
Apr  8 07:31:12 spc1 kernel:  [<c0192850>] commit_timeout+0x0/0x10
Apr  8 07:31:12 spc1 kernel:  [<c0192870>] kjournald+0x0/0x1e0
Apr  8 07:31:12 spc1 kernel:  [<c01071dd>] kernel_thread_helper+0x5/0x18
Apr  8 07:31:12 spc1 kernel: 
Apr  8 07:31:12 spc1 kernel: Code: 0f 0b ea 09 26 27 38 c0 e9 6d fe ff ff 0f 0b e9 09 26 27 38 
Apr  8 07:31:33 spc1 smbd[8734]: [2003/04/08 07:31:33, 0] smbd/server.c:open_sockets(238) 
Apr  8 07:31:33 spc1 smbd[8734]:   Got SIGHUP 
Apr  8 07:31:33 spc1 smb: smbd -HUP succeeded



