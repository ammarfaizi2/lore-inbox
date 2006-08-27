Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWH0VpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWH0VpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWH0VpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:45:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60944 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932269AbWH0VpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:45:03 -0400
Date: Sun, 27 Aug 2006 23:45:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: v4l-dvb-maintainer@linuxtv.org, Zachary Amsden <zach@vmware.com>,
       Andrew Morton <akpm@osdl.org>, Jack Lo <jlo@vmware.com>,
       Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, linux-acpi@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v4l-dvb-maintainer] Options depending on STANDALONE
Message-ID: <20060827214502.GC3574@stusta.de>
References: <44D1CC7D.4010600@vmware.com> <Pine.LNX.4.58.0608031610110.9178@shell2.speakeasy.net> <20060805105122.GT25692@stusta.de> <200608061319.00085@orion.escape-edv.de> <20060813163603.GE3543@stusta.de> <Pine.LNX.4.58.0608141400450.11273@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608141400450.11273@shell3.speakeasy.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 02:15:26PM -0700, Trent Piepho wrote:
> On Sun, 13 Aug 2006, Adrian Bunk wrote:
> > On Sun, Aug 06, 2006 at 01:18:59PM +0200, Oliver Endriss wrote:
> > > Adrian Bunk wrote:
> > > > On Thu, Aug 03, 2006 at 04:40:25PM -0700, Trent Piepho wrote:
> > > > > On Thu, 3 Aug 2006, Adrian Bunk wrote:
> > > > > > On Thu, Aug 03, 2006 at 03:56:17PM -0400, Dave Jones wrote:
> > > > > > > You're describing PREVENT_FIRMWARE_BUILD.  The text Zach quoted is from
> > > > > > > STANDALONE, which is something else completely.  That allows us to not
> > > > > > > build drivers that pull in things from /etc and the like during compile.
> > > > > > > (Whoever thought that was a good idea?)
> > > > > >
> > > > > > Is DVB_AV7110_FIRMWARE really still required?
> > > > > > ALL other drivers work without such an option.
> > > > >
> > > > > The other DVB drivers that need firmware load it when the device is opened
> > > > > or used (ie.  a channel is tuned).  At least for the ones I'm familiar
> > > > > with.  If they are compiled directly into the kernel, they can still use
> > > > > FW_LOADER since the loading won't happen until utill well after booting is
> > > > > done.
> > > > >
> > > > > For AV7110, it looks like the firmware loading is done when the driver is
> > > > > first initialized.  If AV7110 is compiled into the kernel, FW_LOADER can
> > > > > not be used.  The filesystem with the firmware won't be mounted yet.
> > > > >
> > > > > So AV7110 has an option to compile a firmware file into the driver.
> > > >
> > > > But is there a technical reason why this has to be done this way?
> 
> Is there another way to load firmware in a driver compiled into the kernel?

The CONFIG_DVB_AV7110_FIRMWARE=n code should work fine.

> > > > This is the onle (non-OSS) driver doing it this way, and Zach has a
> > > > point that this is legally questionable.
> 
> I know there are other DVB drivers that can have firmware compiled in
> instead of using FW_LOADER.  They just don't show that ability in Kconfig,
> you have to edit the driver to enable compiled in firmware.
> 
> > > This option _is_ useful because it allows allows a user to build an
> > > av7110 driver without hotplug etc. I NAK any attempt to remove it.
> >
> > If you look at the dependencies of DVB_AV7110 and the code in av7110.c
> > you'll note that your statement "it allows allows a user to build an
> > av7110 driver without hotplug" is not true.
> 
> Looks like a mistake in the Kconfig file:
> -	select FW_LOADER
> +	select FW_LOADER if DVB_AV7110_FIRMWARE=n

Sure, it could be fixed.

But the fact that it didn't work doesn't create a strong reason for 
keeping it.

And the whole "kernel without hotplug" is anyway no longer possible in 
the usual CONFIG_EMBEDDED=n case.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

