Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbSLKMAD>; Wed, 11 Dec 2002 07:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbSLKMAD>; Wed, 11 Dec 2002 07:00:03 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:25611 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S267122AbSLKMAA>;
	Wed, 11 Dec 2002 07:00:00 -0500
Message-ID: <3DF72A91.5080804@epfl.ch>
Date: Wed, 11 Dec 2002 13:07:45 +0100
From: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: linux-kernel@vger.kernel.org, davej@suse.de, faith@redhat.com,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no>
In-Reply-To: <fa.jjk71mv.1kja10g@ifi.uio.no>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030209060706070901080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030209060706070901080907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Margit Schubert-While wrote:
>  From drivers/char/agp/agpgart_be.c
> 4554,4559
>     { PCI_DEVICE_ID_INTEL_845_G_0,
>                  PCI_VENDOR_ID_INTEL,
>                  INTEL_I845_G,
>                  "Intel",
>                  "i845G",
>                  intel_830mp_setup },
> 
> Surely this is wrong or ?
> Should be "intel_845_setup", I think.
> 

IIRC, the 845G is a "new" version of the 830MP chipset (it had been
added by Abraham vd Merwe & Graeme Fisher some months ago), but acts
basically just as the 830MP. Therefore the entry is correct.... Or maybe
if it gets confusing adding a comment would not hurt...

> 
> Also in drivers/char/drm/drm_agpsupport.h, the switch statement at 262 
> is missing the
> cases for INTEL_I830_M, INTEL_I845_G.


That's true. It is also missing in 2.5.51.
I attach two patches, one for 2.4.21-pre1 and one for 2.5.51 that should 
fix this.


Regards

Nicolas.



--------------030209060706070901080907
Content-Type: text/plain;
 name="intelchipset-id-2.4.21-pre1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intelchipset-id-2.4.21-pre1.diff"

diff -ru linux-2.4.21-pre1.clean/drivers/char/drm/drm_agpsupport.h linux-2.4.21-pre1/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.21-pre1.clean/drivers/char/drm/drm_agpsupport.h	Wed Dec 11 12:36:58 2002
+++ linux-2.4.21-pre1/drivers/char/drm/drm_agpsupport.h	Wed Dec 11 12:42:34 2002
@@ -267,8 +267,10 @@
 		case INTEL_I810:	head->chipset = "Intel i810";    break;
 		case INTEL_I815:	head->chipset = "Intel i815";	 break;
 	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
+		case INTEL_I830_M:	head->chipset = "Intel i830M";	 break;
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 		case INTEL_I845:	head->chipset = "Intel i845";    break;
+		case INTEL_I845_G:	head->chipset = "Intel i845G";	 break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
 
 		case VIA_GENERIC:	head->chipset = "VIA";           break;

--------------030209060706070901080907
Content-Type: text/plain;
 name="intelchipset-id-2.5.51.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intelchipset-id-2.5.51.diff"

diff -ru linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h linux-2.5.51/drivers/char/drm/drm_agpsupport.h
--- linux-2.5.51.clean/drivers/char/drm/drm_agpsupport.h	Tue Dec 10 03:45:39 2002
+++ linux-2.5.51/drivers/char/drm/drm_agpsupport.h	Wed Dec 11 12:55:08 2002
@@ -271,10 +271,12 @@
 #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
 	 	case INTEL_I820:	head->chipset = "Intel i820";	 break;
 #endif
+		case INTEL_I830_M:	head->chipset = "Intel i830M";	 break;
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 #if LINUX_VERSION_CODE >= 0x02040f /* KERNEL_VERSION(2,4,15) */
 		case INTEL_I845:	head->chipset = "Intel i845";    break;
 #endif
+		case INTEL_I845:	head->chipset = "Intel i845G";	 break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
 		case INTEL_460GX:	head->chipset = "Intel 460GX";	 break;
 

--------------030209060706070901080907--

