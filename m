Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131582AbQKNXdf>; Tue, 14 Nov 2000 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131595AbQKNXdZ>; Tue, 14 Nov 2000 18:33:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63757 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131582AbQKNXdI>;
	Tue, 14 Nov 2000 18:33:08 -0500
Message-ID: <3A11C445.EB65B9D@mandrakesoft.com>
Date: Tue, 14 Nov 2000 18:01:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c 
 compilefailure
In-Reply-To: <Pine.LNX.4.21.0011142345440.2383-100000@tricky>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> On Mon, 13 Nov 2000, Adam J. Richter wrote:
> 
> >       linux-2.4.0-test11-pre4/drivers/sound/yss225.c uses __initdata
> > but does not include <linux/init.h>, so it could not compile.  I have
> > attached below.
> >
> >       Note that I am a bit uncertain about the correctness of
> > the __initdata prefix here in the first place.  Is yss225 a PCI
> > device?  If so, a kernel that supports PCI hot plugging should
> > be prepared to support the possibility of a hot pluggable yss225
> > card being inserted after the module has already been initialized.
> > Even if no CardBus or CompactPCI version of yss225 hardware exists
> > yet, it will require less maintenance for PCI drivers to be prepared
> > for this possibility from the outset (besides, is it possible to have a
> > hot pluggable PCI bridge card that bridges to a regular PCI bus?).
> 
> Good question....

Please err on the conservative side -- IMHO you shouldn't mark a driver
as hotpluggable (by using the '__dev' prefix) unless you know it is
necessary.

Otherwise, you rob CONFIG_HOTPLUG people of some memory that could
otherwise be freed at boot.  And the number of CONFIG_HOTPLUG people is
not small, it includes not only the CardBus users but USB users too...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
