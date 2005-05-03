Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVECRnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVECRnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVECRnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:43:31 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:43946 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261470AbVECRnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:43:23 -0400
Message-ID: <4277B833.9020109@brturbo.com.br>
Date: Tue, 03 May 2005 14:43:15 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] PAL-M support fix for CX88 chipsets
References: <42777318.2070508@brturbo.com.br> <20050503083822.68a116d4.rddunlap@osdl.org>
In-Reply-To: <20050503083822.68a116d4.rddunlap@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010706050007050304060305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010706050007050304060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:

>On Tue, 03 May 2005 09:48:24 -0300 Mauro Carvalho Chehab wrote:
>
>|     This patch fixes PAL-M chroma subcarrier frequency (FSC) to its 
>| correct value of 3.5756115 MHz and adjusts horizontal total samples for 
>| PAL-M, according with formula Line Draw Time / (4*FSC), where Line Draw 
>| Time is 63.555 us.
>|      Without this patch, the Notch subcarrier filter was trying to 
>| capture using NTSC-M frequency, which is very close, but not equal. This 
>| could result in Black and White or miscolored frames.
>
>This patch does not apply cleanly:
>patching file cx88-core.c
>Hunk #1 FAILED at 736.
>Hunk #2 FAILED at 752.
>2 out of 2 hunks FAILED -- saving rejects to file cx88-core.c.rej
>
>due to tabs being converted to spaces.
>Please mail it to yourself and then try to apply the patch
>to see if that works.  You may have to use a different
>mail client/app.  Hm, thunderbird.  Did you copy/paste the
>patch?  That usually doesn't work.
>
>  
>
    That was my case. I normally prefer not to insert as a MIME 
attachment. As it was a small patch, I'd used copy/paste method...

>Oh, and kernel comment style is /* ... */, not //.
>  
>
    I've corrected the comments and fixed some typo.

    Thank you.

    Mauro.

--------------010706050007050304060305
Content-Type: text/plain;
 name="pal.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pal.dif"

--- linux-2.6.12-rc3.org/drivers/media/video/cx88/cx88-core.c	2005-04-20 21:03:14.000000000 -0300
+++ linux-2.6.12-rc3/drivers/media/video/cx88/cx88-core.c	2005-05-03 14:31:49.000000000 -0300
@@ -736,6 +736,9 @@ static unsigned int inline norm_fsc8(str
 {
 	static const unsigned int ntsc = 28636360;
 	static const unsigned int pal  = 35468950;
+        static const unsigned int palm  = 28604892;
+
+	if (V4L2_STD_PAL_M  & norm->id) return palm;
 
 	return (norm->id & V4L2_STD_625_50) ? pal : ntsc;
 }
@@ -749,6 +752,8 @@ static unsigned int inline norm_notchfil
 
 static unsigned int inline norm_htotal(struct cx88_tvnorm *norm)
 {
+	/* Should always be Line Draw Time / (4*FSC) */
+	if (V4L2_STD_PAL_M  & norm->id) return 909;
 	return (norm->id & V4L2_STD_625_50) ? 1135 : 910;
 }
 

--------------010706050007050304060305--
