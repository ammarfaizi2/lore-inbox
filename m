Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423559AbWJZPqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423559AbWJZPqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423584AbWJZPqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:46:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423558AbWJZPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:46:39 -0400
Date: Thu, 26 Oct 2006 17:46:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: David Brownell <david-b@pacbell.net>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       link@miggy.org, greg@kroah.com, akpm@osdl.org, zippel@linux-m68k.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061026154635.GK27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025201341.GH21200@miggy.org> <20061025151737.1bf4898c.randy.dunlap@oracle.com> <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061025165858.b76b4fd8.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025165858.b76b4fd8.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 04:58:58PM -0700, Randy Dunlap wrote:
>...
> Build tested with CONFIG_MII=y, m, n.
>...
> --- linux-2619-rc3-pv.orig/drivers/usb/net/usbnet.c
> +++ linux-2619-rc3-pv/drivers/usb/net/usbnet.c
> @@ -47,6 +47,12 @@
>  
>  #define DRIVER_VERSION		"22-Aug-2005"
>  
> +#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
> +#define HAVE_MII		1
> +#else
> +#define HAVE_MII		0
> +#endif
>...

I'm too lame to test it, but I bet this will break with
CONFIG_USB_USBNET=y, CONFIG_MII=m, and you'll actually need

  #if defined(CONFIG_MII) || (defined(CONFIG_MII_MODULE) && defined(MODULE))

And then there's the question whether this amount of #ifdef's is 
actually worth avoiding the "select MII"...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

