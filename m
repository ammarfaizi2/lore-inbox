Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281371AbRKPNDo>; Fri, 16 Nov 2001 08:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281368AbRKPNDf>; Fri, 16 Nov 2001 08:03:35 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:59909 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281381AbRKPNDW>;
	Fri, 16 Nov 2001 08:03:22 -0500
Message-ID: <3BF50E98.6020403@epfl.ch>
Date: Fri, 16 Nov 2001 14:03:20 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmeta.com>
Subject: [PATCH]fix for Intel 8xx agp in 2.4.15-pre5
Content-Type: multipart/mixed;
 boundary="------------060602030204020205010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602030204020205010201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

There is a mistake in the routine 'intel_8xx_tlbflush' in the agpgart 
module (and I think I am responsible for it... shame on me !).
Anyway here is the patch (against 2.4.15-pre5).

Best regards.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------060602030204020205010201
Content-Type: text/plain;
 name="patch-agp_intel_8xx-2.4.15-pre5_fix_tlbflush"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_intel_8xx-2.4.15-pre5_fix_tlbflush"

diff -Nru linux-2.4.15-pre5.clean/drivers/char/agp/agpgart_be.c linux-2.4.15-pre5/drivers/char/agp/agpgart_be.c
--- linux-2.4.15-pre5.clean/drivers/char/agp/agpgart_be.c	Fri Nov 16 08:45:44 2001
+++ linux-2.4.15-pre5/drivers/char/agp/agpgart_be.c	Fri Nov 16 13:51:44 2001
@@ -1462,7 +1462,7 @@
   pci_read_config_dword(agp_bridge.dev, INTEL_AGPCTRL, &temp);
   pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, temp & ~(1 << 7));
   pci_read_config_dword(agp_bridge.dev, INTEL_AGPCTRL, &temp);
-  pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, temp & (1 << 7));
+  pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, temp | (1 << 7));
 }
 
 

--------------060602030204020205010201--

