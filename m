Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTLDGnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTLDGnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:43:15 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:36028 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S263135AbTLDGnJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:43:09 -0500
Date: Wed, 3 Dec 2003 22:44:31 +0100
From: Bardok - Jorge <bardok@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: ALI M1563 driver patch
Message-Id: <20031203224431.5ee3dfc9.bardok@telefonica.net>
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "}XiQz%h~NtrdX,jUxyL}d95]c@,d$jgXJHYy0[U/`V\"?I.-R/]I$}E!=o&=75"va-TYg,
 x&mt,#yZ_VBiN|higa,s_#^l:4~B%`Gk~9/i^Vagq-"$2/OH@MIHW0b!06&7:&5",}`A*sX%4:q<,v
 B2XvviM.U9dE:rjMCQ$@T2jbdIyP#&8{K))(c$E:]zXnTfS2V#n&$\p,UxlUJUQFQ&FO@=}QwE~'e,
 XqkNslrhAMCDufxLE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is intended to be used in order to make the ALI M1563 chipset work
with the 2.6 kernel series.

The original driver produces a kernel panic, as it always tries to initialize
the, sometimes, non-existent M1533 chipset (as it happens with my laptop).

This patch just defines the ALI M1563 symbol, and, if M1533 chipset is not
found, it tries to initialize the M1563 chipset.

I would like to apologize for writting and not being suscribed to the list, but
the 290-messages-in-a-day warning in the FAQ scared me a little bit... so
please, if anyone replies to this mail, I would like to be added as a CC to the
answers.

Thank you, and I hope this patch to be useful (and in the correct format, as I'm
new in this kernel-patching-thing):

	Jorge García

-----------------------------------------------------------
patch to pci_ids.h
-----------------------------------------------------------

--- /usr/src/linux-2.6.0-test11/include/linux/pci_ids.h 2003-11-26
21:43:39.000000000 +0100
+++ /usr/src/linux/include/linux/pci_ids.h      2003-12-03 20:13:17.000000000
+0100
@@ -971,6 +971,7 @@
 #define PCI_DEVICE_ID_AL_M1531         0x1531
 #define PCI_DEVICE_ID_AL_M1533         0x1533
 #define PCI_DEVICE_ID_AL_M1541         0x1541
+#define PCI_DEVICE_ID_AL_M1563         0x1563
 #define PCI_DEVICE_ID_AL_M1621         0x1621
 #define PCI_DEVICE_ID_AL_M1631         0x1631
 #define PCI_DEVICE_ID_AL_M1632         0x1632


-----------------------------------------------------------
patch to alim15x3.c
-----------------------------------------------------------

--- /usr/src/linux-2.6.0-test11/drivers/ide/pci/alim15x3.c      2003-11-26
21:43:35.000000000 +0100
+++ /usr/src/linux/drivers/ide/pci/alim15x3.c   2003-12-03 20:16:48.000000000
+0100
@@ -584,6 +584,13 @@

        isa_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
NULL);

+       /*
+        * If ALI 1533 southbridge was not found,
+        * we try to find the ALI 1563 southbridge.
+        */
+       if (!isa_dev)
+               isa_dev = pci_find_device(PCI_VENDOR_ID_AL,
PCI_DEVICE_ID_AL_M1563, NULL);
+
 #if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
        if (!ali_proc) {
                ali_proc = 1;


---------------------------------------------------------------------------
| Jorge García Ochoa de Aspuru                                            |
| e-mail: bardok@telefonica.net - shadow@bardok.net                       |
---------------------------------------------------------------------------
