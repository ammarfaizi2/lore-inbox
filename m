Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUCMGfo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUCMGfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 01:35:44 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:64262 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S263057AbUCMGfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 01:35:42 -0500
Date: Fri, 12 Mar 2004 22:35:40 -0800
To: linux-kernel@vger.kernel.org
Cc: nk@iname.com
Subject: 2.6.4 OOPS in nfsd (repeatable)
Message-ID: <20040313063540.GA882@defiant.tbdnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the OOPS I reported for 2.6.4-rc1-bk3 is still in 2.6.4.

To trigger it, I mount a ext3 FS from a Solaris 5.7 machine using
-o proto=tcp,vers=3 and then run a "find /mnt | wc -l" on the Sun against a
directory containing about 4000 files.
Mounting with -o proto=tcp,vers=2 works fine.

Linux version 2.6.4 (nkiesel@defiant) (gcc version 3.3.3 (Debian 20040306)) #16 Thu Mar 11 01:25:25 PST 2004

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y

Mar 12 22:17:52 defiant kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar 12 22:17:52 defiant kernel:  printing eip:
Mar 12 22:17:52 defiant kernel: c025e061
Mar 12 22:17:52 defiant kernel: *pde = 00000000
Mar 12 22:17:52 defiant kernel: Oops: 0002 [#1]
Mar 12 22:17:52 defiant kernel: PREEMPT 
Mar 12 22:17:52 defiant kernel: CPU:    0
Mar 12 22:17:52 defiant kernel: EIP:    0060:[do_tcp_sendpages+401/2752]    Not tainted
Mar 12 22:17:52 defiant kernel: EFLAGS: 00010287
Mar 12 22:17:52 defiant kernel: EIP is at do_tcp_sendpages+0x191/0xac0
Mar 12 22:17:52 defiant kernel: eax: f02ccf08   ebx: f73dfe40   ecx: 00000008   edx: 00000000
Mar 12 22:17:52 defiant kernel: esi: 00000001   edi: f02ccf00   ebp: f2a88bc0   esp: f607fe28
Mar 12 22:17:52 defiant kernel: ds: 007b   es: 007b   ss: 0068
Mar 12 22:17:52 defiant kernel: Process nfsd (pid: 659, threadinfo=f607e000 task=f60932e0)
Mar 12 22:17:52 defiant kernel: Stack: f607fe6c f010d6c0 c014d9cc c02f08a0 f01dde34 f607fe6c f02ccf10 f2a88c14 
Mar 12 22:17:52 defiant kernel:        00000008 00000000 00000000 00000000 000005b4 f2a88d8c 00000000 f607fe88 
Mar 12 22:17:52 defiant kernel:        00007530 00000000 f2a88bc0 00000000 00000008 c025ea02 00000008 00000000 
Mar 12 22:17:52 defiant kernel: Call Trace:
Mar 12 22:17:52 defiant kernel:  [open_private_file+28/144] open_private_file+0x1c/0x90
Mar 12 22:17:52 defiant kernel:  [tcp_sendpage+114/128] tcp_sendpage+0x72/0x80
Mar 12 22:17:52 defiant kernel:  [__crc_utf8_wctomb+6196969/6417782] svc_sendto+0x142/0x260 [sunrpc]
Mar 12 22:17:52 defiant kernel:  [__crc_utf8_wctomb+6200955/6417782] svc_tcp_sendto+0x44/0xa0 [sunrpc]
Mar 12 22:17:52 defiant kernel:  [__crc_utf8_wctomb+6202944/6417782] svc_send+0xa9/0xf0 [sunrpc]
Mar 12 22:17:52 defiant kernel:  [__crc_pm_idle+794151/1453519] fh_put+0x136/0x180 [nfsd]
Mar 12 22:17:52 defiant kernel:  [__crc_utf8_wctomb+6205252/6417782] svc_authenticate+0x4d/0x80 [sunrpc]
Mar 12 22:17:52 defiant kernel:  [__crc_pm_idle+841889/1453519] nfs3svc_encode_readdirres+0x0/0xa0 [nfsd]
Mar 12 22:17:52 defiant kernel:  [__crc_utf8_wctomb+6194212/6417782] svc_process+0x18d/0x5e0 [sunrpc]
Mar 12 22:17:52 defiant kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 12 22:17:52 defiant kernel:  [__crc_pm_idle+783779/1453519] nfsd+0x1c2/0x370 [nfsd]
Mar 12 22:17:52 defiant kernel:  [__crc_pm_idle+783329/1453519] nfsd+0x0/0x370 [nfsd]
Mar 12 22:17:52 defiant kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Mar 12 22:17:52 defiant kernel: 
Mar 12 22:17:52 defiant kernel: Code: ff 42 04 8b 7c 24 28 8b 83 a4 00 00 00 8d 04 f0 8d 50 10 89 
