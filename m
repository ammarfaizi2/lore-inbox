Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbUJ1UcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUJ1UcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUJ1U3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:29:42 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:45865 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262892AbUJ1U0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KMckSoAgXBTja81LlFBEYnfHDyyv+rdxlGGBz0G3xHnjWbYZ15cTvURR5Obj33OUfFggEASAnFy0y4IjUMVYnunC8eHOIgJ+tV9kUvkgFT7ZUrYyh6gqH4Lz0CX6ljkGBDp5h/94NhLo7Ds39mwsA56IgcdtC01DYgMPAFBVUIM=
Message-ID: <1a56ea39041028132610a1579e@mail.gmail.com>
Date: Thu, 28 Oct 2004 21:26:46 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: "blaisorblade_spam@yahoo.it" <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] uml: fix mainline lazyness about TTY layer patch
In-Reply-To: <20041028200635.3366D7436@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041028200635.3366D7436@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 22:04:51 +0200, blaisorblade_spam@yahoo.it
<blaisorblade_spam@yahoo.it> wrote:
> 
> While changing the TTY layer, an API parameter was removed, so it was removed
> by almost all calls, changing their prototype. But one use of one such
> function was not updated, breaking UML compilation. This is the fix.
> 
> Should go in directly - trivial fix.
> 
> Thanks for the breakage, too :-).
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c |    2 --
>  vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c  |    2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff -puN arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix arch/um/drivers/ssl.c
> --- vanilla-linux-2.6.9/arch/um/drivers/ssl.c~uml-mainline-is-lazy-fix  2004-10-27 01:47:58.000000000 +0200
> +++ vanilla-linux-2.6.9-paolo/arch/um/drivers/ssl.c     2004-10-27 01:48:07.000000000 +0200
> @@ -119,7 +119,7 @@ static int ssl_write(struct tty_struct *
> 
>  static void ssl_put_char(struct tty_struct *tty, unsigned char ch)
>  {
> -       line_write(serial_lines, tty, 0, &ch, sizeof(ch));
> +       line_write(serial_lines, tty, &ch, sizeof(ch));
>  }
> 
>  static void ssl_flush_chars(struct tty_struct *tty)
> diff -puN arch/um/drivers/line.c~uml-mainline-is-lazy-fix arch/um/drivers/line.c
> --- vanilla-linux-2.6.9/arch/um/drivers/line.c~uml-mainline-is-lazy-fix 2004-10-27 01:49:16.000000000 +0200
> +++ vanilla-linux-2.6.9-paolo/arch/um/drivers/line.c    2004-10-27 01:49:47.000000000 +0200
> @@ -110,7 +110,6 @@ static int flush_buffer(struct line *lin
>  int line_write(struct line *lines, struct tty_struct *tty, const char *buf, int len)
>  {
>         struct line *line;
> -       char *new;
>         unsigned long flags;
>         int n, err, i, ret = 0;
> 
> @@ -143,7 +142,6 @@ int line_write(struct line *lines, struc
>         }
>   out_up:
>         up(&line->sem);
> - out_free:
>         return(ret);
>  }
> 

http://dictionary.reference.com/search?q=lazyness
NOW who's lazy :P

-DaMouse

-- 
I know I broke SOMETHING but its their fault for not fixing it before me
