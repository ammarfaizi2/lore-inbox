Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTK3J4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTK3J4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:56:08 -0500
Received: from pop.gmx.net ([213.165.64.20]:2447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263448AbTK3J4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:56:05 -0500
X-Authenticated: #125400
Message-ID: <3FC9BF12.70209@gmx.de>
Date: Sun, 30 Nov 2003 10:57:38 +0100
From: Andreas Fester <Andreas.Fester@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] Onboard sound support for EPoX mainboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav, Hi list,

I am using linux on an EPoX EP-8K9A mainboard with onboard sound,
using the via82xx driver. Starting with 2.6.0-test6 the driver
only produces loud noise...
The problem seems to be the checking of the DXS capabilities.
The driver recognises the chip as an VIA8233 (not "A"), but
the EPoX vendor id is missing in the dxs white list.
After adding the appropriate vendor id, sound works again as
it did with 2.6.0-test5 :-)
Find below the patch against -test11 which adds the vendor id
and the device id to the dxs list.

Best Regards,

     Andreas

------------------------------------------------------------------------------------------------------
diff -u linux-2.6.0-test11/sound/pci/via82xx.c linux-2.6.0-test11-af1/sound/pci/via82xx.c
--- linux-2.6.0-test11/sound/pci/via82xx.c      2003-11-29 19:18:22.000000000 +0100
+++ linux-2.6.0-test11-af1/sound/pci/via82xx.c  2003-11-29 19:38:41.000000000 +0100
@@ -1969,6 +1969,7 @@
         static struct dxs_whitelist whitelist[] = {
                 { .vendor = 0x1019, .device = 0x0996, .action = VIA_DXS_48K },
                 { .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
+                { .vendor = 0x1695, .device = 0x3005, .action = VIA_DXS_ENABLE }, /* EPoX EP-8K9A  */
                 { } /* terminator */
         };
         struct dxs_whitelist *w;
------------------------------------------------------------------------------------------------------

