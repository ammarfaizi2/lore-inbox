Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbSLKNdp>; Wed, 11 Dec 2002 08:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbSLKNdI>; Wed, 11 Dec 2002 08:33:08 -0500
Received: from hicks.adgrafix.com ([64.55.193.2]:7348 "EHLO hicks.adgrafix.com")
	by vger.kernel.org with ESMTP id <S267152AbSLKNcv>;
	Wed, 11 Dec 2002 08:32:51 -0500
Message-ID: <3DF74059.2020905@tungstengraphics.com>
Date: Wed, 11 Dec 2002 13:40:41 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>,
       Margit Schubert-While <margitsw@t-online.de>,
       linux-kernel@vger.kernel.org, faith@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch> <20021211132059.C11689@suse.de> <3DF7337D.1080706@tungstengraphics.com> <20021211140504.D11689@suse.de>
Content-Type: multipart/mixed;
 boundary="------------020406090504060002080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406090504060002080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> On Wed, Dec 11, 2002 at 12:45:49PM +0000, Keith Whitwell wrote:
>  > In any case I don't think the string in the informational is very useful -- 
>  > it's a potentially inaccurate translation of state from *another* module, so 
>  > I'm just removing the lot.
> 
> Cool, that gets my vote too 8-)
> 
>         Dave
> 

Here's the changes I've committed to dri cvs.

Keith

--------------020406090504060002080707
Content-Type: text/plain;
 name="drm-agp-info.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drm-agp-info.diff"

? diff
Index: drmP.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drmP.h,v
retrieving revision 1.54
diff -u -r1.54 drmP.h
--- drmP.h	3 Dec 2002 00:43:47 -0000	1.54
+++ drmP.h	11 Dec 2002 13:29:18 -0000
@@ -488,7 +488,6 @@
 
 typedef struct drm_agp_head {
 	agp_kern_info      agp_info;
-	const char         *chipset;
 	drm_agp_mem_t      *memory;
 	unsigned long      mode;
 	int                enabled;
Index: drm_agpsupport.h
===================================================================
RCS file: /cvsroot/dri/xc/xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/drm_agpsupport.h,v
retrieving revision 1.9
diff -u -r1.9 drm_agpsupport.h
--- drm_agpsupport.h	22 Aug 2002 19:35:31 -0000	1.9
+++ drm_agpsupport.h	11 Dec 2002 13:29:18 -0000
@@ -260,60 +260,6 @@
 			return NULL;
 		}
 		head->memory = NULL;
-		switch (head->agp_info.chipset) {
-		case INTEL_GENERIC:	head->chipset = "Intel";         break;
-		case INTEL_LX:		head->chipset = "Intel 440LX";   break;
-		case INTEL_BX:		head->chipset = "Intel 440BX";   break;
-		case INTEL_GX:		head->chipset = "Intel 440GX";   break;
-		case INTEL_I810:	head->chipset = "Intel i810";    break;
-
-		case INTEL_I815:	head->chipset = "Intel i815";	 break;
-#if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
-	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
-#endif
-		case INTEL_I840:	head->chipset = "Intel i840";    break;
-#if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
-		case INTEL_I845:	head->chipset = "Intel i845";    break;
-#endif
-		case INTEL_I850:	head->chipset = "Intel i850";	 break;
-
-		case VIA_GENERIC:	head->chipset = "VIA";           break;
-		case VIA_VP3:		head->chipset = "VIA VP3";       break;
-		case VIA_MVP3:		head->chipset = "VIA MVP3";      break;
-		case VIA_MVP4:		head->chipset = "VIA MVP4";      break;
-		case VIA_APOLLO_KX133:	head->chipset = "VIA Apollo KX133";
-			break;
-		case VIA_APOLLO_KT133:	head->chipset = "VIA Apollo KT133";
-			break;
-
-		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";
-			break;
-		case SIS_GENERIC:	head->chipset = "SiS";           break;
-		case AMD_GENERIC:	head->chipset = "AMD";           break;
-		case AMD_IRONGATE:	head->chipset = "AMD Irongate";  break;
-		case ALI_GENERIC:	head->chipset = "ALi";           break;
-		case ALI_M1541: 	head->chipset = "ALi M1541";     break;
-
-#if LINUX_VERSION_CODE >= 0x020402
-		case ALI_M1621: 	head->chipset = "ALi M1621";	 break;
-		case ALI_M1631: 	head->chipset = "ALi M1631";	 break;
-		case ALI_M1632: 	head->chipset = "ALi M1632";	 break;
-		case ALI_M1641: 	head->chipset = "ALi M1641";	 break;
-		case ALI_M1647: 	head->chipset = "ALi M1647";	 break;
-		case ALI_M1651: 	head->chipset = "ALi M1651";	 break;
-#endif
-
-#if LINUX_VERSION_CODE >= 0x020406
-		case SVWRKS_HE: 	head->chipset = "Serverworks HE";
-			break;
-		case SVWRKS_LE: 	head->chipset = "Serverworks LE";
-			break;
-		case SVWRKS_GENERIC: 	head->chipset = "Serverworks Generic";
-			break;
-#endif
-
-		default:		head->chipset = "Unknown";       break;
-		}
 #if LINUX_VERSION_CODE <= 0x020408
 		head->cant_use_aperture = 0;
 		head->page_mask = ~(0xfff);
@@ -321,13 +267,12 @@
 		head->cant_use_aperture = head->agp_info.cant_use_aperture;
 		head->page_mask = head->agp_info.page_mask;
 #endif
-
-		DRM_INFO("AGP %d.%d on %s @ 0x%08lx %ZuMB\n",
-			 head->agp_info.version.major,
-			 head->agp_info.version.minor,
-			 head->chipset,
-			 head->agp_info.aper_base,
-			 head->agp_info.aper_size);
+		
+		DRM_DEBUG("AGP %d.%d, aperture @ 0x%08lx %ZuMB\n",
+			  head->agp_info.version.major,
+			  head->agp_info.version.minor,
+			  head->agp_info.aper_base,
+			  head->agp_info.aper_size);
 	}
 	return head;
 }

--------------020406090504060002080707--

