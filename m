Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVBGMbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVBGMbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVBGMbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:31:11 -0500
Received: from [195.23.16.24] ([195.23.16.24]:57729 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261404AbVBGMbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:31:07 -0500
Message-ID: <42075F71.2050504@grupopie.com>
Date: Mon, 07 Feb 2005 12:30:41 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: jjluza@yahoo.fr, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 - broken bttv ?
References: <200502051922.25001.jjluza@yahoo.fr> <42056065.2000504@eyal.emu.id.au> <200502060255.01758.jjluza@yahoo.fr> <42075E0A.2010802@grupopie.com>
In-Reply-To: <42075E0A.2010802@grupopie.com>
Content-Type: multipart/mixed;
 boundary="------------090506060906010004050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090506060906010004050106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paulo Marques wrote:
> jjluza wrote:
> 
>> Eyal Lebedinsky wrote
>>
>>> I am having bttv problems with vanilla -rc3. Does it work for you?
>>
>>
>>
>> I don't know, as I said I didn't test kernel between 2.6.10 and 
>> 2.6.11-rc3-mm1.
>> Sorry.
>> If I have time enough later, I can test 2.6.11-rc3.
>> Since I don't really know if it's the good place to talk about that, I 
>> decided to report this bug on bugzilla too. Maybe you can post your 
>> problem here :
>> http://bugzilla.kernel.org/show_bug.cgi?id=4171
> 
> 
> Other people with similar problems reported that the attached patch from 
>  Gerd Knorr fixed the problem for them.

-ENOATTACHMENT  :P

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------090506060906010004050106
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

--------------090506060906010004050106--
