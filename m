Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVJNSGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJNSGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJNSGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:06:19 -0400
Received: from [66.45.247.194] ([66.45.247.194]:14052 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1750809AbVJNSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:06:17 -0400
Message-ID: <434FF06F.2060202@linuxtv.org>
Date: Fri, 14 Oct 2005 21:52:47 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@kromtek.com>,
       Emard <emard@softhome.net>, Marko Kohtala <marko.kohtala@luukku.com>,
       Wilson Michaels <wilsonmichaels@earthlink.net>,
       Andreas Oberritter <obi@linuxtv.org>,
       Kirk Lapray <kirk_lapray@bigfoot.com>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       video4linux-list@redhat.com,
       Takeo Takahashi <takahashi.takeo@renesas.com>,
       Ralph Metzler <rjkm@thp.uni-koeln.de>, Gerd Knorr <kraxel@bytesex.org>,
       Bill Dirks <bdirks@pacbell.net>, Wolfgang Scherr <scherr@net4you.at>,
       Alan Cox <alan@redhat.com>, Ronald Bultje <rbultje@ronald.bitfreak.net>,
       Serguei Miridonov <mirsev@cicese.mx>,
       Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [PATCH 08/14] Big kfree NULL check cleanup - drivers/media
References: <200510132128.12616.jesper.juhl@gmail.com>
In-Reply-To: <200510132128.12616.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>This is the drivers/media/ part of the big kfree cleanup patch.
>
>Remove pointless checks for NULL prior to calling kfree() in drivers/media/.
>
>
>Sorry about the long Cc: list, but I wanted to make sure I included everyone
>who's code I've changed with this patch.
>
>
>Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>---
>
>Please see the initial announcement mail on LKML with subject
>"[PATCH 00/14] Big kfree NULL check cleanup"
>for additional details.
>
>
>  
>

>--- linux-2.6.14-rc4-orig/drivers/media/dvb/bt8xx/dst.c	2005-10-11 22:41:09.000000000 +0200
>+++ linux-2.6.14-rc4/drivers/media/dvb/bt8xx/dst.c	2005-10-13 10:30:01.000000000 +0200
>@@ -1331,9 +1331,7 @@ struct dst_state *dst_attach(struct dst_
> {
> 	/* check if the ASIC is there */
> 	if (dst_probe(state) < 0) {
>-		if (state)
>-			kfree(state);
>-
>+		kfree(state);
> 		return NULL;
> 	}
> 	/* determine settings based on type */
>@@ -1349,9 +1347,7 @@ struct dst_state *dst_attach(struct dst_
> 		break;
> 	default:
> 		dprintk(verbose, DST_ERROR, 1, "unknown DST type. please report to the LinuxTV.org DVB mailinglist.");
>-		if (state)
>-			kfree(state);
>-
>+		kfree(state);
> 		return NULL;
> 	}
> 
>  
>


Acked-by : Manu Abraham <manu@linuxtv.org>

Thanks,
Manu

