Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVL2DY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVL2DY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVL2DY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:24:28 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38568 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964928AbVL2DY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:24:28 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Date: Thu, 29 Dec 2005 04:20:11 +0100
User-Agent: KMail/1.8.2
Cc: Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com
References: <20051227215351.3d581b13.khali@linux-fr.org>
In-Reply-To: <20051227215351.3d581b13.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512290420.22636.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 27 December 2005 21:53, Jean Delvare wrote:

> I gave a try to 2.6.15-rc7 and "make menuconfig" tells me:
> Warning! Found recursive dependency: VIDEO_SAA7134_ALSA VIDEO_SAA7134_OSS
> VIDEO_SAA7134_ALSA

Hmm, I really should make this more annoying...

>  config VIDEO_SAA7134_OSS
>  	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
> -	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || 
VIDEO_SAA7134_ALSA = m)
> +	depends on VIDEO_SAA7134 && SOUND_PRIME && 
> VIDEO_SAA7134_ALSA!=y && m

The easiest fix would to just change the last part into "!VIDEO_SAA7134_ALSA".
An alternative would be to use a choice.

bye, Roman
