Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTDPKvm (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTDPKvm 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 06:51:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40201 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264294AbTDPKvk (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 06:51:40 -0400
Date: Wed, 16 Apr 2003 12:03:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [Bug 592] New: BUG at kernel/softirq.c:105
Message-ID: <20030416120330.B7188@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to trace this callpath, and have hit a dead end in
release_dev().  It seems to go weird after there, which makes it
difficult to audit the code path.

Anyone got any ideas?

I'm not too bothered about this bug since I don't look after the ppp
or tty (line discipline) code, so I'm also looking for someone else
to assign this to.

----- Forwarded message from bugme-daemon@osdl.org -----

Date: Wed, 16 Apr 2003 03:20:37 -0700
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 592] New: BUG at kernel/softirq.c:105

http://bugme.osdl.org/show_bug.cgi?id=592

           Summary: BUG at kernel/softirq.c:105
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: kees.bakker@xs4all.nl


Problem Description:
At shutdown, when pppd gets killed this BUG shows up. Here is the syslog:
Apr 14 22:10:28 iris kernel: kernel BUG at kernel/softirq.c:105!
Apr 14 22:10:28 iris kernel: invalid operand: 0000 [#1]
Apr 14 22:10:28 iris kernel: CPU:    0
Apr 14 22:10:28 iris kernel: EIP:    0060:[<c011f8a3>]    Not tainted
Apr 14 22:10:28 iris kernel: EFLAGS: 00010002
Apr 14 22:10:28 iris kernel: EIP is at local_bh_enable+0x43/0x50
Apr 14 22:10:28 iris kernel: eax: 00000001   ebx: de840e00   ecx: 00000000  
edx: de840eb2
Apr 14 22:10:28 iris kernel: esi: 00000000   edi: 00000000   ebp: 00000000  
esp: de599e28
Apr 14 22:10:28 iris kernel: ds: 007b   es: 007b   ss: 0068
Apr 14 22:10:28 iris kernel: Process pptp (pid: 388, threadinfo=de598000
task=de90e740)
Apr 14 22:10:28 iris kernel: Stack: c0237910 dfddaf40 c01a95db dfddaf40 00000001
de8b8000 dede74c0 de8b8000 
Apr 14 22:10:28 iris kernel:        de840e00 de8b89e4 00000000 c0237231 de840e00
de8b8000 deca3000 c01fd15f 
Apr 14 22:10:28 iris kernel:        de8b8000 deca3000 de8b8000 c01f9db3 deca3000
c01f9e33 deca3000 deca3000 
Apr 14 22:10:28 iris kernel: Call Trace:
Apr 14 22:10:28 iris kernel:  [<c0237910>] ppp_async_push+0x90/0x170
Apr 14 22:10:28 iris kernel:  [<c01a95db>] _devfs_unregister+0x5b/0xa0
Apr 14 22:10:28 iris kernel:  [<c0237231>] ppp_asynctty_wakeup+0x31/0x70
Apr 14 22:10:28 iris kernel:  [<c01fd15f>] pty_unthrottle+0x5f/0x70
Apr 14 22:10:28 iris kernel:  [<c01f9db3>] check_unthrottle+0x33/0x40
Apr 14 22:10:28 iris kernel:  [<c01f9e33>] n_tty_flush_buffer+0x13/0x60
Apr 14 22:10:28 iris kernel:  [<c01fd53c>] pty_flush_buffer+0x6c/0x70
Apr 14 22:10:28 iris kernel:  [<c01f70fe>] do_tty_hangup+0x2fe/0x340
Apr 14 22:10:28 iris kernel:  [<c01f83b7>] release_dev+0x637/0x680
Apr 14 22:10:28 iris kernel:  [<c0138239>] slab_destroy+0xa9/0xd0
Apr 14 22:10:28 iris kernel:  [<c013cf63>] unmap_page_range+0x43/0x70
Apr 14 22:10:28 iris kernel:  [<c0138e73>] cache_flusharray+0xe3/0x100
Apr 14 22:10:28 iris kernel:  [<c01f87df>] tty_release+0xf/0x20
Apr 14 22:10:28 iris kernel:  [<c014bad1>] __fput+0xc1/0xd0
Apr 14 22:10:28 iris kernel:  [<c014a31d>] filp_close+0x4d/0x80
Apr 14 22:10:28 iris kernel:  [<c011d577>] put_files_struct+0x57/0xc0
Apr 14 22:10:28 iris kernel:  [<c011e012>] do_exit+0x102/0x300
Apr 14 22:10:28 iris kernel:  [<c014a31d>] filp_close+0x4d/0x80
Apr 14 22:10:28 iris kernel:  [<c011e2c2>] do_group_exit+0x52/0x80
Apr 14 22:10:28 iris kernel:  [<c010b14b>] syscall_call+0x7/0xb
Apr 14 22:10:28 iris kernel: 
Apr 14 22:10:28 iris kernel: Code: 0f 0b 69 00 e9 d7 32 c0 eb d3 8d 76 00 53 89
c1 9c 5b fa b8 


Steps to reproduce:
Start pppd
Shutdown the system (I haven't tried to do a killall pppd)

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

