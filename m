Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316863AbSEVFGl>; Wed, 22 May 2002 01:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316862AbSEVFGk>; Wed, 22 May 2002 01:06:40 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:3076 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316860AbSEVFGk>;
	Wed, 22 May 2002 01:06:40 -0400
Date: Tue, 21 May 2002 22:06:40 -0700
From: Greg KH <greg@kroah.com>
To: "Maksim \(Max\) Krasnyanskiy" <maxk@qualcomm.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Message-ID: <20020522050640.GA646@kroah.com>
In-Reply-To: <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com> <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com> <5.1.0.14.2.20020521122422.06b21188@mail1.qualcomm.com> <20020521195925.GA2623@kroah.com> <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com> <5.1.0.14.2.20020521164157.06b68430@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Apr 2002 03:47:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 06:04:21PM -0700, Maksim (Max) Krasnyanskiy wrote:
> 
> >IMO, I think testing with usb-uhci.c and uhci.c is still useful, but
> >testing with the -hcd variants is the most ideal since that will be the
> >final code base.
> 
> Ok. Here is feedback on 2.5.17 uhci-hcd and usb-uhci-hcd.
> I did not notice any difference in behavior. Both have the same 
> performance, just like 2.4.19-pre8.
> 
> One-shot interrupt transfers are broken in *-hcd drivers. core/hcd.c 
> returns EINVAL if urb->interval==0.
> My Broadcom FW loader (uses usbdevfs) needs one-shot interrupts. So in 
> order to test Broadcom devices
> I changed to hcd.c to allow urb->interval==0. With that change uhci-hcd 
> works just fine, I can load fw and
> use the device. But usb-uhci-hcd kills the machine pretty hard (hw reset 
> needed).
> 
> Here is a patch for hcd.c.

Thanks for the patch.

> On a side note. Why are URBs still not SLABified ?
> Drivers still have those silly urb pools and stuff. I thought you guys were 
> gonna fix that.

It hasn't been proven that it's really needed.  95% of the current
drivers create their urbs when the device is plugged in, and then free
them when they are removed.  Making that kind of allocation into a slab
is a bit silly :)

Now if more drivers start doing fun stuff like the visor.c driver does
in the 2.5 tree, then it might make more sense to create a URB specific
slab.

thanks,

greg k-h
