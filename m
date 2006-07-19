Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWGSIi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWGSIi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWGSIi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:38:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:13583 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932529AbWGSIi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:38:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=f1XwudV6QgeTYr56fq13RxuMgWqz0HsbcAY/d3Qq/a6XrTpO3lS01h5SDva3jMaT9+Amv+ihXr2XLvaU5ps6s6nEAbbs9Kxy1KiyZu5K6bIR8FZSYjdeF1fpzxXXYiphyC5HvoOtXdm8ktMaeouLzjQ4T+YxzYGDe3Sck4oBkQc=
Message-ID: <84144f020607190138o16e596efp2f33acef0966c65e@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:38:27 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Daniel K." <daniel@cluded.net>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <44BD9BA8.7070202@cluded.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <44BD9BA8.7070202@cluded.net>
X-Google-Sender-Auth: 24460def859b6756
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, Daniel K. <daniel@cluded.net> wrote:
> > diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
> > index 5ff269f..ca0e9f2 100644
> > --- a/drivers/serial/ip22zilog.c
> > +++ b/drivers/serial/ip22zilog.c
> > @@ -925,11 +925,7 @@ static int zilog_irq = -1;
> >  static void * __init alloc_one_table(unsigned long size)
> >  {
> >       void *ret;
> > -
> > -     ret = kmalloc(size, GFP_KERNEL);
> > -     if (ret != NULL)
> > -             memset(ret, 0, size);
> > -
> > +     ret = kzalloc(size, GFP_KERNEL);
> >       return ret;
> >  }
>
> And here as well.
>
> What is preferred by developers?

That you kill useless wrappers and type casts.
