Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDEMeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDEMeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDEMeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:34:09 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:11268 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261714AbVDEMdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:33:08 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: sud@latinsud.com (SuD Alex)
Subject: [OSS] Add CXT48 to modem black list in ac97
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Organization: Core
In-Reply-To: <42507F12.6070009@latinsud.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DInEA-0006md-00@gondolin.me.apana.org.au>
Date: Tue, 05 Apr 2005 22:32:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SuD Alex <sud@latinsud.com> wrote:
>
> Googling i found that  jgarzik already got a patch for this 
> (ac97_codec.c:158):
> +    {0x43585430, "CXT48",            &default_ops,        
> AC97_DELUDED_MODEM },

Yes, until we manage to copy what ALSA does in this case, this
is what we'll have to do.

The following patch works around the misdetection of the CXT48
codec as a modem by the OSS ac97 driver.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au> 

We should fix the crash itself too.  Andrew, I'll send you some
a couple of patches on that later.

BTW Alex, if you have the time please determine whether ALSA
works properly on your machine.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== sound/oss/ac97_codec.c 1.24 vs edited =====
--- 1.24/sound/oss/ac97_codec.c	2005-03-08 15:41:36 +11:00
+++ edited/sound/oss/ac97_codec.c	2005-04-05 22:27:11 +10:00
@@ -155,6 +155,7 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x43585430, "CXT48",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x43585442, "CXT66",			&default_ops,		AC97_DELUDED_MODEM },
 	{0x44543031, "Diamond Technology DT0893", &default_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
