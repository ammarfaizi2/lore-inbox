Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSF0JEa>; Thu, 27 Jun 2002 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSF0JE3>; Thu, 27 Jun 2002 05:04:29 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:62479 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S316768AbSF0JE1>;
	Thu, 27 Jun 2002 05:04:27 -0400
Message-ID: <3D1AD51D.3050001@epfl.ch>
Date: Thu, 27 Jun 2002 11:04:29 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Knut J Bjuland <knutjbj@online.no>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@suse.de>, marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: bug in Linux 2.4.19RC1 i815e agpgart module, unable to determineaperturesize.
References: <fa.ckqb7hv.j48jpn@ifi.uio.no> <fa.soqp29v.17ncoig@ifi.uio.no> <3D1AB9BD.8050303@epfl.ch> <3D1AD0A0.9D053C4E@online.no>
Content-Type: multipart/mixed;
 boundary="------------070403060407010208080708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070403060407010208080708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Knut J Bjuland wrote:
> Your patch fix my problem with the new i815 code. I run it through a quake3 test and it is as fast as the old
> code,
> Agpgart is now able to determine aperture size, I think you nailed  this problem. Thank you for your patch, hope
> it get in Linux 2.4.19.
> 

Ok that sounds like one bug killed ;-), so I guess this should go in for 
2.4.19-rc2 ...

Marcelo, please apply (patch is against 2.4.19-rc1). I know that Alan 
and Dave have also similar parts in their trees and they are likely to 
suffer the same problem.
Thanks Knut for pointing the problem (although it was present in 
2.4.19-pre10-ac2 already for sure...)

Best regards
Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

--------------070403060407010208080708
Content-Type: text/plain;
 name="i815-fetch-size-2.4.19-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i815-fetch-size-2.4.19-rc1.diff"

diff -Nru linux-2.4.19-rc1.clean/drivers/char/agp/agpgart_be.c linux-2.4.19-rc1/drivers/char/agp/agpgart_be.c
--- linux-2.4.19-rc1.clean/drivers/char/agp/agpgart_be.c	Thu Jun 27 09:07:04 2002
+++ linux-2.4.19-rc1/drivers/char/agp/agpgart_be.c	Thu Jun 27 10:53:47 2002
@@ -1402,6 +1402,12 @@
 	aper_size_info_8 *values;
 
 	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
+
+        /* Intel 815 chipsets have a _weird_ APSIZE register with only
+         * one non-reserved bit, so mask the others out ... */
+        if (agp_bridge.type == INTEL_I815) 
+          temp &= (1 << 3);
+        
 	values = A_SIZE_8(agp_bridge.aperture_sizes);
 
 	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {

--------------070403060407010208080708--

