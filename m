Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292311AbSBUKSk>; Thu, 21 Feb 2002 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBUKSb>; Thu, 21 Feb 2002 05:18:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292311AbSBUKS0>;
	Thu, 21 Feb 2002 05:18:26 -0500
Message-ID: <3C74C970.5AAE6A68@mandrakesoft.com>
Date: Thu, 21 Feb 2002 05:18:24 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephane Casset <sept@logidee.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via-rhine for 2.5.5
In-Reply-To: <20020221095905.GA19625@logidee.com>
Content-Type: multipart/mixed;
 boundary="------------E80DA4CDE54449F41456116B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E80DA4CDE54449F41456116B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephane Casset wrote:
> --- drivers/net/via-rhine.c.orig        Thu Feb 21 10:49:54 2002
> +++ drivers/net/via-rhine.c     Thu Feb 21 10:55:39 2002
> @@ -1754,7 +1754,7 @@
> -       remove:         via_rhine_remove_one,
> +       remove:         __devexit_p(via_rhine_remove_one),

this is ok

> -static void __exit via_rhine_cleanup (void)
> +static void __devexit via_rhine_cleanup (void)

this is definitely wrong

I'm also surprised you managed to compile via-rhine without the attached
patch, which is needed to fix the build.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
--------------E80DA4CDE54449F41456116B
Content-Type: text/plain; charset=us-ascii;
 name="via-rhine-2.5.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-rhine-2.5.5.patch"

diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	Thu Feb 21 05:17:43 2002
+++ b/drivers/net/via-rhine.c	Thu Feb 21 05:17:43 2002
@@ -321,6 +321,7 @@
 	VT86C100A = 0,
 	VT6102,
 	VT3043,
+	VT6105,
 };
 
 struct via_rhine_chip_info {
@@ -349,7 +350,7 @@
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
-	  CanHaveMII | ReqTxAlign }
+	  CanHaveMII | ReqTxAlign },
 	{ "VIA VT6105 Rhine-III", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 };

--------------E80DA4CDE54449F41456116B--

