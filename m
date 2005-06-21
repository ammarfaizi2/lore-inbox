Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVFUJZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVFUJZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVFUJYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 05:24:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21891 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262074AbVFUJWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 05:22:30 -0400
Date: Tue, 21 Jun 2005 14:52:23 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kexec on panic vmlinux initrd fix
Message-ID: <20050621092223.GE3746@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a minor bug fix in kexec to resolve the problem of loading panic
kernel with initrd. 

Thanks
Vivek 

o Problem: Loading a capture kenrel fails if initrd is also being loaded.
  This has been observed for vmlinux image for kexec on panic case.

o This patch fixes the problem. In segment location and size verification
  logic, minor correction has been done. Segment memory end (mend) should be
  mstart + memsz - 1. This one byte offset was source of failure for initrd
  loading which was being loaded at hole boundary.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-mm1-vivek/kernel/kexec.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/kexec.c~kexec-on-panic-vmlinux-initrd-fix kernel/kexec.c
--- linux-2.6.12-mm1/kernel/kexec.c~kexec-on-panic-vmlinux-initrd-fix	2005-06-21 14:46:57.905192856 +0530
+++ linux-2.6.12-mm1-vivek/kernel/kexec.c	2005-06-21 14:46:57.914191488 +0530
@@ -279,7 +279,7 @@ static int kimage_crash_alloc(struct kim
 		unsigned long mstart, mend;
 
 		mstart = image->segment[i].mem;
-		mend = mstart + image->segment[i].memsz;
+		mend = mstart + image->segment[i].memsz - 1;
 		/* Ensure we are within the crash kernel limits */
 		if ((mstart < crashk_res.start) || (mend > crashk_res.end))
 			goto out;
_
