Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312836AbSCVUqL>; Fri, 22 Mar 2002 15:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312841AbSCVUqA>; Fri, 22 Mar 2002 15:46:00 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:6809 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312836AbSCVUpm>; Fri, 22 Mar 2002 15:45:42 -0500
Message-Id: <200203222046.g2MKkt200348@gs176.sp.cs.cmu.edu>
To: Dave Zarzycki <dave@zarzycki.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, dalecki@evision-ventures.com,
        ahaas@neosoft.com
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Thu, 21 Mar 2002 16:47:10 PST."
             <Pine.LNX.4.44.0203211626410.3631-100000@tidus.zarzycki.org> 
Date: Fri, 22 Mar 2002 15:46:55 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did a small tweak and "it seems to work".  I have no idea whether or
not this breaks other configs.

-John

--- linux/drivers/ide/alim15x3.c        Sun Jul 15 19:22:23 2001
+++ linux-2.4.18-hack/drivers/ide/alim15x3.c    Fri Mar 22 12:31:28 2002
@@ -574,17 +574,7 @@
                 * set south-bridge's enable bit, m1533, 0x79
                 */
                pci_read_config_byte(isa_dev, 0x79, &tmpbyte);
-               if (m5229_revision == 0xC2) {
-                       /*
-                        * 1543C-B0 (m1533, 0x79, bit 2)
-                        */
-                       pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
-               } else if (m5229_revision >= 0xC3) {
-                       /*
-                        * 1553/1535 (m1533, 0x79, bit 1)
-                        */
-                       pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
-               }
+               pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x04);
                /*
                 * Ultra66 cable detection (from Host View)
                 * m5229, 0x4a, bit0: primary, bit1: secondary 80 pin
