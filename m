Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946062AbWKABXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946062AbWKABXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbWKABXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:23:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3859 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946062AbWKABXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:23:47 -0500
Date: Wed, 1 Nov 2006 02:23:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Randy Dunlap <randy.dunlap@oracle.com>, akpm@osdl.org,
       zippel@linux-m68k.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, link@miggy.org,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       greg@kroah.com, toralf.foerster@gmx.de
Subject: Re: [linux-usb-devel] [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061101012346.GB27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610310940.16619.david-b@pacbell.net> <20061031180712.GQ27968@stusta.de> <200610311136.54058.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610311136.54058.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 11:36:52AM -0800, David Brownell wrote:
> 
> > > 		...
> > > 		depends on MII if MII != n
> > > 
> > > except that Kconfig doesn't comprehend conditionals like that.
> > 
> > You can express this in Kconfig:
> > 	depends MII || MII=n
> 
> Except that:
> 
> Warning! Found recursive dependency: USB_USBNET USB_NET_AX8817X MII USB_USBNET
> 
> I think this is another case where Kconfig gets in the way and forces
> introduction of a pseudovariable.  I'll give that a try.
> 
> > But my suggestion was:
> > #if defined(CONFIG_MII) || (defined(CONFIG_MII_MODULE) && defined(MODULE))
> >
> > Or simply select MII ...
> 
> Nope; those both prevent completely legit configurations.
> MII is not required, except for those two adapter options.

What should work (with the USB_NET_MCS7830 part from Randy's patch 
removed) together with your patch and the
  #if defined(CONFIG_MII) || (defined(CONFIG_MII_MODULE) && defined(MODULE))
is:

config USB_USBNET
        tristate "Multi-purpose USB Networking Framework"
        select MII if USB_NET_AX8817X!=n || USB_NET_MCS7830!=n
	---help---
	  ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

