Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKJK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKJK4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKJK4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:56:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37900 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750777AbVKJK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:56:52 -0500
Date: Thu, 10 Nov 2005 11:56:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, stern@rowland.harvard.edu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mdharm-usb@one-eyed-alien.net, Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-ID: <20051110105648.GC5376@stusta.de>
References: <20051107215226.GA25104@kroah.com> <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org> <20051107222840.GB26417@kroah.com> <20051108004716.GJ3847@stusta.de> <20051109222808.GG9182@kroah.com> <20051109224117.337690bf.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109224117.337690bf.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 10:41:17PM -0800, Pete Zaitcev wrote:
> On Wed, 9 Nov 2005 14:28:08 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > > What about letting the two drivers always use libusual?
> > 
> > Pete?  What do you think about this patch?
> 
> It does nothing to explain how exactly the current configuration managed
> not to work, which leaves me unsatisfied. I did test the kernel to build
> correctly with libusub on and off. All we have is this:

The problem is not that it wouldn't work.
The question is whether users compiling their kernel should know 
anything about USB_LIBUSUAL.
IMHO, USB_LIBUSUAL is an internal implementation detail and there's no 
reason why a user should ever see this option.
This is what my patch does.

The next question (not attacked by my patch) is whether we really want 
two code paths in the two USB storage drivers, or whether they should 
simply always use libusual.

> > It seems that libusual.ko is not being actually built as a module, despite being 
> > set to 'm' in .config.
> 
> Which is nonsensual, because CONFIG_USB_LIBUSUAL is a boolean.
> And reub.net is down, so I cannot fetch the erroneous .config.
> 
> I suspect that Reuben did not rerun "make oldconfig" after editing
> .config or something of that nature.

The only compile errors I know about are
  USB=y, USB_STORAGE=m, USB_LIBUSUAL=y
  BLK_DEV_UB=y/m, USB=y/m, USB_STORAGE=n, USB_LIBUSUAL=y
but this issue is easily solvable (it's the drivers/usb/Makefile part 
of my patch).

> What Adrian is proposing may be a good idea or may be not, but it has
> nothing to do with the problem.

Agreed.

> -- Pete

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

