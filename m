Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUK0T1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUK0T1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUK0T1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:27:38 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:23779 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261312AbUK0TZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:25:16 -0500
Message-ID: <41A8D498.2050309@free.fr>
Date: Sat, 27 Nov 2004 20:25:12 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Li Shaohua <shaohua.li@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>  <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>  <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>  <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>  <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>  <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>  <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com> <Pine.SOC.4.61.0411221016270.16427@math.ut.ee> <41A753A0.1070305@free.fr> <Pine.SOC.4.61.0411262018170.26264@math.ut.ee> <41A7CF6A.8010603@free.fr> <Pine.SOC.4.61.0411271411190.1904@math.ut.ee> <41A88904.3070305@free.fr> <Pine.SOC.4.61.0411272023240.21272@math.ut.ee> <41A8CE4E.8090605@free.fr>
In-Reply-To: <41A8CE4E.8090605@free.fr>
Content-Type: multipart/mixed;
 boundary="------------010403050409000003070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403050409000003070001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

matthieu castet wrote:
> Meelis Roos wrote:
> 
>>> Just for confirmation, could you try this patch. It should enable 
>>> pnp_dbg message and print your _CRS when you activate the device.
>>> If there is nothing between ******574******* and ******857*******, 
>>> you bios is likely broken.
>>
>>
>>
>> activate:
>> ******574*******
>> pnp: Res cnt 4
>> pnp: res cnt 4
>> pnp: Encode io
>> pnp: Encode irq
>> pnp: Encode io
>> pnp: Encode dma
>> ******857*******
>> pnp: Device 00:0a activated.
>>
>> So it appears that there is something between 574 and 857.
>>
> Are you sure you have enable ACPI DEBUG ?
> You should have CONFIG_ACPI_DEBUG=y in your .config
> 
> 
With this patch, it should be work better (no need to remove the 
previous patch)


Matthieu


PS : I should find a better way to make patch....

--------------010403050409000003070001
Content-Type: text/x-patch;
 name="rsmk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsmk.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/Makefile.old	2004-11-27 20:21:51.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/Makefile	2004-11-26 14:59:51.000000000 +0100
@@ -1,5 +1,10 @@
 #
 # Makefile for the kernel PNPACPI driver.
 #
+ifdef CONFIG_ACPI_DEBUG
+  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
+endif
+
+EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 
 obj-y := core.o rsparser.o

--------------010403050409000003070001--
