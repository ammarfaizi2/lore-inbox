Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTFTUrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTFTUrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:47:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20938 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264643AbTFTUrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:47:13 -0400
Date: Fri, 20 Jun 2003 13:49:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 837] New: PPP async spin_lock_bh badness
Message-ID: <137660000.1056142194@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=837

           Summary: PPP async spin_lock_bh badness
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: shemminger@osdl.org


Distribution: Redhat 8.0
Hardware Environment: 1 CPU PIII
Software Environment: 
Problem Description: PPP async driver locking issue

Steps to reproduce:
  * Run user mode PPP over Ethernet which runs PPP over pseudo-tty.

  * Get warning:
Badness in local_bh_enable at kernel/softirq.c:109
Call Trace:
 [<c011bb5e>] local_bh_enable+0x7e/0x80
 [<f8a5bc00>] ppp_async_push+0x90/0x180 [ppp_async]
 [<c0126a38>] rcu_process_callbacks+0xc8/0xf0
 [<f8a5b521>] ppp_asynctty_wakeup+0x31/0x60 [ppp_async]
 [<c01ca8d7>] pty_unthrottle+0x57/0x60
 [<c01c74ec>] check_unthrottle+0x3c/0x40
 [<c01c7564>] n_tty_flush_buffer+0x14/0x60
 [<c01cac86>] pty_flush_buffer+0x66/0x70
 [<c01c40f7>] do_tty_hangup+0x3b7/0x410
 [<c01c54dd>] release_dev+0x67d/0x6c0
 [<c0138c4e>] zap_pmd_range+0x4e/0x70
 [<c0138cbe>] unmap_page_range+0x4e/0x80
 [<c01c5891>] tty_release+0x11/0x20
 [<c0147c8e>] __fput+0xee/0x100
 [<c01464db>] filp_close+0x4b/0x80
 [<c01197ac>] put_files_struct+0x7c/0xf0
 [<c011a296>] do_exit+0x116/0x330
 [<c011a4e5>] sys_exit+0x15/0x20
 [<c01092df>] syscall_call+0x7/0xb


