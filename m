Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVKWSZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVKWSZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVKWSZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:25:45 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53059 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932147AbVKWSZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:25:44 -0500
Date: Wed, 23 Nov 2005 19:26:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Michael Krufky <mkrufky@m1k.net>, Johannes Stezenbach <js@linuxtv.org>
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123182609.GA8336@mars.ravnborg.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123174237.GO3963@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 06:42:37PM +0100, Adrian Bunk wrote:
>  EXTRA_CFLAGS += -I$(src)/..
Wonder if this compiles with O=...

> -ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
> +ifneq ($(CONFIG_VIDEO_BUF_DVB),)
>   EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
>  endif
> -ifneq ($(CONFIG_DVB_CX22702),n)
> +ifneq ($(CONFIG_DVB_CX22702),)
>   EXTRA_CFLAGS += -DHAVE_CX22702=1
>  endif
> -ifneq ($(CONFIG_DVB_OR51132),n)
> +ifneq ($(CONFIG_DVB_OR51132),)
>   EXTRA_CFLAGS += -DHAVE_OR51132=1
>  endif
> -ifneq ($(CONFIG_DVB_LGDT330X),n)
> +ifneq ($(CONFIG_DVB_LGDT330X),)
>   EXTRA_CFLAGS += -DHAVE_LGDT330X=1
>  endif
> -ifneq ($(CONFIG_DVB_MT352),n)
> +ifneq ($(CONFIG_DVB_MT352),)
>   EXTRA_CFLAGS += -DHAVE_MT352=1
>  endif
> -ifneq ($(CONFIG_DVB_NXT200X),n)
> +ifneq ($(CONFIG_DVB_NXT200X),)
>   EXTRA_CFLAGS += -DHAVE_NXT200X=1
>  endif
> -

If we stick with HAVE_XXX then please use following style:

extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
extra-cflags-$(CONFIG_DVB_CX22702)   += -DHAVE_CX22702=1
extra-cflags-$(CONFIG_DVB_OR51132)   += -DHAVE_OR51132=1
extra-cflags-$(CONFIG_DVB_LGDT330X)  += -DHAVE_LGDT330X=1
extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1

EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)

	Sam
