Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbTCLS6p>; Wed, 12 Mar 2003 13:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbTCLS6o>; Wed, 12 Mar 2003 13:58:44 -0500
Received: from rj.sgi.com ([192.82.208.96]:64975 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S261842AbTCLS6n>;
	Wed, 12 Mar 2003 13:58:43 -0500
Date: Wed, 12 Mar 2003 11:08:58 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030312190858.GE26826@sgi.com>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
	Richard Henderson <rth@twiddle.net>,
	"Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20030128132406.A9195@jurassic.park.msu.ru> <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be> <20030128201057.A690@jurassic.park.msu.ru> <1043774595.536.4.camel@zion.wanadoo.fr> <20030129190647.A689@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129190647.A689@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 07:06:47PM +0300, Ivan Kokshaysky wrote:
> On Tue, Jan 28, 2003 at 06:23:15PM +0100, Benjamin Herrenschmidt wrote:
> > Disabling VGA dynamically depending on the machine have been a real pain
> > until now. With that change, it will now just be a matter for our PPC
> > implementation of pci_request_legacy_resource() to fail on machines
> > where VGA memory can't be reached.
> 
> Here's updated version of yesterday's patch that makes this possible.
> - pci_request_legacy_resource() is supposed to return two error codes:
>   -ENXIO (no such device or address), which must be treated as fatal;
>   -EBUSY, returned by request_resource() in the case of resource conflict,
>   like i386 case where the startup code reserves certain low memory regions
>   including video memory. This error can be ignored for now (at least in the
>   vgacon driver), because resource start/end fields are correctly adjusted
>   anyway.
> - Fixed bug wrt adjusting static struct resource (thanks to Jeff for
>   finding that). The vgacon can be started twice: early on startup and,
>   if this fails because we assumed the wrong bus, after PCI init when we
>   actually located the VGA card. However, static VGA resources are already
>   "fixed" after the first try, so the second attempt fails as well.
> - Make no_vga case to release VGA resources.

I like this patch, any chance of it getting in?  James, maybe you can
push it in your next update to Linus?  It may help our platform as
well, which is ia64 with lots of PCI busses...

Thanks,
Jesse
