Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTGKTOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTGKS6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:58:21 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:47576
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265036AbTGKSdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:33:40 -0400
Date: Fri, 11 Jul 2003 14:48:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: switch maestro3 to new ac97
Message-ID: <20030711184822.GE16037@gtf.org>
References: <200307111815.h6BIFQET017362@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307111815.h6BIFQET017362@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:15:26PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/maestro3.c linux-2.5.75-ac1/sound/oss/maestro3.c
> --- linux-2.5.75/sound/oss/maestro3.c	2003-07-10 21:14:15.000000000 +0100
> +++ linux-2.5.75-ac1/sound/oss/maestro3.c	2003-07-11 16:47:14.000000000 +0100
> @@ -2301,9 +2301,8 @@
>  {
>      struct ac97_codec *codec;
>  
> -    if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
> +    if ((codec = ac97_alloc_codec()) == NULL)
>          return -ENOMEM;
> -    memset(codec, 0, sizeof(struct ac97_codec));
>  
>      codec->private_data = card;
>      codec->codec_read = m3_ac97_read;
> @@ -2313,13 +2312,13 @@
>  
>      if (ac97_probe_codec(codec) == 0) {
>          printk(KERN_ERR PFX "codec probe failed\n");
> -        kfree(codec);
> +        ac97_release_codec(codec);
>          return -1;
>      }
>  
>      if ((codec->dev_mixer = register_sound_mixer(&m3_mixer_fops, -1)) < 0) {
>          printk(KERN_ERR PFX "couldn't register mixer!\n");
> -        kfree(codec);
> +        ac97_release_codec(codec);


I note another positive attribute as well:

This new AC97 stuff makes object lifetime much more obvious, and makes
it easy for someone to add refcounting later, if that comes up.

This patch is an excellent example of such.

	Jeff



