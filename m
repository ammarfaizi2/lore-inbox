Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423723AbWJaSHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423723AbWJaSHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423727AbWJaSHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:07:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9743 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423723AbWJaSHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:07:14 -0500
Date: Tue, 31 Oct 2006 19:07:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Randy Dunlap <randy.dunlap@oracle.com>, akpm@osdl.org,
       zippel@linux-m68k.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, link@miggy.org,
       Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       greg@kroah.com, toralf.foerster@gmx.de
Subject: Re: [linux-usb-devel] [PATCH 2/2] usbnet: use MII hooks only if CONFIG_MII is enabled
Message-ID: <20061031180712.GQ27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <200610281410.13679.david-b@pacbell.net> <20061028213918.GE27968@stusta.de> <200610310940.16619.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310940.16619.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:40:15AM -0700, David Brownell wrote:
> 
> > > +#if defined(CONFIG_MII) || defined(CONFIG_MII_MODULE)
> > > +#define HAVE_MII
> > >...
> > 
> > This seems to cause a CONFIG_USB_USBNET=y, CONFIG_MII=m breakage
> > (as already described earlier in this thread)?
> 
> Well, "alluded to" not described.  Fixable by the equivalent of
> 
> 	config USB_USBNET
> 		...
> 		depends on MII if MII != n
> 
> except that Kconfig doesn't comprehend conditionals like that.

You can express this in Kconfig:
	depends MII || MII=n

But my suggestion was:
#if defined(CONFIG_MII) || (defined(CONFIG_MII_MODULE) && defined(MODULE))

Or simply select MII ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

