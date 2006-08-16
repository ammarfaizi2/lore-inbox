Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWHPVx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWHPVx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWHPVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:53:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:56557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932271AbWHPVxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:53:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PMB5ZgnGysOltJlD5QWd1b0lWvUrJErena452mogLCjtjrvNIk1QEHteGurdaZUVEJwOx4bLE3y5mZn8L7rPPt0Y1IN1/6TIIWSeuwRfCNJz25UN+gXyTbZ/cJlCem75PxHhRTm2aYAiYOagI3mVNsoA5sd17L94/qoQ/2fOTAo=
Message-ID: <9a8748490608161453y58c48fa8s5a64528d01192a84@mail.gmail.com>
Date: Wed, 16 Aug 2006 23:53:24 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + tty-trivial-kzalloc-opportunity.patch added to -mm tree
Cc: mm-commits@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com
In-Reply-To: <200608162142.k7GLgMYB013117@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608162142.k7GLgMYB013117@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
>
> The patch titled
>
>      tty: trivial kzalloc opportunity
>
> has been added to the -mm tree.  Its filename is
>
>      tty-trivial-kzalloc-opportunity.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
> ------------------------------------------------------
> Subject: tty: trivial kzalloc opportunity
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  drivers/char/tty_io.c |    8 +-------
>  1 files changed, 1 insertion(+), 7 deletions(-)
>
> diff -puN drivers/char/tty_io.c~tty-trivial-kzalloc-opportunity drivers/char/tty_io.c
> --- a/drivers/char/tty_io.c~tty-trivial-kzalloc-opportunity
> +++ a/drivers/char/tty_io.c
> @@ -160,17 +160,11 @@ static void release_mem(struct tty_struc
>   *     been initialized in any way but has been zeroed
>   *
>   *     Locking: none
> - *     FIXME: use kzalloc
>   */
>
>  static struct tty_struct *alloc_tty_struct(void)
>  {
> -       struct tty_struct *tty;
> -
> -       tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
> -       if (tty)
> -               memset(tty, 0, sizeof(struct tty_struct));
> -       return tty;
> +       return (struct tty_struct *)kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
>  }
Let's get rid of the typecast - eh?
Might as well also make the function inline given that all that's left
of it is a single call to kzalloc() - and why not simply replace all
calls to this function with a call to kzalloc()?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
