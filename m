Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbQKBHIw>; Thu, 2 Nov 2000 02:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbQKBHIm>; Thu, 2 Nov 2000 02:08:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23058 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129958AbQKBHI2>;
	Thu, 2 Nov 2000 02:08:28 -0500
Message-ID: <3A0112C8.E7D1117C@mandrakesoft.com>
Date: Thu, 02 Nov 2000 02:07:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Joachim Baader <hjb@pro-linux.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: test10 won't boot
In-Reply-To: <20001102070209.DFE7D355386@grumbeer.hjb.de>
Content-Type: multipart/mixed;
 boundary="------------C0BE1C111B71EEDC705C90A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C0BE1C111B71EEDC705C90A0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hans-Joachim Baader wrote:
> test10, compiled with gcc 2.95.2, won't boot on one of my machine.
> It stops after the "now booting the kernel" message. Yes, I have
> configured Virtual Terminal and VGA text console.

> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
> 00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
> 00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)

Does it boot with the attached patch?

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------C0BE1C111B71EEDC705C90A0
Content-Type: text/plain; charset=us-ascii;
 name="ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide.patch"

Index: drivers/ide/ide-pci.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/ide/ide-pci.c,v
retrieving revision 1.1.1.6
retrieving revision 1.1.1.6.6.1
diff -u -r1.1.1.6 -r1.1.1.6.6.1
--- drivers/ide/ide-pci.c	2000/10/27 07:45:53	1.1.1.6
+++ drivers/ide/ide-pci.c	2000/10/31 22:43:32	1.1.1.6.6.1
@@ -528,10 +528,7 @@
 	autodma = 1;
 #endif
 
-#if 1	/* what do do with this useful tool ??? */
-	if (pci_enable_device(dev))
-		return;
-#endif
+	pci_enable_device(dev);
 
 check_if_enabled:
 	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {

--------------C0BE1C111B71EEDC705C90A0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
