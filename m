Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTDGH2m (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTDGH2m (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:28:42 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:16417
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263311AbTDGH2l (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 03:28:41 -0400
Date: Mon, 7 Apr 2003 03:35:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, "" <jsanchez@cs.ucf.edu>
Subject: [PATCH][2.5] rng_vendor_ops init.data is referenced after being
 freed
Message-ID: <Pine.LNX.4.50.0304070317250.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug report from J Sanchez in #kernelnewbies

<imperito> Unable to handle kernel paging request at virtual address 184c5f21
<imperito> printing eip:
<imperito> 184c5f21
<imperito> *pde = 00000000
<imperito> Oops: 0000 [#14]
<imperito> cpufreak:    0
<imperito> EIP:    0060:[<184c5f21>]    Not tainted
<imperito> EFLAGS: 00010202
<imperito> EIP is at 0x184c5f21
<imperito> eax: c05f5cf4   ebx: 00001000   ecx: ef070304   edx: f45d0000
<imperito> esi: 00000000   edi: 00000000   ebp: 0804d038   esp: f45d1f50
<imperito> ds: 007b   es: 007b   ss: 0068
<imperito> Process cat (pid: 966, threadinfo=f45d0000 task=f74d0080)
<imperito> Stack: c031b909 f7551800 f45d0000 f45d0000 00000000 00000000 deb9f780 00000000 
<imperito>        00000000 deb9f7a0 c014b6e8 deb9f780 0804d038 00001000 deb9f7a0 f7551820 
<imperito>        0804e000 deb9f780 fffffff7 0804d038 f45d0000 c014ba4a deb9f780 0804d038 
<imperito> Call Trace:
<imperito>  [<c031b909>] rng_dev_read+0x46/0x16d
<imperito>  [<c014b6e8>] vfs_read+0xc5/0x199
<imperito>  [<c014ba4a>] sys_read+0x3e/0x55
<imperito>  [<c010a967>] syscall_call+0x7/0xb
<imperito> Code:  Bad EIP value.

Index: linux-2.5.66/drivers/char/hw_random.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/drivers/char/hw_random.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 hw_random.c
--- linux-2.5.66/drivers/char/hw_random.c	24 Mar 2003 23:39:36 -0000	1.1.1.1
+++ linux-2.5.66/drivers/char/hw_random.c	7 Apr 2003 07:02:22 -0000
@@ -126,7 +126,7 @@ enum {
 	rng_hw_via,
 };
 
-static struct rng_operations rng_vendor_ops[] __initdata = {
+static struct rng_operations rng_vendor_ops[] = {
 	/* rng_hw_none */
 	{ },
 

-- 
function.linuxpower.ca
