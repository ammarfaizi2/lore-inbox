Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUBYXxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUBYXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:51:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40689 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261621AbUBYXsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:48:06 -0500
Date: Wed, 25 Feb 2004 15:48:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 2195] New: Reproduced bug 1594: kernel BUG at mm/slab.c:1269
Message-ID: <4430000.1077752882@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2195

           Summary: Reproduced bug 1594: kernel BUG at mm/slab.c:1269
    Kernel Version: 2.6.3
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: schofield@ftw.at


Distribution: Mepis / Debian sid x86

Hardware Environment: x86: Intel P4 1.6GHz

Software Environment: 

gcc (GCC) 3.3.3 (Debian)

config file:
http://userver.ftw.at/~ejs/resources/config_2.6.3_kernel_bug

kernel compiled for this config file for x86:
http://userver.ftw.at/~ejs/resources/bzImage_2.6.3_kernel_bug

Patched kernel from 2.6.2 to 2.6.3 with official patch at
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fpatch-2.6.3.bz2.
B

Problem Description:

Same bug as #1594; line number incremented by one since 2.6.0-test10 ... 

Before the 2.6.3 patch yesterday this bug did not occur.  Since then it occurs
each reboot.  The system has been unstable today, but I cannot isolate the cause.

Message in /var/log/messages:

...
Feb 24 11:58:44 polaris kernel: kmem_cache_create: duplicate cache dm_io
Feb 24 11:58:44 polaris kernel: ------------[ cut here ]------------
Feb 24 11:58:44 polaris kernel: kernel BUG at mm/slab.c:1269!
Feb 24 11:58:44 polaris kernel: invalid operand: 0000 [#1]
Feb 24 11:58:44 polaris kernel: CPU:    0
Feb 24 11:58:44 polaris kernel: EIP:    0060:[<c013a45c>]    Not tainted
Feb 24 11:58:44 polaris kernel: EFLAGS: 00010202
Feb 24 11:58:44 polaris kernel: EIP is at kmem_cache_create+0x3ac/0x49c
Feb 24 11:58:44 polaris kernel: eax: 00000029   ebx: f7df46dc   ecx: c04006f8
edx: 00000282
Feb 24 11:58:44 polaris kernel: esi: c0320502   edi: f89a2ebb   ebp: f7d13cc8
esp: f797df40
Feb 24 11:58:44 polaris kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 11:58:44 polaris kernel: Process modprobe (pid: 924, threadinfo=f797c000
task=f7cc6080)
Feb 24 11:58:44 polaris kernel: Stack: c03077a0 f89a2eb5 00000000 f797df5c f7d13
d04 c0000000 fffffffc 00000000
Feb 24 11:58:44 polaris kernel:        00000000 f797c000 f89a5c60 c034da58 f8849
03b f89a2eb5 00000010 00000080
Feb 24 11:58:44 polaris kernel:        00000000 00000000 00000000 00000000 f8849
0a9 c034da70 f797c000 f89a5f00
Feb 24 11:58:44 polaris kernel: Call Trace:
Feb 24 11:58:44 polaris kernel:  [<f884903b>] local_init+0x3b/0x98 [dm_mod]
Feb 24 11:58:44 polaris kernel:  [<f88490a9>] dm_init+0x11/0x3d [dm_mod]
Feb 24 11:58:44 polaris kernel:  [<c0131996>] sys_init_module+0x117/0x228
Feb 24 11:58:44 polaris kernel:  [<c010a86b>] syscall_call+0x7/0xb
Feb 24 11:58:44 polaris kernel:
Feb 24 11:58:44 polaris kernel: Code: 0f 0b f5 04 c7 6f 30 c0 8b 0b e9 76 ff ff
ff 8b 47 34 c7 04
...

Steps to reproduce:

Try booting with the kernel cited above, or booting from a kernel compiled with
the 2.6.3 sources and the config file given ...


