Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSGPSAe>; Tue, 16 Jul 2002 14:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317915AbSGPR6e>; Tue, 16 Jul 2002 13:58:34 -0400
Received: from g96069.scn-net.ne.jp ([210.231.96.69]:53972 "EHLO deisui.org")
	by vger.kernel.org with ESMTP id <S317939AbSGPR5Y>;
	Tue, 16 Jul 2002 13:57:24 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] orinoco_pci.c build fix
X-Face: ki?-"~Ovqy(#SEZ2FpdUK,3>)p.@}$.vl{eIZ-Uy43$&[S1#'y{hX&A3T@xA)u0!_4Lg.vA
 ^{d(.VU0(X#Zf,~9Kha_$nl7W/(b9r;]%_&:OUA@g0LF'S2<%~T
X-Attribution: DU
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
From: Daiki Ueno <ueno@unixuser.org>
Date: Wed, 17 Jul 2002 03:09:58 +0900
Message-ID: <44a4b565-6a1b-420d-9729-378868991c76@deisui.org>
User-Agent: T-gnus/6.15.7 (based on Oort Gnus v0.07) (revision 02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While I've tried to get drivers/net/wireless/orinoco_pci.c compiled in,
I happened to get an error:

>drivers/net/wireless/wireless_net.o(.data+0x534): undefined reference to `local symbols in discarded section .text.exit'

Is there a missing __devexit_p?  Here is the patch to 2.4.19-rc1.

--- drivers/net/wireless/orinoco_pci.c~	Wed Jul 17 02:37:33 2002
+++ drivers/net/wireless/orinoco_pci.c	Wed Jul 17 02:38:22 2002
@@ -364,9 +364,11 @@
 	name:"orinoco_pci",
 	id_table:orinoco_pci_pci_id_table,
 	probe:orinoco_pci_init_one,
-	remove:orinoco_pci_remove_one,
+	remove:__devexit_p(orinoco_pci_remove_one),
+#ifdef CONFIG_PM
 	suspend:0,
 	resume:0
+#endif /* CONFIG_PM */
 };
 
 static int __init orinoco_pci_init(void)

Regards,
-- 
Daiki Ueno
