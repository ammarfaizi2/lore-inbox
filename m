Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbUAPWoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbUAPWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:44:31 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16369 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265734AbUAPWo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:44:27 -0500
Date: Fri, 16 Jan 2004 14:44:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: alangrimes@starpower.net
Subject: [Bugme-new] [Bug 1893] New: running Mozilla's update routine causes	kernel oops, reliably! (fwd)
Message-ID: <22640000.1074293061@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1893

           Summary: running Mozilla's update routine causes kernel oops,
                    reliably!
    Kernel Version: 2.6.1
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: alangrimes@starpower.net


Distribution: N/A, _VERY_ old installation, mostly a source distro at this point
in time. 
Hardware Environment: Athlon SMP, 1gb of ECC ram, (ECC enabled). 
Software Environment: ppp 2.4.1, mozilla.
Problem Description: updating mozilla causes dialup connection to drop + kernel
oops, 

Steps to reproduce: 

1. I beleive that this is a SMP related bug related to the recient preemptive
kernel enhancements...
2. it might be in either the kernel "softirq.c" file or the ppp driver, I don't
know which. 
3. I'm using wvdial to dial the modem.
4. I run, in the mozilla source directory, "gmake client.mk checkout" as per the
instructions. This command runs a while then stalls.
5. soon thereafter I get a "peer not responding" error in the wvdial window
associated with this kernel oops: 

Badness in local_bh_enable at kernel/softirq.c:121
Call Trace:
 [<c012c6dc>] local_bh_enable+0x8c/0x90
 [<c02a3f69>] ppp_async_push+0xb9/0x1a0
 [<c02a384e>] ppp_asynctty_wakeup+0x2e/0x70
 [<c026faa4>] uart_flush_buffer+0x84/0x90
 [<c02503ee>] do_tty_hangup+0x40e/0x4b0
 [<c0250534>] disassociate_ctty+0x64/0x210
 [<c012aa44>] do_exit+0x2b4/0x450
 [<c012acb2>] do_group_exit+0x42/0xe0
 [<c010b59b>] syscall_call+0x7/0xb

6. this problem is extremely reproducable. 
7. versions: 
bash-2.05$ ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux (none) 2.6.1 #2 SMP Sun Jan 11 12:30:36 EST 2004 i686 unknown unknown GNU/
Linux
 
Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      0.9.14
e2fsprogs              1.26
jfsutils               1.0.15
reiserfsprogs          3.6.9
pcmcia-cs              3.1.31
nfs-utils              0.3.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
bash-2.05$


