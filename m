Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVG2NZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVG2NZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 09:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVG2NZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 09:25:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9162 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262055AbVG2NZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 09:25:50 -0400
Date: Fri, 29 Jul 2005 15:24:54 +0200 (MEST)
Message-Id: <200507291324.j6TDOsL9025646@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, teanropo@cc.jyu.fi
Subject: Re: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
Cc: gregkh@suse.de, ink@jurassic.park.msu.ru, jonsmirl@gmail.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 11:35:09 +0300 (EEST), Tero Roponen wrote:
>On Fri, 29 Jul 2005, Andrew Morton wrote:
>
>> Tero Roponen <teanropo@cc.jyu.fi> wrote:
>> >
>> > Hi,
>> >
>> > I just tested 2.6.13-rc4. At boot it prints:
>> > "dma_timer_expiry: dma status == 0x61" many times.
>> > That's the same problem as in 2.6.13-rc2.
>> >
>> > If I apply the following patch, everything seems to be fine.
>> > I'm not sure if this is the right thing to do, but it works for me.
>> >
>> > -
>> > Tero Roponen
>> >
>> >
>> > --- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
>> > +++ linux/drivers/pci/setup-bus.c	Fri Jul  8 10:25:20 2005
>> > @@ -40,8 +40,8 @@
>> >   * FIXME: IO should be max 256 bytes.  However, since we may
>> >   * have a P2P bridge below a cardbus bridge, we need 4K.
>> >   */
>> > -#define CARDBUS_IO_SIZE		(4096)
>> > -#define CARDBUS_MEM_SIZE	(32*1024*1024)
>> > +#define CARDBUS_IO_SIZE		(256)
>> > +#define CARDBUS_MEM_SIZE	(32*1024*1024)
>> >
>>
>> hm, how did you come up with that fix?  Those numbers have been like that
>> since forever.
>>
>> What's the latest 2.6 kernel which worked OK?
>>
>> Would it be possible for you to generate the `dmesg -s 100000' output for
>> both good and bad kernels, see what the differences are?
>>
>> Thanks.
>
>Hi,
>
>that patch was from Ivan Kokshaysky (http://lkml.org/lkml/2005/7/8/25)
>
>My original report is here: http://lkml.org/lkml/2005/7/6/174

The PCI changes in 2.6.13-rc2 caused a number of machines to
hang at boot, including my Athlon64 laptop. It was found that
reducing CARDBUS_IO_SIZE to 256 eliminated the hangs.

The LKML archives have the details.

/Mikael
