Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHIPqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHIPqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUHIPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:46:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37876 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266663AbUHIPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:43:22 -0400
Date: Mon, 9 Aug 2004 17:43:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [2.6 patch] fix megaraid.c with PROC_FS=n
Message-ID: <20040809154308.GT26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with CONFIG_PROC_FS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x524563): In function `megaraid_probe_one':
: undefined reference to `mega_create_proc_entry'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/drivers/scsi/megaraid.c.old	2004-08-09 17:35:54.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/drivers/scsi/megaraid.c	2004-08-09 17:39:58.000000000 +0200
@@ -4905,7 +4905,9 @@
 
 	pci_set_drvdata(pdev, host);
 
+#ifdef CONFIG_PROC_FS
 	mega_create_proc_entry(hba_count, mega_proc_dir_entry);
+#endif
 
 	error = scsi_add_host(host, &pdev->dev);
 	if (error)


