Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbUJYJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUJYJjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUJYJjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:39:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261736AbUJYJjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:39:39 -0400
Date: Mon, 25 Oct 2004 11:39:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@lst.de>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH, RFC] remove dead code an exports from alsa
Message-ID: <20041025093907.GB2798@stusta.de>
References: <20041024133813.GA20174@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041024133813.GA20174@lst.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, Oct 24, 2004 at 03:38:13PM +0200, Christoph Hellwig wrote:
>...
> --- 1.37/sound/core/info.c	2004-08-15 11:03:10 +02:00
> +++ edited/sound/core/info.c	2004-10-23 15:58:41 +02:00
> @@ -126,12 +126,19 @@
>  	de->owner = THIS_MODULE;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  void snd_remove_proc_entry(struct proc_dir_entry *parent,
>  			   struct proc_dir_entry *de)
>  {
>  	if (de)
>  		remove_proc_entry(de->name, parent);
>  }
> +#else
> +static inline void snd_remove_proc_entry(struct proc_dir_entry *parent,
> +					 struct proc_dir_entry *de)
> +{
> +}
> +#endif
>  
>...

remove_proc_entry is a noop for CONFIG_PROC_FS=n, so this part shouldn't 
make any difference.

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfMm7mfzqmE8StAARAlo+AJ9tGNSeFVaeQmUUX3ScL2Gapb7fIACfSt/i
XMrRZdJQ5Zmus4TLZ040/ME=
=vHLN
-----END PGP SIGNATURE-----
