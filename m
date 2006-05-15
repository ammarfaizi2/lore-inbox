Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWEOJxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWEOJxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWEOJxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:53:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:43179 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932332AbWEOJxI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p6oyLYw+W/JWklD8Y7OmiunTey3BCJgT5XniJGtngOxXhgWqDz+ntk3GtwocZg8QDvzkJBQ768Igp4vxMfxX7As8qsN+aM+7RTDhP6xFMiKUjStttFU7OgVpTvamDO2zQVjAh0sNz46GhtGA0h6vxhVwWbPFroJqnYW4grPr6cs=
Message-ID: <9a8748490605150253u3c69f030wd59f0619550d2060@mail.gmail.com>
Date: Mon, 15 May 2006 11:53:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Cc: linux-kernel@vger.kernel.org, "Moxa Technologies" <support@moxa.com.tw>,
       "Alan Cox" <alan@redhat.com>, "Martin Mares" <mj@ucw.cz>
In-Reply-To: <20060514141845.GB23387@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605140349.36122.jesper.juhl@gmail.com>
	 <20060514141845.GB23387@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Sun, May 14, 2006 at 03:49:35AM +0200, Jesper Juhl wrote:
> > If mxser_write() gets called with a NULL 'tty' pointer, then the initial
> > assignment of tty->driver_data to info will explode.
>
> ->write() is called via
>
>         tty->driver->write(tty, ...);
>
> See? tty was already dereferenced.
>

Yeah, you are right.



> > --- linux-2.6.17-rc4-git2-orig/drivers/char/mxser.c
> > +++ linux-2.6.17-rc4-git2/drivers/char/mxser.c
> > @@ -877,7 +877,7 @@ static int mxser_init(void)
> >
> >  static void mxser_do_softint(void *private_)
> >  {
> > -     struct mxser_struct *info = (struct mxser_struct *) private_;
> > +     struct mxser_struct *info = private_;
>
> Please, don't make unrelated changes, ever.
>
Sorry about that.
I know that's the general rule, but I guess I've been spoiled by
having some of my recent patches merged that did a few trivial things
all in one patch and people didn't seem to mind. I'll try to get out
of that habbit again.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
