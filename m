Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263074AbSJGPIb>; Mon, 7 Oct 2002 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263075AbSJGPIa>; Mon, 7 Oct 2002 11:08:30 -0400
Received: from mail1.cirrus.com ([141.131.3.20]:9642 "EHLO mail1.cirrus.com")
	by vger.kernel.org with ESMTP id <S263074AbSJGPI1>;
	Mon, 7 Oct 2002 11:08:27 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C05233FD0@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <tom.woller@cirrus.com>
To: "'Siddha, Suresh B'" <suresh.b.siddha@intel.com>,
       "Woller, Thomas" <tom.woller@cirrus.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: cs4281 driver fix
Date: Mon, 7 Oct 2002 10:13:59 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for the patch. i've been out having baby #2 but back on
email now. 

i have not been up on recent 2.5.x mods but the modification
looks simple and other audio drivers have the same modifications.
applying the fix to the 2.5.41(?) tree seems safe. i'll send your
patch to the 2.5.x audio responsible person, but not sure whom it
is? (i don't *think* it's alan).  also the cs46xx driver will
need the same mod which i'll create and send this week.
tom woller
tom.woller@cirrus.com

-----Original Message-----
From: Siddha, Suresh B [mailto:suresh.b.siddha@intel.com]
Sent: Friday, October 04, 2002 12:48 AM
To: 'twoller@crystal.cirrus.com'; 'audio@crystal.cirrus.com';
'linux-kernel@vger.kernel.org'
Subject: cs4281 driver fix


Patch below fixes a oops problem (in cs4281 sound driver) during
system
reboot.

thanks,
suresh

 diff -Nru linux-2.5.39/sound/oss/cs4281/cs4281m.c~
linux-2.5.39/sound/oss/cs4281/cs4281m.c
--- linux-2.5.39/sound/oss/cs4281/cs4281m.c~    Thu Oct  3
20:56:19 2002
+++ linux-2.5.39/sound/oss/cs4281/cs4281m.c     Thu Oct  3
22:33:16 2002
@@ -4437,7 +4437,7 @@

 //
-----------------------------------------------------------------
----

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
