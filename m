Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288780AbSAELZH>; Sat, 5 Jan 2002 06:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288773AbSAELY7>; Sat, 5 Jan 2002 06:24:59 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:53990 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288769AbSAELYu>; Sat, 5 Jan 2002 06:24:50 -0500
Date: Sat, 5 Jan 2002 03:24:47 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tech@psidisk.com, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/drivers/scsi/pci2000.c fix for typo to make it compile
Message-ID: <20020105032447.A23817@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes a typo in
linux-2.5.2-pre8/drivers/scsi/pci2000.c, where the author was apparently
trying to release shost->host_lock, but accidentally specified the
nonexistant field shost->host_flag.  As a result, pci2000.c did not
compile.  shost->host_lock matches the corresponding spin_lock_irqsave call.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci2000.diff"

--- linux-2.5.2-pre8/drivers/scsi/pci2000.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/scsi/pci2000.c	Sat Jan  5 03:19:53 2002
@@ -389,7 +402,7 @@
 	OpDone (SCpnt, DID_OK << 16);
 
 irq_return:
-    spin_unlock_irqrestore(&shost->host_flag, flags);
+    spin_unlock_irqrestore(&shost->host_lock, flags);
 out:;
 }
 /****************************************************************

--jRHKVT23PllUwdXP--
