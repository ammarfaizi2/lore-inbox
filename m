Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWDMXWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWDMXWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWDMXWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:22:05 -0400
Received: from tim.rpsys.net ([194.106.48.114]:58769 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965036AbWDMXWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:22:03 -0400
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
From: Richard Purdie <rpurdie@rpsys.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pcmcia@lists.infradead.org,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       metan@seznam.cz
In-Reply-To: <20060413171425.GA12404@isilmar.linta.de>
References: <20060404122212.GG19139@elf.ucw.cz>
	 <20060404124350.GA16857@flint.arm.linux.org.uk>
	 <20060404000129.GA2590@ucw.cz>
	 <1144923105.7236.18.camel@localhost.localdomain>
	 <20060413164706.GB18635@atrey.karlin.mff.cuni.cz>
	 <20060413165452.GA7805@flint.arm.linux.org.uk>
	 <20060413171425.GA12404@isilmar.linta.de>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 00:18:34 +0100
Message-Id: <1144970315.7236.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 19:14 +0200, Dominik Brodowski wrote:
> Oh yes, mea culpa. However, we can simply remove setting res->flags here, as
> we never read it in this case anyways.
> 
> Thanks,
> 	Dominik
> 
> 
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Thu Apr 13 19:06:49 2006 +0200
> Subject: [PATCH] pcmcia: fix oops in static mapping case
> 
> As static maps do not have IO resources, this setting oopses. However, as
> we do not ever read this value, we can safely remove it.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> diff --git a/drivers/pcmcia/pcmcia_resource.c
> b/drivers/pcmcia/pcmcia_resource.c
> index 2539c0b..cc3402c 100644
> --- a/drivers/pcmcia/pcmcia_resource.c
> +++ b/drivers/pcmcia/pcmcia_resource.c
> @@ -88,7 +88,6 @@ static int alloc_io_space(struct pcmcia_
>         }
>         if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
>                 *base = s->io_offset | (*base & 0x0fff);
> -               s->io[0].res->flags = (s->io[0].res->flags &
> ~IORESOURCE_BITS) | (attr & IORESOURCE_BITS);
>                 return 0;
>         }
>         /* Check for an already-allocated window that must conflict 


I can confirm this fixes the problem I was seeing as well.

Thanks,

Richard

