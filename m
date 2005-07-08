Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVGHH6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVGHH6G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGHH6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:58:05 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:20701 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S262074AbVGHH6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:58:04 -0400
Date: Fri, 8 Jul 2005 10:57:56 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jon Smirl <jonsmirl@gmail.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: [SOLVED] Re: 2.6.13-rc2 hangs at boot
In-Reply-To: <20050708102852.B612@den.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0507081057001.8935@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050707135928.A3314@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071324560.26776@tukki.cc.jyu.fi> <20050707163140.A4006@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071546560.29406@tukki.cc.jyu.fi> <20050707174158.A4318@jurassic.park.msu.ru>
 <Pine.GSO.4.58.0507071709170.697@tukki.cc.jyu.fi> <20050708102852.B612@den.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Fri, 08 Jul 2005 10:57:58 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ivan Kokshaysky wrote:

Thanks! Vanilla 2.6.13-rc2 with below patch applied
works perfectly!

-
Tero Roponen


> On Thu, Jul 07, 2005 at 05:13:49PM +0300, Tero Roponen wrote:
> > I applied your original patch (the no-op one) and the
> > end=0 patch. With those applied I could boot into login
> > prompt.
>
> Puzzling. None of these patches should affect your setup.
> And you still have DMA timeouts...
>
> > Attached are lspci -vv and dmesg outputs from
> > 2.6.12 and 2.6.13-rc2 kernels.
>
> The only difference is that under 2.6.13-rc2 the cardbus ranges
> are a lot bigger. With the patch here your PCI setup should be
> identical to 2.6.12. I don't think this fixes DMA problem,
> but just to be sure...
>
> Ivan.
>
> --- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
> +++ linux/drivers/pci/setup-bus.c	Fri Jul  8 10:25:20 2005
> @@ -40,8 +40,8 @@
>   * FIXME: IO should be max 256 bytes.  However, since we may
>   * have a P2P bridge below a cardbus bridge, we need 4K.
>   */
> -#define CARDBUS_IO_SIZE		(4096)
> -#define CARDBUS_MEM_SIZE	(32*1024*1024)
> +#define CARDBUS_IO_SIZE		(256)
> +#define CARDBUS_MEM_SIZE	(4*1024*1024)
>
>  static void __devinit
>  pbus_assign_resources_sorted(struct pci_bus *bus)
>
