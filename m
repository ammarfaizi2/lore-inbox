Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRCCJWX>; Sat, 3 Mar 2001 04:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbRCCJWO>; Sat, 3 Mar 2001 04:22:14 -0500
Received: from duba03h03-0.dplanet.ch ([212.35.36.23]:64274 "EHLO
	duba03h03-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S130433AbRCCJWD>; Sat, 3 Mar 2001 04:22:03 -0500
Message-Id: <200103030920.KAA24571@duba03h03-0.dplanet.ch>
Date: Sat, 03 Mar 2001 10:21:06 +0100
From: Andreas Tscharner <starfire@dplanet.ch>
To: Martin Mares <mj@suse.cz>, Scott Murray <scott@spiteful.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1 ISA DMA hang on ALi15x3
Reply-To: starfire@dplanet.ch
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="spruceNYGVYMTQBEMOCYEZBDAD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--spruceNYGVYMTQBEMOCYEZBDAD
Content-Type: text/plain
Content-Transfer-Type: 8bit

Hello World,

This little patch enables the workaround for the ISA DMA bug on ALi15x3
chipsets with the PCI-ISA bridge. The patch was originally written by
Angelo Di Filippo <adifilip@ubiquity.it> for Kernel 2.3.45. I adapted it to
Kernel 2.4.1.

This chipset can be found in many laptops of the Acer Extensa series, and
the bug prevents the sound chip (an OPL3/SA2) from working.


--- drivers/pci/quirks.c.orig   Fri Mar  2 17:40:45 2001
+++ drivers/pci/quirks.c        Fri Mar  2 16:10:35 2001
@@ -261,6 +261,7 @@
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,     
PCI_DEVICE_ID_VIA_82C586_0,     quirk_isa_dma_hangs },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,     
PCI_DEVICE_ID_VIA_82C596,       quirk_isa_dma_hangs },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
+       { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_AL,      
PCI_DEVICE_ID_AL_M1533,         quirk_isa_dma_hangs },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_S3,      
PCI_DEVICE_ID_S3_868,           quirk_s3_64M },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_S3,      
PCI_DEVICE_ID_S3_968,           quirk_s3_64M },
        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,   
PCI_DEVICE_ID_INTEL_82437,      quirk_triton }, 


The patch is also attached in case my mailtool kills the format (I don't
hope it does)

Best regards
	Andreas
-- 
Andreas Tscharner                                     starfire@dplanet.ch
-------------------------------------------------------------------------
"Programming today is a race between software engineers striving to build 
bigger and better idiot-proof programs, and the Universe trying to produce 
bigger and better idiots. So far, the Universe is winning." -- Rich Cook 

--spruceNYGVYMTQBEMOCYEZBDAD
Content-Type: application/octet-stream; name="PCI_ISA_bridge.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="PCI_ISA_bridge.patch"

LS0tIGRyaXZlcnMvcGNpL3F1aXJrcy5jLm9yaWcJRnJpIE1hciAgMiAxNzo0MDo0NSAyMDAxCisr
KyBkcml2ZXJzL3BjaS9xdWlya3MuYwlGcmkgTWFyICAyIDE2OjEwOjM1IDIwMDEKQEAgLTI2MSw2
ICsyNjEsNyBAQAogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJUENJX0RF
VklDRV9JRF9WSUFfODJDNTg2XzAsCXF1aXJrX2lzYV9kbWFfaGFuZ3MgfSwKIAl7IFBDSV9GSVhV
UF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgyQzU5NiwJcXVp
cmtfaXNhX2RtYV9oYW5ncyB9LAogCXsgUENJX0ZJWFVQX0ZJTkFMLCAgICAgIFBDSV9WRU5ET1Jf
SURfSU5URUwsICAgIFBDSV9ERVZJQ0VfSURfSU5URUxfODIzNzFTQl8wLCAgcXVpcmtfaXNhX2Rt
YV9oYW5ncyB9LAorCXsgUENJX0ZJWFVQX0ZJTkFMLCAgICAgIFBDSV9WRU5ET1JfSURfQUwsICAg
ICAgIFBDSV9ERVZJQ0VfSURfQUxfTTE1MzMsICAgICAgICAgcXVpcmtfaXNhX2RtYV9oYW5ncyB9
LAogCXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9TMywJUENJX0RFVklDRV9JRF9T
M184NjgsCQlxdWlya19zM182NE0gfSwKIAl7IFBDSV9GSVhVUF9IRUFERVIsCVBDSV9WRU5ET1Jf
SURfUzMsCVBDSV9ERVZJQ0VfSURfUzNfOTY4LAkJcXVpcmtfczNfNjRNIH0sCiAJeyBQQ0lfRklY
VVBfRklOQUwsCVBDSV9WRU5ET1JfSURfSU5URUwsIAlQQ0lfREVWSUNFX0lEX0lOVEVMXzgyNDM3
LCAJcXVpcmtfdHJpdG9uIH0sIAo=
--spruceNYGVYMTQBEMOCYEZBDAD--

