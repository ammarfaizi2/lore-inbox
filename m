Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTHCO6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271199AbTHCO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 10:58:09 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:56463 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271197AbTHCO6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 10:58:05 -0400
Date: Sun, 03 Aug 2003 07:57:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1036] New: Badness in local_bh_enable at kernel/softirq.c:113 
Message-ID: <100580000.1059922668@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1036

           Summary: Badness in local_bh_enable at kernel/softirq.c:113
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: janfrode@parallab.no


Distribution: gentoo
Hardware Environment: AMD AthlonXP
Software Environment:

ppp-2.4.1-r14
pptpclient-1.2.0

Problem Description:

My pptp client connections keeps dying, syslogging:

Aug  3 13:35:36 [pppd] Using interface ppp0
Aug  3 13:35:36 [pppd] Connect: ppp0 <--> /dev/pts/4
Aug  3 13:35:36 [/etc/hotplug/net.agent] NET add event not supported
Aug  3 13:35:38 [pptp] anon log[decaps_hdlc:pptp_gre.c:198]: PPP mode seems to
be Asynchronous._
Aug  3 13:35:39 [pppd] Remote message: Welcome^M^J
Aug  3 13:35:41 [pppd] local  IP address 129.177.43.23
Aug  3 13:35:41 [pppd] remote IP address 129.177.43.1
Aug  3 13:36:07 [pppd] Unsupported protocol 0xd44a received
Aug  3 13:36:57 [pppd] Unsupported protocol 0xcc4a received
aug  3 13:38:20 [su(pam_unix)] session opened for user root by (uid=1001)
Aug  3 13:39:21 [anacron] Job `cron.daily' started
Aug  3 13:39:29 [crontab] (root) LIST (root)_
Aug  3 13:39:37 [pptp] anon warn[decaps_gre:pptp_gre.c:300]: short read (-1):
Message too long
Aug  3 13:39:37 [pptp] anon log[callmgr_main:pptp_callmgr.c:234]: Closing connection
Aug  3 13:39:37 [pptp] anon log[pptp_conn_close:pptp_ctrl.c:308]: Closing PPTP
connection
Aug  3 13:39:39 [pptp] anon log[call_callback:pptp_callmgr.c:74]: Closing connection
Aug  3 13:39:39 [pppd] Hangup (SIGHUP)
Aug  3 13:39:39 [kernel] Badness in local_bh_enable at kernel/softirq.c:113
Aug  3 13:39:39 [pppd] Modem hangup
Aug  3 13:39:39 [pppd] Connection terminated.
Aug  3 13:39:39 [pppd] Connect time 4.1 minutes.
Aug  3 13:39:39 [pppd] Sent 310556 bytes, received 1615363 bytes.
Aug  3 13:39:39 [/etc/hotplug/net.agent] NET remove event not supported
Aug  3 13:39:39 [pppd] Failed to open /dev/pts/4: No such file or directory
                - Last output repeated 9 times -
Aug  3 13:39:39 [pppd] Exit.


And giving this call trace in the kernel log:

Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c0120b88>] local_bh_enable+0x88/0x90
 [<c037bd54>] ppp_async_push+0xa4/0x1b0
 [<c015dd04>] __lookup_hash+0x64/0xd0
 [<c037b621>] ppp_asynctty_wakeup+0x31/0x60
 [<c032bff6>] pty_unthrottle+0x56/0x60
 [<c032898a>] check_unthrottle+0x3a/0x40
 [<c0328a34>] n_tty_flush_buffer+0x14/0x50
 [<c032c3ae>] pty_flush_buffer+0x5e/0x60
 [<c03253ac>] do_tty_hangup+0x3ac/0x420
 [<c0326823>] release_dev+0x5b3/0x600
 [<c03fc000>] snd_pcm_oss_init_substream+0x50/0x90
 [<c01402fe>] zap_pmd_range+0x4e/0x70
 [<c014036e>] unmap_page_range+0x4e/0x90
 [<c0326beb>] tty_release+0x2b/0x60
 [<c015091e>] __fput+0xce/0xe0
 [<c014ef5b>] filp_close+0x4b/0x80
 [<c011e5fc>] put_files_struct+0x6c/0xe0
 [<c011f1c5>] do_exit+0x165/0x340
 [<c011f3d5>] sys_exit+0x15/0x20
 [<c010930b>] syscall_call+0x7/0xb



Steps to reproduce:

Don't know how to trigger it, but it happens all the time.


