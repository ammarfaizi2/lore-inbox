Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSENCYo>; Mon, 13 May 2002 22:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315111AbSENCYn>; Mon, 13 May 2002 22:24:43 -0400
Received: from rj.SGI.COM ([192.82.208.96]:4566 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315101AbSENCYm>;
	Mon, 13 May 2002 22:24:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.1[345]-dj Add cpqarray_init() back into genhd.c 
In-Reply-To: Your message of "Mon, 13 May 2002 22:03:34 -0400."
             <20020514020334.GA24417@www.kroptech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 12:24:23 +1000
Message-ID: <6422.1021343063@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002 22:03:34 -0400, 
Adam Kropelin <akropel1@rochester.rr.com> wrote:
>In 2.5.13-dj1, the call to cpqarray_init() in drivers/block/genhd.c was
>dropped. I'm not sure what the intent was since the driver seems to work fine
>as a module. In case it was a mistake, here's a patch (against 2.5.15-dj1) to
>add it back in. Without it, cpqarray only works as a module. Works For Me (tm).
>
>--Adam
>
>--- linux-2.5.15-dj1-virgin/drivers/block/genhd.c	Mon May 13 21:21:59 2002
>+++ linux-2.5.15-dj1/drivers/block/genhd.c	Mon May 13 21:18:48 2002
>@@ -229,6 +229,9 @@
> 	/* This has to be done before scsi_dev_init */
> 	soc_probe();
> #endif
>+#ifdef CONFIG_BLK_CPQ_DA
>+	cpqarray_init();
>+#endif
> #ifdef CONFIG_NET
> 	net_dev_init();
> #endif

The real problem appears to be cpqarray.c, it wraps the init/exit code
in #ifdef MODULE, so the init code is only available to modules.  I
think that cpqarray.c should remove the #ifdef MODULE and use the same
init mechanism as other drivers, including module_init/exit.  I don't
have a card and the code is a mess so I am not going to attempt a patch.

