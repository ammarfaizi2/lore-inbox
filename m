Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750793AbWFEVAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFEVAR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWFEVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:00:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750793AbWFEVAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:00:15 -0400
Date: Mon, 5 Jun 2006 23:00:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, barryn@pobox.com,
        linux-kernel@vger.kernel.org, greg@kroah.com, thomas@winischhofer.net
Subject: Re: [PATCH] sisusb: fix build (Re: 2.6.17-rc5-mm3: sisusbvga build failure)
Message-ID: <20060605210013.GS3955@stusta.de>
References: <986ed62e0606042140v78dc2c7cpb3cf7793954d2dce@mail.gmail.com> <20060604220347.6f963375.rdunlap@xenotime.net> <20060604221117.b9dfdcfc.akpm@osdl.org> <20060604224512.56a194ff.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604224512.56a194ff.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 10:45:12PM -0700, Randy.Dunlap wrote:
> On Sun, 4 Jun 2006 22:11:17 -0700 Andrew Morton wrote:
> 
> > OK, but with that applied it still fails:
> > 
> > In file included from drivers/usb/misc/sisusbvga/sisusb.c:56:
> > drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: 'struct vc_data' declared inside parameter list
> > drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: its scope is only this definition or declaration, which is probably not what you want
> > drivers/usb/misc/sisusbvga/sisusb.c:1339: error: static declaration of 'sisusb_setidxreg' follows non-static declaration
> > drivers/usb/misc/sisusbvga/sisusb_init.h:819: error: previous declaration of 'sisusb_setidxreg' was here
> > drivers/usb/misc/sisusbvga/sisusb.c:1351: error: static declaration of 'sisusb_getidxreg' follows non-static declaration
> > drivers/usb/misc/sisusbvga/sisusb_init.h:821: error: previous declaration of 'sisusb_getidxreg' was here
> > drivers/usb/misc/sisusbvga/sisusb.c:1364: error: static declaration of 'sisusb_setidxregandor' follows non-static declaration
> > drivers/usb/misc/sisusbvga/sisusb_init.h:823: error: previous declaration of 'sisusb_setidxregandor' was here
> > drivers/usb/misc/sisusbvga/sisusb.c:1395: error: static declaration of 'sisusb_setidxregor' follows non-static declaration
> > drivers/usb/misc/sisusbvga/sisusb_init.h:825: error: previous declaration of 'sisusb_setidxregor' was here
> > drivers/usb/misc/sisusbvga/sisusb.c:1404: error: static declaration of 'sisusb_setidxregand' follows non-static declaration
> > drivers/usb/misc/sisusbvga/sisusb_init.h:827: error: previous declaration of 'sisusb_setidxregand' was here
> > make[1]: *** [drivers/usb/misc/sisusbvga/sisusb.o] Error 1
> > 
> > Culprit is gregkh-usb-usb-sisusbvga-possible-cleanups.patch
>...
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix build errors caused by agressive static attributes.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>...

Thanks for fixing this.

It looks good with the exception of:

> -static int
> +int
>  sisusb_setidxregmask(struct sisusb_usb_data *sisusb, int port, u8 idx,
>  							u8 data, u8 mask)
>  {
>...

This hunk doesn't seem to be required.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

