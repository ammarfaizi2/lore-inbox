Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWEYBd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWEYBd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWEYBd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:33:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964840AbWEYBd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:33:57 -0400
Date: Wed, 24 May 2006 18:33:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 02/11] atyfb_base compile fix for CONFIG_PCI=n
Message-Id: <20060524183327.601f0a43.akpm@osdl.org>
In-Reply-To: <20060525003420.147932000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
	<20060525003420.147932000@linux-m68k.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zippel@linux-m68k.org wrote:
>
>  The atyfb_driver structure is only available if CONFIG_PCI is set.
> 
>  Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
>  ---
> 
>   drivers/video/aty/atyfb_base.c |    4 ++++
>   1 file changed, 4 insertions(+)
> 
>  Index: linux-2.6-mm/drivers/video/aty/atyfb_base.c
>  ===================================================================
>  --- linux-2.6-mm.orig/drivers/video/aty/atyfb_base.c
>  +++ linux-2.6-mm/drivers/video/aty/atyfb_base.c
>  @@ -3861,7 +3861,9 @@ static int __init atyfb_init(void)
>       atyfb_setup(option);
>   #endif
>   
>  +#ifdef CONFIG_PCI
>       pci_register_driver(&atyfb_driver);
>  +#endif
>   #ifdef CONFIG_ATARI
>       atyfb_atari_probe();
>   #endif
>  @@ -3870,7 +3872,9 @@ static int __init atyfb_init(void)
>   
>   static void __exit atyfb_exit(void)
>   {
>  +#ifdef CONFIG_PCI
>   	pci_unregister_driver(&atyfb_driver);
>  +#endif
>   }

bah.  If pci_register_driver() was a macro we wouldn't need to do this all
over the place.

