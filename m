Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUK1IGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUK1IGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 03:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUK1IGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 03:06:52 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61913 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261408AbUK1IGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 03:06:51 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phil Oester <kernel@linuxace.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       sebek64@jabber.cz
In-Reply-To: <20041127212345.GA6606@linuxace.com>
References: <1101565560.9988.20.camel@localhost>
	 <20041127171357.GA5381@penguin.localdomain>
	 <1101583844.9988.6.camel@localhost>
	 <20041127204317.GA21422@penguin.localdomain>
	 <20041127212345.GA6606@linuxace.com>
Date: Sun, 28 Nov 2004 10:05:55 +0200
Message-Id: <1101629155.9996.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 09:43:17PM +0100, Marcel Sebek wrote:
> > diff -urpN linux-2.6.10/sound/core/init.c linux-2.6.10-new/sound/core/init.c
> > --- linux-2.6.10/sound/core/init.c	2004-10-23 10:55:09.000000000 +0200
> > +++ linux-2.6.10-new/sound/core/init.c	2004-11-27 21:21:50.000000000 +0100
> > @@ -665,9 +665,8 @@ int snd_card_file_remove(snd_card_t *car
> >  	spin_unlock(&card->files_lock);
> >  	if (card->files == NULL)
> >  		wake_up(&card->shutdown_sleep);
> > -	if (mfile) {
> > -		kfree(mfile);
> > -	} else {
> > +	kfree(mfile);
> > +	if (!mfile) {
> >  		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
> >  		return -ENOENT;
> >  	}

On Sat, 2004-11-27 at 13:23 -0800, Phil Oester wrote:
> The above change seems to always trigger the ENOENT return, no?

No it doesn't. kfree() does not set mfile to NULL. However, I think the
above would be more readable if we did the kfree() _after_ the NULL
check. Marcel, what do you think?

		Pekka

