Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271033AbUJVC77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbUJVC77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271079AbUJVC5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:57:52 -0400
Received: from proper.eecs.harvard.edu ([140.247.60.120]:902 "EHLO
	bostoncoop.net") by vger.kernel.org with ESMTP id S271192AbUJVCwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:52:42 -0400
Date: Thu, 21 Oct 2004 22:52:37 -0400
From: Adam Rosi-Kessel <adam@rosi-kessel.org>
To: linux-kernel@vger.kernel.org
Subject: i915 crashes on Thinkpad X40 with "i915_probe" error
Message-ID: <20041022025237.GA19966@bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to use the i915 DRM module new in 2.6.9 on an IBM Thinkpad
X40.  This is a fairly common laptop for Linux users, so I expect others
will experience similar problems.  The module crashes before X even
starts up, so I'm pretty sure it has nothing to do with my X server (I'm
using Debian sid).  Google and LKML searches for i915_probe give 0
results, so I guess this is pretty new.  Here's the error--I don't know
if this kind of backtrace is at all helpful: 

[drm:i915_probe] *ERROR* Cannot initialize the agpgart module.
inter_module_unregister: no entry for 'drm'------------[ cut here ]------------
kernel BUG at kernel/intermodule.c:104!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: i915
CPU:    0
EIP:    0060:[<c012b83e>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-joehill)
EIP is at inter_module_unregister+0x9b/0xe4
eax: 0000002e   ebx: e008bcb3   ecx: c03c8d64   edx: 00000286
esi: 00000000   edi: 00000000   ebp: c03ca568   esp: dd721f10
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 417, threadinfo=dd720000 task=dd0baaa0)
Stack: c0376f80 e008bcb3 00000005 00000000 00000000 00000000 e0088734 e008bcb3
       e008bcb3 e0091ba0 e0091ba0 df665c00 e009232c e0084a4c e008baa1 e00912c0
       e0091ba0 00000010 00000016 00000017 00000000 df663000 00000000 dd720000
Call Trace:
 [<e0088734>] i915_stub_register+0xb9/0x1c8 [i915]
 [<e0084a4c>] i915_probe+0xf9/0x339 [i915]
 [<c020273e>] pci_find_device+0x2f/0x33
 [<e000a047>] drm_init+0x47/0x66 [i915]
 [<c0131f5a>] sys_init_module+0x183/0x22f
 [<c010405f>] syscall_call+0x7/0xb
Code: c0 74 18 89 5c 24 04 c7 04 24 20 6f 37 c0 e8 da 02 ff ff 83 c4 08 5b 5e 5f 5d c3 89 5c 24 04 c7 04 24 80 6f 37 c0 e8 c2 02 ff ff <0f> 0b 68 00 03 64 37 c0 eb de e8 bc 5e 23 00 eb be 8b 45 04 89

Kernel config at http://adam.rosi-kessel.org/temp8/config-2.6.9-i915-crash
Longer syslog excerpt at http://adam.rosi-kessel.org/temp8/syslog-i915-crash
-- 
Adam Rosi-Kessel
http://adam.rosi-kessel.org
