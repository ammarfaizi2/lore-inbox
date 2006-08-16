Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWHPQRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWHPQRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHPQRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:17:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751115AbWHPQQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:16:59 -0400
Subject: Re: PATCH: Trivial kzalloc opportunity
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155745728.24077.354.camel@localhost.localdomain>
References: <1155745728.24077.354.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 16 Aug 2006 18:16:28 +0200
Message-Id: <1155744988.3023.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:28 +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c linux-2.6.18-rc4-mm1/drivers/char/tty_io.c
> --- linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 15:40:16.000000000 +0100
> +++ linux-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 16:01:19.000000000 +0100
> @@ -160,17 +160,11 @@
>   *	been initialized in any way but has been zeroed
>   *
>   *	Locking: none
> - *	FIXME: use kzalloc
>   */
>  
>  static struct tty_struct *alloc_tty_struct(void)
>  {
> -	struct tty_struct *tty;
> -
> -	tty = kmalloc(sizeof(struct tty_struct), GFP_KERNEL);
> -	if (tty)
> -		memset(tty, 0, sizeof(struct tty_struct));
> -	return tty;
> +	return (struct tty_struct *)kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
>  }
>  

makes you wonder why this function even exists... (and why there is a
typecast in it ;)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

