Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVI2PZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVI2PZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVI2PZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:25:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55225 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932199AbVI2PZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:25:58 -0400
Date: Thu, 29 Sep 2005 16:25:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rio: switch to ANSI prototypes
Message-ID: <20050929152556.GU7992@ftp.linux.org.uk>
References: <20050929152208.GA18132@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929152208.GA18132@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 07:22:08PM +0400, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/rio/rioboot.c  |   25 +++++--------------------
>  drivers/char/rio/rioctrl.c  |   12 ++----------
>  drivers/char/rio/rioinit.c  |   27 +++++----------------------
>  drivers/char/rio/riointr.c  |   12 +++---------
>  drivers/char/rio/rioparam.c |   24 ++++++------------------
>  drivers/char/rio/rioroute.c |   34 +++++++---------------------------
>  drivers/char/rio/riotable.c |   19 +++++--------------
>  drivers/char/rio/riotty.c   |    3 +--
>  8 files changed, 34 insertions(+), 122 deletions(-)

Uh-oh...  Well, if you want to play with it...  FWIW, I'm disabling rio as
hopeless FPOS; if you feel masochistic, go ahead but keep in mind that its
handling of tty glue is severely b0rken.

>  int
> -RIOBootCodeHOST(p, rbp)
> -struct rio_info *	p;
> -register struct DownLoad *rbp;
> +RIOBootCodeHOST(struct rio_info *p, register struct DownLoad *rbp)

s/register//

> @@ -151,12 +151,7 @@ static int copyout (caddr_t dp, int arg,
>  }
>  
>  int
> -riocontrol(p, dev, cmd, arg, su)
> -struct rio_info	* p;
> -dev_t		dev;
> -int		cmd;
> -caddr_t		arg;
> -int		su;
> +riocontrol(struct rio_info *p, dev_t dev, int cmd, caddr_t arg, int su)

Use of dev_t here is almost certainly broken.  Use of caddr_t is *always*
broken.
