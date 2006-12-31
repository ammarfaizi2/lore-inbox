Return-Path: <linux-kernel-owner+w=401wt.eu-S1030424AbWLaSIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWLaSIi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 13:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWLaSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 13:08:37 -0500
Received: from lx1.pxnet.com ([195.227.45.3]:44005 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030424AbWLaSIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 13:08:37 -0500
Date: Sun, 31 Dec 2006 19:08:12 +0100
Message-Id: <200612311808.kBVI8Cxk018767@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] Char: tty_wakeup cleanup
Cc: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Hansjoerg Lipp <hjlipp@web.de>
References: <53003385545127333@wsc.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 23:17:00 +0100 (CET), Jiri Slaby wrote:
> tty_wakeup cleanup
> 
> - remove wake_up_interruptible(&tty->write_wait) surrounding
>   tty_wakup(tty);
> - substitute tty->ldisc.write_wakeup(tty) + wake_up() by tty_wakeup(tty);
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Tilman Schmidt <tilman@imap.cc>

(for drivers/isdn/gigaset/interface.c)

> ---
> commit 2acac8f970a75a3dc8466781845ae5d14c3d8988
> tree 396cc84d4e198d2a65cd4aa9748aabeab5681ba5
> parent 8b380d8b1c3ff7d09d68d467d2f135774cab4086
> author Jiri Slaby <jirislaby@gmail.com> Sat, 16 Dec 2006 22:22:57 +0059
> committer Jiri Slaby <jirislaby@gmail.com> Sat, 16 Dec 2006 22:22:57 +0059
[...]
> diff --git a/drivers/isdn/gigaset/interface.c b/drivers/isdn/gigaset/interface.c
> index 458b646..f13de20 100644
> --- a/drivers/isdn/gigaset/interface.c
> +++ b/drivers/isdn/gigaset/interface.c
> @@ -599,19 +599,9 @@ out:
>  static void if_wake(unsigned long data)
>  {
>  	struct cardstate *cs = (struct cardstate *) data;
> -	struct tty_struct *tty;
> -
> -	tty = cs->tty;
> -	if (!tty)
> -		return;
> -
> -	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
> -	    tty->ldisc.write_wakeup) {
> -		gig_dbg(DEBUG_IF, "write wakeup call");
> -		tty->ldisc.write_wakeup(tty);
> -	}
>  
> -	wake_up_interruptible(&tty->write_wait);
> +	if (cs->tty)
> +		tty_wakeup(cs->tty);
>  }
>  
>  /*** interface to common ***/

