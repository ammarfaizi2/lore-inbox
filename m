Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUHCO3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUHCO3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUHCO3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:29:49 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:26276 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265770AbUHCO3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:29:45 -0400
Message-ID: <410FA145.70701@kolivas.org>
Date: Wed, 04 Aug 2004 00:29:25 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: "Barry K. Nathan" <barryn@pobox.com>,
       Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
References: <200408021602.34320.swsnyder@insightbb.com> <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net> <20040803133034.GM23504@suse.de>
In-Reply-To: <20040803133034.GM23504@suse.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C3218B30EDAFC6D845D7446"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C3218B30EDAFC6D845D7446
Content-Type: multipart/mixed;
 boundary="------------020305070303010309050708"

This is a multi-part message in MIME format.
--------------020305070303010309050708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> On Mon, Aug 02 2004, Barry K. Nathan wrote:
> 
>>On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
>>
>>>There seems to be a controversy about the use of the CONFIG_HIGHMEM4G  
>>>kernel configuration.  After reading many posts on the subject, I still 
>>>don't know which setting is best for me.

No idea what the performance hit is of highmem these days - it seems 
insignificant compared to 2.4 so I've had it enabled for 1Gb ram.

> There's also the option of moving the mapping only slightly, so that all
> of the 1G fits in low memory. That's the best option for 1G desktop
> machines, imho. Changing PAGE_OFFSET from 0xc0000000 to 0xb0000000 would
> probably be enough.
> 
> Then you can have your cake and eat it too.

Something like this attached patch? Seems to work nicely. Thanks!

Cheers,
Con

--------------020305070303010309050708
Content-Type: text/x-patch;
 name="1g_lowmem_i386.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1g_lowmem_i386.diff"

Index: linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.8-rc2-mm2.orig/arch/i386/kernel/vmlinux.lds.S	2004-05-23 12:54:46.000000000 +1000
+++ linux-2.6.8-rc2-mm2/arch/i386/kernel/vmlinux.lds.S	2004-08-04 00:20:02.219462913 +1000
@@ -11,7 +11,7 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = 0xB0000000 + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
Index: linux-2.6.8-rc2-mm2/include/asm-i386/page.h
===================================================================
--- linux-2.6.8-rc2-mm2.orig/include/asm-i386/page.h	2004-08-03 01:29:28.000000000 +1000
+++ linux-2.6.8-rc2-mm2/include/asm-i386/page.h	2004-08-03 23:58:16.000000000 +1000
@@ -123,9 +123,9 @@
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#define __PAGE_OFFSET		(0xB0000000)
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#define __PAGE_OFFSET		(0xB0000000UL)
 #endif
 
 

--------------020305070303010309050708--

--------------enig0C3218B30EDAFC6D845D7446
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBD6FIZUg7+tp6mRURApo/AKCL2K7ptUekk1tfyNjYVaEs7pu13QCeN+lx
LYk6t8Kcx+Eokjo9Vl7bM5A=
=P/n8
-----END PGP SIGNATURE-----

--------------enig0C3218B30EDAFC6D845D7446--
