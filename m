Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCTPjK>; Tue, 20 Mar 2001 10:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRCTPjA>; Tue, 20 Mar 2001 10:39:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26260 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130471AbRCTPiy>;
	Tue, 20 Mar 2001 10:38:54 -0500
Message-ID: <3AB77944.20018B9A@mandrakesoft.com>
Date: Tue, 20 Mar 2001 10:37:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, tytso@mit.edu,
        guthrie@infonautics.com
Subject: [PATCH] Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and 
 later
In-Reply-To: <Pine.LNX.3.96.1010320080638.18764C-100000@mandrakesoft.mandrakesoft.com> <3AB77485.3BAB3AFE@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------6431E9132317BAAA418AE8C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6431E9132317BAAA418AE8C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On closer inspection, that patch I linked to appears to be incomplete.

Can you try the attached patch, to see if it fixes the
absence-of-serial_cb problem?

Thanks,

	Jeff


P.S. I'm surprised serial_cb in 2.4 worked at all, for anybody.  I guess
they must be using pcmcia_cs's serial_cb, not the kernel's serial_cb...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------6431E9132317BAAA418AE8C3
Content-Type: text/plain; charset=us-ascii;
 name="serial-modem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-modem.patch"

Index: drivers/char/serial.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/char/serial.c,v
retrieving revision 1.1.1.33
diff -u -r1.1.1.33 serial.c
--- drivers/char/serial.c	2001/03/20 12:59:44	1.1.1.33
+++ drivers/char/serial.c	2001/03/20 15:35:47
@@ -59,8 +59,8 @@
  *
  */
 
-static char *serial_version = "5.05";
-static char *serial_revdate = "2000-12-13";
+static char *serial_version = "5.05a";
+static char *serial_revdate = "2001-03-20";
 
 /*
  * Serial driver configuration section.  Here are the various options:
@@ -4610,7 +4610,8 @@
 	 * (Should we try to make guesses for multiport serial devices
 	 * later?) 
 	 */
-	if ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL ||
+	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
+	    ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
 	    (dev->class & 0xff) > 6)
 		return 1;
 
@@ -4708,6 +4709,8 @@
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
+       { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	 PCI_CLASS_COMMUNICATION_MODEM << 8, 0xffff00, },
        { 0, }
 };
 

--------------6431E9132317BAAA418AE8C3--

