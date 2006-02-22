Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWBVWLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWBVWLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWBVWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:11:50 -0500
Received: from fmr19.intel.com ([134.134.136.18]:59528 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751519AbWBVWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:46 -0500
Date: Wed, 22 Feb 2006 14:12:38 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Subject: [PATCH 0/13] ACPI objects for SATA/PATA
Message-Id: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is primarily ACPI objects support for SATA/PATA.
It applies to 2.6.16-rc4.

ACPI objects for SATA/PATA add support for the _GTF, _SDD,
_GTM, and _STM ACPI methods.  ACPI methods are used to:

PATA:  get and set channel timings and modes and taskfiles
SATA:  get and set drive data and taskfiles

Taskfile operations are not limited.  Examples that I have
seen are (not limited to):
- power management:
  . enable or disable drive-initiated power management
- performance:
  . enable drive cache; set transfer mode (PIO/DMA)
- security
  . lock the disk access password

There is also an addition here to send a Standby Immediate
command to SATA/PATA drives during shutdown.  This should be
done (at least for some drives) to cause a safe and orderly
shutdown of the drive heads (i.e., protect data).

Caveat:  Some people are reporting good results from these
patches.  Unfortunately I have problems with them myself.
My test platforms usually suspend successfully but they
don't resume successfully.  Oh, and there may be a BUG
during sleep-shutdown processing where a sleep happens
while a spinlock is held.

These patches definitely need some time in -mm, but be
prepared to revert them or to use
	libata.noacpi=1
to disable them.  Also, please use
	libata.printk=0xff
to enable full debug messages.

If you want to test this without using -mm, you can either
apply the patch series (13 patches) or one rolled-up
(combined) patch.  The combined patch is available at:
http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-rollup-2616-rc4.patch

Still TBD:  more calls to ata_acpi_push_timing(), e.g.,
during resume, to set PATA hard drive timing and mode.
And fix the BUG above.

---
~Randy
