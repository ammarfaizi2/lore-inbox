Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281252AbRKMASi>; Mon, 12 Nov 2001 19:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281265AbRKMAS2>; Mon, 12 Nov 2001 19:18:28 -0500
Received: from mail213.mail.bellsouth.net ([205.152.58.153]:11410 "EHLO
	imf13bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281252AbRKMASL>; Mon, 12 Nov 2001 19:18:11 -0500
Message-ID: <3BF066AE.C33EF2B0@mandrakesoft.com>
Date: Mon, 12 Nov 2001 19:17:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] crc32 cleanups
In-Reply-To: <200111122347.fACNl2I13494@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> In article <71714C04806CD5119352009027289217022C3F15@ausxmrr502.us.dell.com> you wrote:
> > More crc32 cleanups.  I think this is pretty close to being finished, and
> > would appreciate people taking a look at the drivers they use regularly.
> > I've built all the drivers I can on x86, and have hand-verified the rest.
> >
> > Changes since last time:
> > * remove all the request_module() calls I added last time.  If a driver
> > needs crc32.o and it's a module, modprobe pulls it in automatically.
> > * Create {fs,drivers/net,drivers/usb}/Makefile.lib.  In each, list modules
> > as obj-$(CONFIG_FOO) += crc32.o.  In lib/Makefile, include each
> > Makefile.lib.  This allows drivers to update the list local to themselves
> > and not have to patch lib/Makefile.  This should satisfy Keith Owens'
> > concern in this regard.
> > * Added a whole new set of drivers, those based on 8390.o, to the list.
> 
> Do you really need that complicated conditional compilation?
> IMHO it's a much better idea to always compile the crc routines in,
> maybe a way to disable it explicitly could be added, though I'm
> not sure about that one.

Feeping creaturism.  Sure we could compile it in unconditionally... 
embedded people will grab matt's patch which allows conditional
compilation and use that instead, as will people who aren't using
crc32-related features.

The list of modules including crc32.o is definitely ugly but its just
more kernel bloat for those who don't need it.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

