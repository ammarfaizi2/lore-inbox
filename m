Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUA0POy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUA0POy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:14:54 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:36284 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264285AbUA0POt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:14:49 -0500
Date: Tue, 27 Jan 2004 07:14:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jaba@mikrobitti.fi
Subject: [Bug 1959] New: cs46xx driver mmap_valid 0-->1 in	kernel 2.6.x? 
Message-ID: <365550000.1075216480@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1959

           Summary: cs46xx driver mmap_valid 0-->1 in kernel 2.6.x?
    Kernel Version: 2.6.x
            Status: NEW
          Severity: normal
             Owner: drivers_sound@kernel-bugs.osdl.org
         Submitter: jaba@mikrobitti.fi


Distribution: Gentoo Linux
Hardware Environment: Asus A7V133, AMD Athlon
Software Environment: Gentoo Linux 1.4, default-x86-1.4, gcc-3.3.2,
glibc-2.3.3_pre20040117-r0, 2.6.2-rc1-mm2
Problem Description: This problem has been bothering me all over the kernel
2.6.x. I don't know if any other applications are affected by this bug, but a
game called Enemy Territory surely is.

With the default kernel 2.6 cs46xx driver (with "new DSP support" enabled) the
sound in Enemy Territory doesn't work at all, complaining "unable to mmap
/dev/dsp" during the ET startup. But if I do the patch below to cs46xx.c, sound
starts to work.

The patch I've used:
---
--- cs46xx_old.c        2004-01-27 14:09:46.625277768 +0200
+++ cs46xx.c    2004-01-27 12:32:28.000000000 +0200
@@ -54 +54 @@
-static int mmap_valid[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 0};
+static int mmap_valid[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
---

Is there a reason to keep mmap_valid=0 in cs46xx driver or is this a real bug? I
haven't seen any new bugs with this patch applied, all the multimedia
applications (mplayer, xine, xmms, noatun) keeps on working.


