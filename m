Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVDADwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVDADwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDADwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:52:39 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:1192 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262594AbVDADwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:52:34 -0500
Message-ID: <424CC566.3080007@jg555.com>
Date: Thu, 31 Mar 2005 19:52:06 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org>
In-Reply-To: <20050331161206.GB19219@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant
    Thanx for your feedback. I got it working, but I don't think the 
patch is the best. Here is the patch, and the information, but if you 
can recommend a different way to fix it, let me know. The patch was done 
by Peter Horton.
Here is the link to the full patch, 
http://ftp.jg555.com/patches/raq2/linux/linux-2.6.11.6-raq2_fix-2.patch
but here is the section for this issue
@@ -1628,6 +1631,16 @@
                 }
         }
 
+#if defined(CONFIG_MIPS_COBALT) && defined(CONFIG_MIPS64)
+        /*
+         * something very bad is happening. without this
+         * cache flush the PHY can't be read. I've tried
+         * various ins & outs, delays etc but only a call
+         * to printk or this flush seems to fix it ... help!
+         */
+        flush_cache_all();
+#endif
+
         /* Find the connected MII xcvrs.
            Doing this in open() would allow detecting external xcvrs
            later, but takes much time. */

>Are there any config option differences? 
>e.g. MWI or MMIO options enabled on 64-bit but not 32-bit?
>  
>
I verified that there are no differences.

>ISTR to remember submitting a patch so additional data
>gets printed in tulip_stop_rxtx. Here is a reference to the patch
>but I don't think it is relevant to the this problem:
>	http://lkml.org/lkml/2004/12/15/119
>
>  
>
Applied the patch, here is the output

0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)
0000:00:07.0: tulip_stop_rxtx() failed (CSR5 0xf0660000 CSR6 0xb3862002)

I was able to get some more information on the bootup sequence with the 
updates.
Here is the output now from the driver

Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using 
substitute media control info.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0: ***WARNING***: No MII transceiver found!
eth0: Digital DS21143 Tulip rev 65 at ffffffffb0001400, 
00:10:E0:00:32:DE, IRQ 19.
PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
tulip1: Old format EEPROM on 'Cobalt Microserver' board.  Using 
substitute media control info.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip1: ***WARNING***: No MII transceiver found!
eth1: Digital DS21143 Tulip rev 65 at ffffffffb0001480, 
00:10:E0:00:32:DF, IRQ 20.


-- 
----
Jim Gifford
maillist@jg555.com

