Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTCGN2x>; Fri, 7 Mar 2003 08:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCGN2x>; Fri, 7 Mar 2003 08:28:53 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:14768 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261568AbTCGN2g>; Fri, 7 Mar 2003 08:28:36 -0500
Message-Id: <4.3.2.7.2.20030307143243.00b7abe0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 07 Mar 2003 14:40:09 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Linux 2.4.21pre5-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patches for :
		Radeon 9000 support
		Delete chipset display in drm_agpsupport.h
		This has been done in 2.5 and DRI/DRM mainline
		Alan, please apply.

	Margit

--- linux-2.4.20/drivers/video/radeon.h 2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20mw0/drivers/video/radeon.h      2003-03-07 
10:41:19.000000000 +0100
@@ -15,6 +15,8 @@
  #define PCI_DEVICE_ID_RADEON_PM                0x4c52
  #define PCI_DEVICE_ID_RADEON_QL                0x514c
  #define PCI_DEVICE_ID_RADEON_QW                0x5157
+#define PCI_DEVICE_ID_RADEON_IG                0x4966
+#define PCI_DEVICE_ID_RADEON_LF                0x4c66

  #define RADEON_REGSIZE                 0x4000

--- linux-2.4.20/drivers/video/radeonfb.c       2003-03-07 
13:47:00.000000000 +0100
+++ linux-2.4.20mw0/drivers/video/radeonfb.c    2003-03-07 
10:42:18.000000000 +0100
@@ -101,6 +101,8 @@
         RADEON_LW,      /* Radeon Mobility M7 */
         RADEON_LY,      /* Radeon Mobility M6 */
         RADEON_LZ,      /* Radeon Mobility M6 */
+       RADEON_IG,      /* Radeon RV250 (9000) */
+       RADEON_LF,      /* Radeon Mobility 9000 */
         RADEON_PM       /* Radeon Mobility P/M */
  };

@@ -128,6 +130,8 @@
         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LW, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_LW},
         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_LY},
         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_LZ},
+       { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_IG, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_IG},
+       { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LF, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_LF},
         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_PM, PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, RADEON_PM},
         { 0, }
  };
@@ -861,6 +865,15 @@
                 case PCI_DEVICE_ID_RADEON_PM:
                         strcpy(rinfo->name, "Radeon P/M ");
                         rinfo->hasCRTC2 = 1;
+                       break;
+               case PCI_DEVICE_ID_RADEON_IG:
+                       strcpy(rinfo->name, "Radeon 9000 IG ");
+                       rinfo->hasCRTC2 = 1;
+                       break;
+               case PCI_DEVICE_ID_RADEON_LF:
+                       strcpy(rinfo->name, "Radeon R250 LF ");
+                       rinfo->hasCRTC2 = 1;
+                       break;
                 default:
                         return -ENODEV;
         }
--- linux-2.4.20/drivers/char/drm/drm_agpsupport.h      2003-03-07 
13:47:00.000000000 +0100
+++ linux-2.4.20mw0/drivers/char/drm/drm_agpsupport.h   2003-03-07 
10:51:49.000000000 +0100
@@ -259,65 +259,13 @@
                         return NULL;
                 }
                 head->memory = NULL;
-               switch (head->agp_info.chipset) {
-               case INTEL_GENERIC:     head->chipset = "Intel";         break;
-               case INTEL_LX:          head->chipset = "Intel 440LX";   break;
-               case INTEL_BX:          head->chipset = "Intel 440BX";   break;
-               case INTEL_GX:          head->chipset = "Intel 440GX";   break;
-               case INTEL_I810:        head->chipset = "Intel i810";    break;
-               case INTEL_I815:        head->chipset = "Intel i815";    break;
-               case INTEL_I820:        head->chipset = "Intel i820";    break;
-               case INTEL_I840:        head->chipset = "Intel i840";    break;
-               case INTEL_I845:        head->chipset = "Intel i845";    break;
-               case INTEL_I850:        head->chipset = "Intel i850";    break;
-
-               case VIA_GENERIC:       head->chipset = "VIA";           break;
-               case VIA_VP3:           head->chipset = "VIA VP3";       break;
-               case VIA_MVP3:          head->chipset = "VIA MVP3";      break;
-               case VIA_MVP4:          head->chipset = "VIA MVP4";      break;
-               case VIA_APOLLO_KX133:  head->chipset = "VIA Apollo KX133";
-                       break;
-               case VIA_APOLLO_KT133:  head->chipset = "VIA Apollo KT133";
-                       break;
-               case VIA_APOLLO_KT400:  head->chipset = "VIA Apollo KT400";
-                       break;
-               case VIA_APOLLO_PRO:    head->chipset = "VIA Apollo Pro";
-                       break;
-
-               case SIS_GENERIC:       head->chipset = "SiS";           break;
-               case AMD_GENERIC:       head->chipset = "AMD";           break;
-               case AMD_IRONGATE:      head->chipset = "AMD Irongate";  break;
-               case AMD_8151:          head->chipset = "AMD 8151";      break;
-               case ALI_GENERIC:       head->chipset = "ALi";           break;
-               case ALI_M1541:         head->chipset = "ALi M1541";     break;
-
-               case ALI_M1621:         head->chipset = "ALi M1621";     break;
-               case ALI_M1631:         head->chipset = "ALi M1631";     break;
-               case ALI_M1632:         head->chipset = "ALi M1632";     break;
-               case ALI_M1641:         head->chipset = "ALi M1641";     break;
-               case ALI_M1644:         head->chipset = "ALi M1644";     break;
-               case ALI_M1647:         head->chipset = "ALi M1647";     break;
-               case ALI_M1651:         head->chipset = "ALi M1651";     break;
-
-               case SVWRKS_HE:         head->chipset = "Serverworks HE";
-                       break;
-               case SVWRKS_LE:         head->chipset = "Serverworks LE";
-                       break;
-               case SVWRKS_GENERIC:    head->chipset = "Serverworks Generic";
-                       break;
-
-               case HP_ZX1:            head->chipset = "HP ZX1";        break;
-
-               default:                head->chipset = "Unknown";       break;
-               }

                 head->cant_use_aperture = head->agp_info.cant_use_aperture;
                 head->page_mask = head->agp_info.page_mask;

-               DRM_INFO("AGP %d.%d on %s @ 0x%08lx %ZuMB\n",
+               DRM_INFO("AGP %d.%d Aperture @ 0x%08lx %ZuMB\n",
                          head->agp_info.version.major,
                          head->agp_info.version.minor,
-                        head->chipset,
                          head->agp_info.aper_base,
                          head->agp_info.aper_size);
         }

