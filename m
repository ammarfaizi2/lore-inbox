Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUHDC2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUHDC2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUHDC11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:27:27 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:63441 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267237AbUHDC1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:27:01 -0400
Subject: MTRR driver model support broken on SMP.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091585241.3303.6.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 12:07:21 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

MTRR driver support is broken on SMP because it calls smp functions with
interrupts disabled, but interrupts should be disabled because it is
called via device_power_up.

Badness in smp_call_function at arch/i386/kernel/smp.c:565
 [<c0107f88>] dump_stack+0x1e/0x20
 [<c0116927>] smp_call_function+0x12b/0x137
 [<c011063f>] set_mtrr+0x67/0x121
 [<c0110c9b>] mtrr_restore+0x4f/0x73
 [<c0219c0f>] sysdev_resume+0x6f/0xf0
 [<c021d591>] device_power_up+0x8/0xf
 [<f882d6f9>] suspend_drivers_resume+0x1a/0x49 [suspend_core]
 [<f882e2ea>] do_suspend2_resume_2+0xf6/0x11d [suspend_core]
 [<c02577f6>] do_suspend2_lowlevel+0x716/0x71c
 [<f882dd6d>] save_image+0x1b8/0x252 [suspend_core]
 [<f882f357>] do_activate+0x934/0x973 [suspend_core]
 [<c013cf83>] software_suspend_pending+0x75/0x77
 [<c013cfdc>] proc_software_suspend_pending+0x8/0xd
 [<c0191fc9>] proc_file_write+0x3b/0x3d
 [<c015fe3a>] vfs_write+0xa2/0x10e
 [<c015ff42>] sys_write+0x3f/0x5d
 [<c01070e1>] sysenter_past_esp+0x52/0x71

Regards,

Nigel

