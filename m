Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130417AbRAWQvl>; Tue, 23 Jan 2001 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRAWQvb>; Tue, 23 Jan 2001 11:51:31 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:26154 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S130417AbRAWQvW>;
	Tue, 23 Jan 2001 11:51:22 -0500
Message-ID: <3A6DB677.2060109@valinux.com>
Date: Tue, 23 Jan 2001 09:51:03 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Guntsche <m.guntsche@epitel.at>
CC: linux-kernel@vger.kernel.org,
        "Dri-devel@lists.sourceforge.net" <Dri-devel@lists.sourceforge.net>
Subject: Re: AGPGART problems with VIA KX133 chipsets under 2.2.18/2.4.0
In-Reply-To: <NDBBJOKGIPCDBEEFHNFPGECPCAAA.m.guntsche@epitel.at>
Content-Type: multipart/mixed;
 boundary="------------090201080102040102050005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201080102040102050005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Michael Guntsche wrote:

> Hello all,
> 
> While playing around with the agpgart module I noticed the following strange
> behaviour.
> 
> The hardware in question is an Asus K7V with the KX133 chipset and has been
> tested on both 2.4.0 and 2.2.18 kernels.
> 
> The output below is just from insmod,rmmod,insmod agpgart without starting
> X.
> 
> insmod agpgart for the first time:
> Jan 22 23:17:10 deepblue kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann
> Jan 22 23:17:10 deepblue kernel: agpgart: Maximum main memory to use for agp
> memory: 204M
> Jan 22 23:17:10 deepblue kernel: agpgart: Detected Via Apollo Pro chipset
> Jan 22 23:17:10 deepblue kernel: agpgart: AGP aperture is 64M @ 0xe4000000
>                                                                   ^-------
> 
> rmmod, insmod agpgart:
> Jan 22 23:17:16 deepblue kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann
> Jan 22 23:17:16 deepblue kernel: agpgart: Maximum main memory to use for agp
> memory: 204M
> Jan 22 23:17:16 deepblue kernel: agpgart: Detected Via Apollo Pro chipset
> Jan 22 23:17:16 deepblue kernel: agpgart: AGP aperture is 64M @ 0x4000000
>                                                                   ^------
> Apparently AGP isnt working afterwards.
> Someone know what might be causing this?
> 
> 
> If you need more information or a want me to help debug this issue further
> dont hestitate to tell me.
> 
> Since Im not subscribed to the list, please CC any replies to me directly.
> 
> 
> 
> 
> Cheers,
> Mike
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Can you try this patch and tell me if it fixes the problem (against 2.4.0)?

Apply the patch when in the directory drivers/char/agp.

-Jeff

--------------090201080102040102050005
Content-Type: text/plain;
 name="via_try_this.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via_try_this.diff"

--- agpgart_be.c~	Fri Dec 29 15:07:21 2000
+++ agpgart_be.c	Tue Jan 23 09:45:49 2001
@@ -1384,7 +1384,9 @@
 	aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
+#if 0
 	pci_write_config_dword(agp_bridge.dev, VIA_ATTBASE, 0);
+#endif
 	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE,
 			      previous_size->size_value);
 }

--------------090201080102040102050005--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
