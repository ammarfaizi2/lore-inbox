Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVEPMbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEPMbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVEPMbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:31:15 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:11940 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261285AbVEPMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:31:11 -0400
Message-ID: <42889283.9030104@ens-lyon.org>
Date: Mon, 16 May 2005 14:30:59 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2
References: <20050516021302.13bd285a.akpm@osdl.org>
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040308090803010200010601"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308090803010200010601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> 
> 
> - davem has set up a mm-commits mailing list so people can review things
>   which are added to or removed from the -mm tree.  Do
> 
> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> 
> - x86_64 architecture update from Andi.
> 
> - Everything up to and including `spurious-interrupt-fix.patch' is planned
>   for 2.6.12 merging.  Plus a few other things in there.
> 
> - Another DVB subsystem update

Hi Andrew,

CONFIG_PPP_MPPE can be enabled without CONFIG_CRYPTO.
This results in this warning when running make modules_install:
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.12-rc4-mm2=LoulousMobile; fi
WARNING:
/lib/modules/2.6.12-rc4-mm2=LoulousMobile/kernel/drivers/net/ppp_mppe.ko
needs unknown symbol crypto_alloc_tfm
WARNING:
/lib/modules/2.6.12-rc4-mm2=LoulousMobile/kernel/drivers/net/ppp_mppe.ko
needs unknown symbol crypto_free_tfm

By the way, looking at drivers/net/ppp_mppe.c, it looks like sha1 and
arc4 are needed at runtime.

The attached patch selects all these when PPP_MPPE is selected.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Brice

--------------040308090803010200010601
Content-Type: text/x-patch;
 name="fix_ppp-mppe_dependencies.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_ppp-mppe_dependencies.patch"

--- linux-mm/drivers/net/Kconfig.old	2005-05-16 14:15:29.000000000 +0200
+++ linux-mm/drivers/net/Kconfig	2005-05-16 14:24:44.000000000 +0200
@@ -2431,6 +2431,9 @@ config PPP_BSDCOMP
 config PPP_MPPE
        tristate "PPP MPPE compression (encryption) (EXPERIMENTAL)"
        depends on PPP && EXPERIMENTAL
+       select CRYPTO
+       select CRYPTO_SHA1
+       select CRYPTO_ARC4
        ---help---
          Support for the MPPE Encryption protocol, as employed by the
 	 Microsoft Point-to-Point Tunneling Protocol.

--------------040308090803010200010601--
