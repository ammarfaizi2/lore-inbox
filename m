Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJDFmG>; Fri, 4 Oct 2002 01:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSJDFmG>; Fri, 4 Oct 2002 01:42:06 -0400
Received: from fmr01.intel.com ([192.55.52.18]:8403 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261478AbSJDFmF>;
	Fri, 4 Oct 2002 01:42:05 -0400
Message-ID: <A9EA4AD6F6B9D511BBED00508B66C69A04B37715@fmsmsx111.fm.intel.com>
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "'twoller@crystal.cirrus.com'" <twoller@crystal.cirrus.com>,
       "'audio@crystal.cirrus.com'" <audio@crystal.cirrus.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: cs4281 driver fix
Date: Thu, 3 Oct 2002 22:47:36 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch below fixes a oops problem (in cs4281 sound driver) during system
reboot.

thanks,
suresh

 diff -Nru linux-2.5.39/sound/oss/cs4281/cs4281m.c~
linux-2.5.39/sound/oss/cs4281/cs4281m.c
--- linux-2.5.39/sound/oss/cs4281/cs4281m.c~    Thu Oct  3 20:56:19 2002
+++ linux-2.5.39/sound/oss/cs4281/cs4281m.c     Thu Oct  3 22:33:16 2002
@@ -4437,7 +4437,7 @@

 // ---------------------------------------------------------------------

-static void __devinit cs4281_remove(struct pci_dev *pci_dev)
+static void __devexit cs4281_remove(struct pci_dev *pci_dev)
 {
        struct cs4281_state *s = pci_get_drvdata(pci_dev);
        // stop DMA controller
@@ -4467,7 +4467,7 @@
        name:"cs4281",
        id_table:cs4281_pci_tbl,
        probe:cs4281_probe,
-       remove:cs4281_remove,
+       remove:__devexit_p(cs4281_remove),
        suspend:CS4281_SUSPEND_TBL,
        resume:CS4281_RESUME_TBL,
 };
