Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290926AbSASIo3>; Sat, 19 Jan 2002 03:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290927AbSASIoX>; Sat, 19 Jan 2002 03:44:23 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:43281 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S290926AbSASIoM>;
	Sat, 19 Jan 2002 03:44:12 -0500
Message-ID: <3C4931DA.5020703@epfl.ch>
Date: Sat, 19 Jan 2002 09:44:10 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Didier Moens <moensd@xs4all.be>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
In-Reply-To: <3C487E68.1000404@xs4all.be>
Content-Type: multipart/mixed;
 boundary="------------000700030408040405060400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000700030408040405060400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Didier Moens wrote:

> Dear all,
> 
> On november 27th, Nicolas Aspert was so kind as to post a modification 
> to agpgart, which catters for detection of the Intel i830MP.
> 
> The patch was included in 2.4.18-pre2.
> 
> Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
> invoked, both in terminal and in X. APM functions perfectly when agpgart 
> is absent.
> 
> 
> 

Hello all

Here is a patch that fixes the APM/suspend/resume issues in agpgart (for 
820 and 830MP chipsets).
The patch is against 2.4.18-pre4

Have a nice week-end.


Nicolas

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)



--------------000700030408040405060400
Content-Type: text/plain;
 name="patch-agp_suspend_resume-2.4.18-pre4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-agp_suspend_resume-2.4.18-pre4"

diff -Nru linux-2.4.18-pre4.clean/drivers/char/agp/agpgart_be.c linux-2.4.18-pre4.dirty/drivers/char/agp/agpgart_be.c
--- linux-2.4.18-pre4.clean/drivers/char/agp/agpgart_be.c	Sat Jan 19 09:35:00 2002
+++ linux-2.4.18-pre4.dirty/drivers/char/agp/agpgart_be.c	Sat Jan 19 09:38:41 2002
@@ -1857,7 +1857,10 @@
        agp_bridge.free_by_type = agp_generic_free_by_type;
        agp_bridge.agp_alloc_page = agp_generic_alloc_page;
        agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-
+       agp_bridge.suspend = agp_generic_suspend;
+       agp_bridge.resume = agp_generic_resume;
+       agp_bridge.cant_use_aperture = 0;
+       
        return 0;
 
        (void) pdev; /* unused */
@@ -1887,7 +1890,10 @@
        agp_bridge.free_by_type = agp_generic_free_by_type;
        agp_bridge.agp_alloc_page = agp_generic_alloc_page;
        agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-
+       agp_bridge.suspend = agp_generic_suspend;
+       agp_bridge.resume = agp_generic_resume;
+       agp_bridge.cant_use_aperture = 0;
+       
        return 0;
 
        (void) pdev; /* unused */

--------------000700030408040405060400--

