Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWAJHEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWAJHEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWAJHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:04:34 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42957 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750896AbWAJHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:04:34 -0500
Date: Tue, 10 Jan 2006 12:34:22 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Morton Andrew Morton <akpm@osdl.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: [PATCH] kdump: vmcore compilation warning fix
Message-ID: <20060110070422.GB5003@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o fs/proc/vmcore.c compilation gives warnings on ppc64. The reason being
  that u64 is defined as unsigned long hence u64* is not same as loff_t*
  and compiler cribs.

o Changed the parameter type to u64* instead of loff_t* to resolve the
  conflict.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---


diff -puN fs/proc/vmcore.c~ppc64-vmcore-compilation-warning-fix fs/proc/vmcore.c
--- linux-2.6.15-mm2-1M/fs/proc/vmcore.c~ppc64-vmcore-compilation-warning-fix	2006-01-09 06:59:06.000000000 -0800
+++ linux-2.6.15-mm2-1M-root/fs/proc/vmcore.c	2006-01-09 07:37:06.000000000 -0800
@@ -42,7 +42,7 @@ struct proc_dir_entry *proc_vmcore = NUL
 
 /* Reads a page from the oldmem device from given offset. */
 static ssize_t read_from_oldmem(char *buf, size_t count,
-			     loff_t *ppos, int userbuf)
+				u64 *ppos, int userbuf)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes;
_
