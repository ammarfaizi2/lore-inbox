Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288165AbSAHQfn>; Tue, 8 Jan 2002 11:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSAHQfd>; Tue, 8 Jan 2002 11:35:33 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:33287 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S288159AbSAHQfR>;
	Tue, 8 Jan 2002 11:35:17 -0500
Message-ID: <3C3B1FC2.6050103@epfl.ch>
Date: Tue, 08 Jan 2002 17:35:14 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH]Fix for macro in agp.h
Content-Type: multipart/mixed;
 boundary="------------060906040400080908010807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906040400080908010807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Here is a $0.02 patch that fixes the dirty 'A_IDX*' macros in agp.h. 
These were referring to a variable 'i' that is local to the routine 
where these macros are called (namely 'agp_generic_create_gatt_table' in 
'agpgart_be.c').
The patch is against 2.4.17
Thanks Phil Brown for pointing this one...

Best regards
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------060906040400080908010807
Content-Type: text/plain;
 name="patch-fix_A_IDX-2.4.17"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix_A_IDX-2.4.17"

diff -Nru -x CVS -x tcp_diag.c linux-2.4.17.clean/drivers/char/agp/agp.h linux-2.4.17.dirty/drivers/char/agp/agp.h
--- linux-2.4.17.clean/drivers/char/agp/agp.h	Wed Dec 19 12:57:53 2001
+++ linux-2.4.17.dirty/drivers/char/agp/agp.h	Tue Jan  8 17:20:18 2002
@@ -143,11 +143,11 @@
 #define A_SIZE_32(x)	((aper_size_info_32 *) x)
 #define A_SIZE_LVL2(x)  ((aper_size_info_lvl2 *) x)
 #define A_SIZE_FIX(x)	((aper_size_info_fixed *) x)
-#define A_IDX8()	(A_SIZE_8(agp_bridge.aperture_sizes) + i)
-#define A_IDX16()	(A_SIZE_16(agp_bridge.aperture_sizes) + i)
-#define A_IDX32()	(A_SIZE_32(agp_bridge.aperture_sizes) + i)
-#define A_IDXLVL2()	(A_SIZE_LVL2(agp_bridge.aperture_sizes) + i)
-#define A_IDXFIX()	(A_SIZE_FIX(agp_bridge.aperture_sizes) + i)
+#define A_IDX8(idx)	(A_SIZE_8(agp_bridge.aperture_sizes) + (idx))
+#define A_IDX16(idx)	(A_SIZE_16(agp_bridge.aperture_sizes) + (idx))
+#define A_IDX32(idx)	(A_SIZE_32(agp_bridge.aperture_sizes) + (idx))
+#define A_IDXLVL2(idx)	(A_SIZE_LVL2(agp_bridge.aperture_sizes) + (idx))
+#define A_IDXFIX(idx)	(A_SIZE_FIX(agp_bridge.aperture_sizes) + (idx))
 #define MAXKEY		(4096 * 32)
 
 #define AGPGART_MODULE_NAME	"agpgart"
diff -Nru -x CVS -x tcp_diag.c linux-2.4.17.clean/drivers/char/agp/agpgart_be.c linux-2.4.17.dirty/drivers/char/agp/agpgart_be.c
--- linux-2.4.17.clean/drivers/char/agp/agpgart_be.c	Mon Jan  7 08:10:27 2002
+++ linux-2.4.17.dirty/drivers/char/agp/agpgart_be.c	Tue Jan  8 17:16:37 2002
@@ -586,13 +586,13 @@
 				i++;
 				switch (agp_bridge.size_type) {
 				case U8_APER_SIZE:
-					agp_bridge.current_size = A_IDX8();
+					agp_bridge.current_size = A_IDX8(i);
 					break;
 				case U16_APER_SIZE:
-					agp_bridge.current_size = A_IDX16();
+					agp_bridge.current_size = A_IDX16(i);
 					break;
 				case U32_APER_SIZE:
-					agp_bridge.current_size = A_IDX32();
+					agp_bridge.current_size = A_IDX32(i);
 					break;
 					/* This case will never really 
 					 * happen. 

--------------060906040400080908010807--

