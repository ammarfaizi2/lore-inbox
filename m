Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVGFTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVGFTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVGFTp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:28 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:43156 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262324AbVGFOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:35:50 -0400
Message-ID: <42CBEC38.3030100@ens-lyon.fr>
Date: Wed, 06 Jul 2005 16:35:36 +0200
From: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compilation error sound/pci/bt87x.c:807 [Re: Linux 2.6.13-rc2]
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <20050706091034.GA9095@irc.pl>
In-Reply-To: <20050706091034.GA9095@irc.pl>
Content-Type: multipart/mixed;
 boundary="------------080907070809030705030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907070809030705030407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tomasz Torcz wrote:

>   CC [M]  sound/pci/bt87x.o
>sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
>sound/pci/bt87x.c:807: error: `driver' undeclared (first use in this function)
>sound/pci/bt87x.c:807: error: (Each undeclared identifier is reported only once
>sound/pci/bt87x.c:807: error: for each function it appears in.)
>make[2]: *** [sound/pci/bt87x.o] Error 1
>make[1]: *** [sound/pci] Error 2
>make: *** [sound] Error 2
>  
>
Hi,

The attached patch should fix it.

Regards,
Alexandre

Signed-off-by: Alexandre Buisse <Alexandre.Buisse@ens-lyon.fr>

--------------080907070809030705030407
Content-Type: text/x-patch;
 name="bt87x-driver-2.6.13-rc2.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bt87x-driver-2.6.13-rc2.5.patch"

--- linux-2.6.13-rc2/sound/pci/bt87x.c.old	2005-07-06 16:29:08.000000000 +0200
+++ linux-2.6.13-rc2/sound/pci/bt87x.c	2005-07-06 16:25:05.000000000 +0200
@@ -47,6 +47,8 @@
 static int digital_rate[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = 0 }; /* digital input rate */
 static int load_all;	/* allow to load the non-whitelisted cards */
 
+static struct pci_driver driver;
+
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for Bt87x soundcard");
 module_param_array(id, charp, NULL, 0444);
@@ -804,7 +806,7 @@
 	int i;
 	const struct pci_device_id *supported;
 
-	supported = pci_match_device(driver, pci);
+	supported = pci_match_device(&driver, pci);
 	if (supported)
 		return supported->driver_data;
 

--------------080907070809030705030407--
