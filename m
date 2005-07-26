Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVGZJzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGZJzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 05:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGZJzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 05:55:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261655AbVGZJzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 05:55:13 -0400
Date: Tue, 26 Jul 2005 11:55:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Message-ID: <20050726095503.GK3160@stusta.de>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com> <20050724203932.GX3160@stusta.de> <0fv7e11ejvimjkfqib95n93hl34icavnbu@4ax.com> <20050724212721.GA3160@stusta.de> <cm1be15uqfvur80d1f2s3kfuls9koibsoa@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cm1be15uqfvur80d1f2s3kfuls9koibsoa@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 11:26:33AM +1000, Grant Coady wrote:
> On Sun, 24 Jul 2005 23:27:22 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> >
> >You should edit init/Kconfig to disallow CONFIG_CLEAN_COMPILE=n, since 
> >any errors you see with CONFIG_BROKEN=y aren't interesting.
> 
> Straight over the top of my head yesterday :)  Is the following 
> what you had in mind?  (current script does retry if BROKEN)
>... 
> -       depends on !CLEAN_COMPILE
> +       depends on !CLEAN_COMPILE && 0
>...

I don't know whether this will work, I was thinking about

--- linux-2.6.13-rc3-mm1/init/Kconfig.old	2005-07-26 11:47:49.000000000 +0200
+++ linux-2.6.13-rc3-mm1/init/Kconfig	2005-07-26 11:48:01.000000000 +0200
@@ -32,7 +32,7 @@
 	  drivers that are currently considered to be in the alpha-test phase.
 
 config CLEAN_COMPILE
-	bool "Select only drivers expected to compile cleanly" if EXPERIMENTAL
+	bool
 	default y
 	help
 	  Select this option if you don't even want to see the option


> Thanks,
> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

