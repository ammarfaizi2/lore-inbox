Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSBUJNr>; Thu, 21 Feb 2002 04:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290587AbSBUJNg>; Thu, 21 Feb 2002 04:13:36 -0500
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:43657 "EHLO
	server1.i-a.co.uk") by vger.kernel.org with ESMTP
	id <S290120AbSBUJN0>; Thu, 21 Feb 2002 04:13:26 -0500
Date: Thu, 21 Feb 2002 09:13:19 +0000
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: linux-kernel@vger.kernel.org
Subject: HPT372 on KR7A-RAID
Message-Id: <20020221091319.37e74cba.lkml@andyjeffries.co.uk>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

The HPT chipset on the KR7A-RAID is not detected.  It comes through with a
revision 5, which crashes the Kernel (panic) on 2.4.16.  The patch below
adds the revision for the HPT372 chipset which is the relevant one,
however this will break again when a new revision comes out.  I would like
to be able to print a warning if the revision is higher than the one in
the array and if it is allow a parameter to fake the chipset as being a
lower one (at the users risk), but quite frankly my Kernel programming is
not that good!!

I don't know if this has been fixed in 2.4.17/18, if it has...sorry! :-)

--- linux-2.4.16/drivers/ide/hpt366.c	Wed Feb 20 10:35:25 2002
+++ linux/drivers/ide/hpt366.c	Wed Feb 20 10:37:37 2002
@@ -207,7 +207,7 @@
 	char *p		= buffer;
 	u32 bibma	= bmide_dev->resource[4].start;
 	u32 bibma2 	= bmide2_dev->resource[4].start;
-	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A"};
+	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A", "HPT372"};
 	u8  c0 = 0, c1 = 0;
 	u32 class_rev;
 
--- linux-2.4.16/drivers/ide/ide-pci.c	Wed Feb 20 10:35:25 2002
+++ linux/drivers/ide/ide-pci.c	Wed Feb 20 10:37:22 2002
@@ -828,7 +828,7 @@
 	ide_pci_device_t *d2;
 	unsigned char pin1 = 0, pin2 = 0;
 	unsigned int class_rev;
-	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A"};
+	char *chipset_names[] = {"HPT366", "HPT366", "HPT368", "HPT370", "HPT370A", "HPT372"};
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return;



-- 
Andy Jeffries
Linux/PHP Programmer

- Windows Crash HOWTO: compile the code below in VC++ and run it!
main (){for(;;){printf("Hung up\t\b\b\b\b\b\b");}}
