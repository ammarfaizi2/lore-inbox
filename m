Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRJGSCL>; Sun, 7 Oct 2001 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276519AbRJGSCB>; Sun, 7 Oct 2001 14:02:01 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:54278 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S276511AbRJGSBr>; Sun, 7 Oct 2001 14:01:47 -0400
Reply-To: <frey@scs.ch>
From: "Martin Frey" <frey@scs.ch>
To: <becker@scyld.com>, <jgarzik@mandrakesoft.com>,
        <tjeerd.mulder@fujitsu-siemens.com>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Fix for drivers/net/natsemi.c on 64 bit platforms
Date: Sun, 7 Oct 2001 14:01:54 -0400
Message-ID: <011d01c14f5a$27c8da50$6a876ace@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the natsemi.c Ethernet driver cuts the upper bits of
the address when accessing the EEPROM. Changing "int ee_addr"
to "long ee_addr" in eeprom_read() fixes the problem for me on Alpha.
The Bug is in the 2.2.x driver from Donald as
well as in the 2.4.x driver. I tested the patch
only on 2.4.x however, since it is actually trivial, I guess
it will also work for Donalds version.

Here is the patch for 2.4.10:
--- linux-2.4.10/drivers/net/natsemi.c  Tue Aug 14 13:14:12 2001
+++ linux-2.4.10.digitalpw/drivers/net/natsemi.c        Fri Oct  5 13:25:59 2001
@@ -633,7 +633,7 @@
 {
        int i;
        int retval = 0;
-       int ee_addr = addr + EECtrl;
+       long ee_addr = addr + EECtrl;
        int read_cmd = location | EE_ReadCmd;
        writel(EE_Write0, ee_addr);

and here for the driver on the Scyld page:
--- natsemi.c.orig      Sun Oct  7 13:49:03 2001
+++ natsemi.c   Sun Oct  7 13:49:16 2001
@@ -499,7 +499,7 @@
 {
        int i;
        int retval = 0;
-       int ee_addr = addr + EECtrl;
+       long ee_addr = addr + EECtrl;
        int read_cmd = location | EE_ReadCmd;
        writel(EE_Write0, ee_addr);

Regards, Martin

-- 
Supercomputing Systems AG       email: frey@scs.ch
Martin Frey                     web:   http://www.scs.ch/~frey/
at Compaq Computer Corporation  phone: +1 603 884 4266
ZKO2-3R75, 110 Spit Brook Road, Nashua, NH 03062

