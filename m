Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269601AbTGJVB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbTGJVB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:01:26 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:40518 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269601AbTGJVBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:01:14 -0400
Message-ID: <3F0DD66B.6080209@rackable.com>
Date: Thu, 10 Jul 2003 14:11:07 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patch
 attached to fix
References: <Pine.SOL.4.30.0307102202340.22284-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307102202340.22284-100000@mion.elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------020009030408070401040609"
X-OriginalArrivalTime: 10 Jul 2003 21:15:54.0725 (UTC) FILETIME=[72D3C150:01C34728]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009030408070401040609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

>Hi,
>
>Do you have "Special FastTrak Feature" enabled?
>  
>

Can we change the option to something that makes sense.  I get the 
feeling no one understands what it does at 1st glance.  This is the 2nd 
time I've seen a patch like this. 

>--
>Bartlomiej
>
>On Thu, 10 Jul 2003, Steven Dake wrote:
>
>  
>
>>Folks,
>>
>>After I upgraded to 2.4.21, I noticed my Gigabyte motherboard with
>>onboard IDE Promise 20276 FastTrack RAID no longer works.  The following
>>patch fixes the problem, which appears to be an incomplete list of
>>devices in the ide setup code.  There are probably other fasttrack RAID
>>adaptors that should be added to the setup code, but I don't know what
>>they are.
>>
>>Thanks
>>-steve
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


--------------020009030408070401040609
Content-Type: text/plain;
 name="ftdoc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ftdoc.diff"

diff -ur linux-2.4.22-pre3-ac1-old/Documentation/Configure.help linux-2.4.22-pre3-ac1/Documentation/Configure.help
--- linux-2.4.22-pre3-ac1-old/Documentation/Configure.help	2003-07-07 04:23:56.000000000 -0700
+++ linux-2.4.22-pre3-ac1/Documentation/Configure.help	2003-07-10 05:53:27.000000000 -0700
@@ -1297,9 +1297,12 @@
 
   If unsure, say N.
 
-Special FastTrak Feature
+Ignore FastTrak Bios and configure drives as IDE disks
 CONFIG_PDC202XX_FORCE
-  For FastTrak enable overriding BIOS.
+  Enable overriding BIOS RAID configuration.  Without this option the 
+  kernel may refuse to see your drives.  Do not enable if you are 
+  using Promise's binary module.  This option is compatible with the 
+  GPL ataraid driver.
 
 SiS5513 chipset support
 CONFIG_BLK_DEV_SIS5513
diff -ur linux-2.4.22-pre3-ac1-old/drivers/ide/Config.in linux-2.4.22-pre3-ac1/drivers/ide/Config.in
--- linux-2.4.22-pre3-ac1-old/drivers/ide/Config.in	2003-07-07 04:18:53.000000000 -0700
+++ linux-2.4.22-pre3-ac1/drivers/ide/Config.in	2003-07-10 05:51:22.000000000 -0700
@@ -66,7 +66,7 @@
 	    dep_mbool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then
-	        bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+	        bool     '    Ignore FastTrak Bios and configure drives as IDE disks' CONFIG_PDC202XX_FORCE
 	    fi
 	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
 	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI

--------------020009030408070401040609--

