Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRBYNAj>; Sun, 25 Feb 2001 08:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBYNAT>; Sun, 25 Feb 2001 08:00:19 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:34539 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S129126AbRBYNAO>;
	Sun, 25 Feb 2001 08:00:14 -0500
Message-ID: <3A990148.4F113D8@itwm.uni-kl.de>
Date: Sun, 25 Feb 2001 13:57:44 +0100
From: braun@itwm.fhg.de
Organization: ITWM e. V.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jhartmann@valinux.com
Subject: Small fix for via agpgart in 2.2.19pre13
Content-Type: multipart/mixed;
 boundary="------------9A7AF173CC701E337111C58B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9A7AF173CC701E337111C58B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

the following fix from linux-2.4.2 is not yet in 2.2.19pre.
The agpgart module can not be properly unloaded and 
reloaded without it.
(see http://uwsg.indiana.edu/hypermail/linux/kernel/0101.2/1273.html
for details)

Martin Braun
--------------9A7AF173CC701E337111C58B
Content-Type: text/plain; charset=us-ascii;
 name="linux-2.2.19pre-agpgart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.2.19pre-agpgart.diff"

--- linux-2.2.19-pre13/drivers/char/agp/agpgart_be.c	Sat Feb 24 13:29:30 2001
+++ linux/drivers/char/agp/agpgart_be.c	Sun Feb 25 13:32:16 2001
@@ -1304,9 +1304,11 @@
 	aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
-	pci_write_config_dword(agp_bridge.dev, VIA_ATTBASE, 0);
 	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE,
 			      previous_size->size_value);
+	/* Do not disable by writing 0 to VIA_ATTBASE, it screws things up
+	 * during reinitialization.
+	 */
 }
 
 static void via_tlbflush(agp_memory * mem)

--------------9A7AF173CC701E337111C58B--

