Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265745AbSJTC7k>; Sat, 19 Oct 2002 22:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265747AbSJTC7k>; Sat, 19 Oct 2002 22:59:40 -0400
Received: from fmr06.intel.com ([134.134.136.7]:41440 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265745AbSJTC7j>; Sat, 19 Oct 2002 22:59:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15794.7432.776941.185124@milikk.co.intel.com>
Date: Sat, 19 Oct 2002 20:03:36 -0700
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: AIC7xxx driver build failure
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The AIC 7xxx driver fails to build because the Makefile fails to
specify the correct include path to aicasm.

Justin, are you getting this?

This patch is against 2.5.44.


diff -u drivers/scsi/aic7xxx/Makefile:1.1.1.2 drivers/scsi/aic7xxx/Makefile:1.1.1.1.4.2
--- drivers/scsi/aic7xxx/Makefile:1.1.1.2	Fri Oct 18 22:54:44 2002
+++ drivers/scsi/aic7xxx/Makefile	Sat Oct 19 18:42:32 2002
@@ -39,7 +39,7 @@
 
 $(obj)/aic7xxx_seq.h: $(src)/aic7xxx.seq $(src)/aic7xxx.reg \
 		      $(obj)/aicasm/aicasm
-	$(obj)/aicasm/aicasm -I. -r $(obj)/aic7xxx_reg.h \
+	$(obj)/aicasm/aicasm -I$(obj) -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
 
 $(obj)/aic7xxx_reg.h: $(obj)/aix7xxx_seq.h

-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
