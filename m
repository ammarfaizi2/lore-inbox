Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVDDCIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVDDCIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVDDCIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:08:38 -0400
Received: from fmr18.intel.com ([134.134.136.17]:16030 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261971AbVDDCIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:08:22 -0400
Subject: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:05:42 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The following 6 patches try to add suspend-to-ram (or S3) SMP support
for IA32. It's for support HT based system suspend/resume currently and
most of the code are also useful for physical CPU hotplug.

In a SMP system, after S3 resume, the BP is starting to execute the ACPI
wakeup address just like the UP case. And the APs possibly are in a
BIOS's busy loop. This just looks like the boot time case, we must use a
SIPI circle to wakeup the APs.

We uses the CPU hotplug infrastructure. In order to reuse the SMP boot
code, we clean up all CPU states after the CPU is dead, including its
idle thread, runqueue and other CPU states. Since the CPU is in idle
thread before suspend, we don't require to save and restore after resume
most of the CPU states.

Now the sequences of S3 are:
1. hotremove all APs, put them into idle thread.
2. follow UP S3 code path.
3. warm boot all APs.
4. UP all APs.

The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
tree. To test the SMP S3, please don't enable MTRR driver (it's SMP
broken for Suspend/resume). And please kill syslogd, there is a bug in
the sususpend/resume refrigerator mechanism, which can be fixed by
swsusp2 refrigerator.
I'm looking forward to your comments. Thanks in advance!

Thanks,
Shaohua

