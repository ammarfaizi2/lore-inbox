Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUK0Tbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUK0Tbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUK0Tbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:31:39 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23529 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261309AbUK0Tbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:31:37 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Marcel Sebek <sebek64@post.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041127171357.GA5381@penguin.localdomain>
References: <1101565560.9988.20.camel@localhost>
	 <20041127171357.GA5381@penguin.localdomain>
Date: Sat, 27 Nov 2004 21:30:43 +0200
Message-Id: <1101583844.9988.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Sat, 2004-11-27 at 18:13 +0100, Marcel Sebek wrote:
> I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
> constructions. I'm going to to this for most of the kernel if I found
> some time.

I have patches to clean up vfree() in the kernel which I am planning to
send to the maintainers.

On Sat, 2004-11-27 at 18:13 +0100, Marcel Sebek wrote:
>  static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
> diff -urpN linux-2.6.10-rc2/sound/pci/ice1712/ak4xxx.c linux-2.6.10-rc2.changed/sound/pci/ice1712/ak4xxx.c
> --- linux-2.6.10-rc2/sound/pci/ice1712/ak4xxx.c	2004-09-13 19:45:33.000000000 +0200
> +++ linux-2.6.10-rc2.changed/sound/pci/ice1712/ak4xxx.c	2004-11-27 17:21:57.000000000 +0100
> @@ -151,8 +151,7 @@ void snd_ice1712_akm4xxx_free(ice1712_t 
>  		return;
>  	for (akidx = 0; akidx < ice->akm_codecs; akidx++) {
>  		akm4xxx_t *ak = &ice->akm[akidx];
> -		if (ak->private_value[0])
> -			kfree((void *)ak->private_value[0]);
> +		kfree(ak->private_value[0]);

Did you compile this? The type of ak->private_value seems to be unsigned
long so you need that cast here.

Please compile the kernel with allmodconfig to make sure you did not
break anything and then send these to the ALSA maintainers.

		Pekka

