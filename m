Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVB0Fpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVB0Fpu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 00:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVB0Fpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 00:45:50 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:39321 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261350AbVB0Fpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 00:45:41 -0500
Date: Sun, 27 Feb 2005 06:45:40 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: BUG_* broken since 2.6.11-rc1 ...
Message-ID: <20050227054540.GB2514@mail.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

couldn't believe it when I discovered that BUG_ON()
and friends is broken (at least on x86) ...
(while it was definitely working with 2.6.10 ;)

the following 'patch':

--- ./init/main.c.orig	Thu Feb 17 19:25:21 2005
+++ ./init/main.c	Sun Feb 27 05:13:45 2005
@@ -684,6 +684,8 @@ static int init(void * unused)
 	 * trying to recover a really broken machine.
 	 */
 
+	BUG_ON(0==0);
+
 	if (execute_command)
 		run_init_process(execute_command);
 

results in this oops:
(look at the filename and linenumber ;)

Freeing unused kernel memory: 244k freed
------------[ cut here ]------------
kernel BUG at <bad filename>:9377!
invalid operand: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0100415>]    Not tainted VLI
EFLAGS: 00010296   (2.6.11-rc1) 
EIP is at init+0xf5/0x1a0
eax: 00000002   ebx: c04ed91c   ecx: 00000001   edx: 00000001
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c2113fdc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c2113000 task=c2114a80)
Stack: 00000000 00000002 00000000 c0100320 00000000 c0101375 00000000 00000000 
       00000000 
Call Trace:
 [<c0100320>] init+0x0/0x1a0
 [<c0101375>] kernel_thread_helper+0x5/0x10
Code: 00 00 89 54 24 08 89 44 24 04 e8 97 f8 05 00 85 c0 78 6d c7 04 24 00 00 0  <0>Kernel panic - not syncing: Attempted to kill init!

this is still true/valid for 2.6.11-rc5 ...

best,
Herbert

