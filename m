Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUK0VX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUK0VX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUK0VX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:23:56 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:14976
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261336AbUK0VXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:23:46 -0500
Date: Sat, 27 Nov 2004 13:23:45 -0800
From: Phil Oester <kernel@linuxace.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
Message-ID: <20041127212345.GA6606@linuxace.com>
References: <1101565560.9988.20.camel@localhost> <20041127171357.GA5381@penguin.localdomain> <1101583844.9988.6.camel@localhost> <20041127204317.GA21422@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041127204317.GA21422@penguin.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 09:43:17PM +0100, Marcel Sebek wrote:
> diff -urpN linux-2.6.10/sound/core/init.c linux-2.6.10-new/sound/core/init.c
> --- linux-2.6.10/sound/core/init.c	2004-10-23 10:55:09.000000000 +0200
> +++ linux-2.6.10-new/sound/core/init.c	2004-11-27 21:21:50.000000000 +0100
> @@ -665,9 +665,8 @@ int snd_card_file_remove(snd_card_t *car
>  	spin_unlock(&card->files_lock);
>  	if (card->files == NULL)
>  		wake_up(&card->shutdown_sleep);
> -	if (mfile) {
> -		kfree(mfile);
> -	} else {
> +	kfree(mfile);
> +	if (!mfile) {
>  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
>  		return -ENOENT;
>  	}

The above change seems to always trigger the ENOENT return, no?

Phil

