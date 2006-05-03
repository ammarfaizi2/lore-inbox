Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbWECQMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbWECQMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWECQMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:12:13 -0400
Received: from i-195-137-43-42.freedom2surf.net ([195.137.43.42]:50573 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965233AbWECQML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:12:11 -0400
Date: Wed, 3 May 2006 17:12:08 +0100
From: bloch@verdurin.com
To: linux-kernel@vger.kernel.org
Subject: MCE/SMP problem
Message-ID: <20060503161208.GB25250@bloch.smith.man.ac.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing an odd problem on a dual Xeon server.  After rebooting
following a power fault, it now no longer boots successfully with an SMP
kernel, but is fine with a uniprocessor kernel.

It seems to be related to MCE but there's nothing in /var/log/mcelog.
Adding the 'nomce' kernel parameter doesn't seem to help - this is the
Oops that appears in that case:

NMI Watchdog detected LOCKUP, CPU=3, registers:
CPU 3
Modules linked in:
Pid: 1,comm: swapper Tainted: G   M  2.6.9-34.106.unsupportedsmp
RIP: 0010:[<ffffffff8011be25>]
<ffffffff8011be25>{__smp_call_function+100}
RSP: 0018:00000100bff19cb8  EFLAGS: 00000097
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 0000000000000004
RDX: 0000ffff0000ffff RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: ffffffff8011bece
R13: 0000000000000000 R14: 0000000774977492 R15: ffffffff8031d0af
FS:  0000000000000000(0000) GS: ffffffff804db880(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000bff14000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo 0000010037e20000, task
00000100bff9b7f0
Stack: ffffffff8011bece 0000000000000000 0000000000000002
ffffffff00000000
       ffffffff8031d0c8 0000000000000000 0000000000000900
00000000ffffffff
       ffffffff803d5140 ffffffff8011bf0b
Call Trace:<ffffffff8011bece>{smp_really_stop_cpu+0}
<ffffffff8011bf0b>{smp_send_stop+52}
<ffffffff801367fe>{panic+235} <ffffffff801177ec>{print_mce+136}
<ffffffff801178c4>{mce_available+0}
<ffffffff80117c72>{do_machine_check+916}
<ffffffff8011134f>{machine_check+127}
<ffffffff802446f6>{sysdev_driver_register+29)

I tried Knoppix (which has a newer kernel) and there was a similar
result.

One odd detail is that just before the Oops appears some MCE events are
listed, and they refer to CPU 6 and CPU 7, even though they don't exist
on this machine.


Adam
