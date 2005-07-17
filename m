Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVGQWMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVGQWMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 18:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVGQWMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 18:12:33 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:14556 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVGQWMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 18:12:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NQZiGSXIQzK9vx/5+FS4248GrYbxnBSr5fwU7rqFtyK79bmK6VeK6W84/Cuy5xa9UV6rzCDc2pvwuT6VJCVIpitF+j1LGL2EghNg99bhzyo5upp4B9K91LAolBRmA8tND9O6F8H0GKJCIB8mY2MYrT4KTW+LZShCzgaIQUfr13s=
Date: Mon, 18 Jul 2005 02:19:33 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, speedy <speedy@3d-io.com>
Subject: Re: 2.6.12.3 compile error
Message-ID: <20050717221933.GA27059@mipter.zuzino.mipt.ru>
References: <773783380.20050717214301@3d-io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773783380.20050717214301@3d-io.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 09:43:01PM +0200, speedy wrote:
>       I've got an error while compiling stock kernel 2.6.12.3
>       downloaded from kernel.org.

>       Of course, disabling all of the ATY FB driver entries fixed the
>       bug.

>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x29259): In function `atyfb_xl_init':
> drivers/video/aty/xlinit.c:256: undefined reference to `aty_st_lcd'
> make: *** [.tmp_vmlinux1] Error 1

Is this correct? Or should another defined() be added to
drivers/video/aty/atyfb_base.c:124 ?

Fix build with CONFIG_FB_ATY_XL_INIT=y, CONFIG_FB_ATY_GENERIC_LCD=n

--- linux-vanilla/drivers/video/Kconfig
+++ linux-test/drivers/video/Kconfig
@@ -1029,6 +1029,7 @@ config FB_ATY_GENERIC_LCD
 config FB_ATY_XL_INIT
 	bool "Rage XL No-BIOS Init support"
 	depends on FB_ATY_CT
+	select FB_ATY_GENERIC_LCD
 	help
 	  Say Y here to support booting a Rage XL without BIOS support.
 

