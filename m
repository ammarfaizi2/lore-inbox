Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVCORvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVCORvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVCORuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:50:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261656AbVCORrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:47:18 -0500
Date: Tue, 15 Mar 2005 18:47:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3: saa7134-core.c compile error
Message-ID: <20050315174713.GT3189@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org> <20050312131813.GA3814@stusta.de> <20050314203822.08b9c63e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314203822.08b9c63e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:38:22PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  This doesn't compile with CONFIG_MODULES=n:
> > 
> >  <--  snip  -->
> > 
> >  ...
> >    CC      drivers/media/video/saa7134/saa7134-core.o
> >  drivers/media/video/saa7134/saa7134-core.c: In function `saa7134_fini':
> >  drivers/media/video/saa7134/saa7134-core.c:1215: error: `pending_registered' undeclared (first use in this function)
> 
> Like this, I guess:

This fixes the compilation for me.

> --- 25/drivers/media/video/saa7134/saa7134-core.c~saa7134-build-fix	2005-03-14 20:37:16.000000000 -0800
> +++ 25-akpm/drivers/media/video/saa7134/saa7134-core.c	2005-03-14 20:37:27.000000000 -0800
> @@ -1212,8 +1212,10 @@ static int saa7134_init(void)
>  
>  static void saa7134_fini(void)
>  {
> +#ifdef CONFIG_MODULES
>  	if (pending_registered)
>  		unregister_module_notifier(&pending_notifier);
> +#endif
>  	pci_unregister_driver(&saa7134_pci_driver);
>  }

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

