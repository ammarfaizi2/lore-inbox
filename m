Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUL2Edg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUL2Edg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 23:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUL2Edg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 23:33:36 -0500
Received: from mail.tyan.com ([66.122.195.4]:21009 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261317AbUL2Ed2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 23:33:28 -0500
Message-ID: <3174569B9743D511922F00A0C943142307290EEE@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 256 apic id for amd64
Date: Tue, 28 Dec 2004 20:43:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4ED60.FBFE3200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4ED60.FBFE3200
Content-Type: text/plain

Can someone who maintains the x86-64 io_apic.c look at my patch about 256
apic id for amd64?

YH


------_=_NextPart_000_01C4ED60.FBFE3200
Content-Type: application/octet-stream;
	name="x86_64_ioapic.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x86_64_ioapic.patch"

diff -uNr linux-2.6.10/arch/x86_64/kernel/io_apic.c =
linux-2.6.10.new.x86_64/arch/x86_64/kernel/io_apic.c=0A=
--- linux-2.6.10/arch/x86_64/kernel/io_apic.c	2004-12-24 =
13:34:45.000000000 -0800=0A=
+++ linux-2.6.10.new.x86_64/arch/x86_64/kernel/io_apic.c	2004-12-28 =
15:46:35.828076192 -0800=0A=
@@ -1148,6 +1148,19 @@=0A=
 	unsigned char old_id;=0A=
 	unsigned long flags;=0A=
 =0A=
+        unsigned int max_apic;=0A=
+        u32 vendor;=0A=
+=0A=
+        /* get the max apic */=0A=
+        vendor =3D read_pci_config(0, 0x18, 0, PCI_VENDOR_ID);=0A=
+        vendor &=3D 0xffff;=0A=
+        if(vendor =3D=3D PCI_VENDOR_ID_AMD) { /* AMD */=0A=
+                max_apic =3D (((read_pci_config(0, 0x18, 0, 0x68)>>17) =
& 3) =3D=3D 3) ? 0xff : 0xf;=0A=
+        }=0A=
+        else { /* intel:  how to find out if intel em64t support 256 =
apic id? */=0A=
+                max_apic =3D 0xf;=0A=
+        }=0A=
+=0A=
 	/*=0A=
 	 * Set the IOAPIC ID to the value stored in the MPC table.=0A=
 	 */=0A=
@@ -1160,7 +1173,7 @@=0A=
 		=0A=
 		old_id =3D mp_ioapics[apic].mpc_apicid;=0A=
 =0A=
-		if (mp_ioapics[apic].mpc_apicid >=3D 0xf) {=0A=
+		if (mp_ioapics[apic].mpc_apicid >=3D max_apic) {=0A=
 			apic_printk(APIC_QUIET,KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in =
the MPC table!...\n",=0A=
 				apic, mp_ioapics[apic].mpc_apicid);=0A=
 			apic_printk(APIC_QUIET,KERN_ERR "... fixing up to %d. (tell your hw =
vendor)\n",=0A=

------_=_NextPart_000_01C4ED60.FBFE3200--
