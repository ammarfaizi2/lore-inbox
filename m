Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293742AbSCETQr>; Tue, 5 Mar 2002 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293736AbSCETQl>; Tue, 5 Mar 2002 14:16:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9227 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293734AbSCETQW>; Tue, 5 Mar 2002 14:16:22 -0500
Date: Tue, 5 Mar 2002 15:09:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andries.Brouwer@cwi.nl
Cc: jurgen@pophost.eunet.be, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: [patch] Re: 2.4.19-pre2: ufs problems
In-Reply-To: <UTC200203040035.AAA137549.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.21.0203051509120.16292-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 4 Mar 2002 Andries.Brouwer@cwi.nl wrote:

> Both Gerd Knorr and Jurgen Philippaerts complain about
> problems mounting an ufs filesystem, one for BSD, the
> other for Solaris.
> The reason is the patch fragment in patch-2.4.19-pre2:
> 
> --- linux.orig/fs/ufs/super.c   Thu Feb 28 18:24:57 2002
> +++ linux/fs/ufs/super.c        Wed Feb 27 20:34:30 2002
> @@ -597,7 +597,11 @@
>         }
> 
>  again:
> -       set_blocksize (sb->s_dev, block_size);
> +       if (!set_blocksize (sb->s_dev, block_size)) {
> +               printk(KERN_ERR "UFS: failed to set blocksize\n");
> +               goto failed;
> +       }
> +
>         sb->s_blocksize = block_size;
> 
>         /*
> 
> Indeed, set_blocksize returns 0 when all is well.
> Thus, this change will always cause a failure.

Fixed in my tree.

Thanks 

