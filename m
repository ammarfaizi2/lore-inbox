Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVBDKou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVBDKou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbVBDKou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:44:50 -0500
Received: from email.essi.fr ([157.169.25.6]:13221 "EHLO email.essi.fr")
	by vger.kernel.org with ESMTP id S263460AbVBDKof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:44:35 -0500
Message-ID: <42035211.9030603@yahoo.fr>
Date: Fri, 04 Feb 2005 11:44:33 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Mickael Marchand <marchand@kde.org>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org> <1107407987.2097.18.camel@lb.loomes.de> <87is5a0wxm.fsf@bytesex.org> <1107428571.2068.4.camel@lb.loomes.de> <20050203113022.GK10602@bytesex> <4202798B.7000802@kde.org>
In-Reply-To: <4202798B.7000802@kde.org>
Content-Type: multipart/mixed;
 boundary="------------010401080500070005060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401080500070005060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mickael Marchand wrote:

> Hello,
>
> I am having the same kind of troubles (can't tune and mt_set_frequency 
> -121 errors) since 2.6.10 (it was working in 2.6.9) on amd64.
> this patch did not help sadely.

I have the same problem, but on x86, the attached patch fixed it for me.

-- 
Guillaume



--------------010401080500070005060501
Content-Type: text/x-patch;
 name="tda9887.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tda9887.diff"

--- linux-2.6.11-rc3/drivers/media/video/tda9887.c
+++ linux-2.6.11-rc3/drivers/media/video/tda9887.c
@@ -545,19 +553,21 @@
 	int rc;
 
 	memset(buf,0,sizeof(buf));
+	tda9887_set_tvnorm(t,buf);
 	buf[1] |= cOutputPort1Inactive;
 	buf[1] |= cOutputPort2Inactive;
-	tda9887_set_tvnorm(t,buf);
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
+#if 0
 	if (t->std & V4L2_STD_SECAM_L) {
 		/* secam fixup (FIXME: move this to tvnorms array?) */
 		buf[1] &= ~cOutputPort2Inactive;
 	}
+#endif
 
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
 		buf[1],buf[2],buf[3]);

--------------010401080500070005060501--
