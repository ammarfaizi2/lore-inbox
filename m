Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUITKws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUITKws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUITKws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:52:48 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:27308 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266208AbUITKwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:52:41 -0400
Message-ID: <35fb2e590409200352554e44d1@mail.gmail.com>
Date: Mon, 20 Sep 2004 11:52:40 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Greg KH <greg@kroah.com>
Subject: Re: udev is too slow creating devices
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040920041101.GB5344@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston>
	 <414D42F6.5010609@softhome.net> <cijrui$g9s$1@sea.gmane.org>
	 <20040919173221.GB2345@kroah.com>
	 <Pine.LNX.4.60.0409192004020.30139@alpha.polcom.net>
	 <20040920041101.GB5344@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 21:11:02 -0700, Greg KH <greg@kroah.com> wrote:

> On Sun, Sep 19, 2004 at 08:43:50PM +0200, Grzegorz Kulewski wrote:

> > I can imagine moving firmware loader to udev.d scripts but where
> > should I place pppd launching (for example I might have pppd or
> > ifconfig binary on nfs mounted /usr from my LAN...).

> The firmware downloader should be in the usb hotplug agent notifier
> location.  See the linux-hotplug documentation for how to do this
> properly (I thought the speedtouch driver package already did this
> properly for some reason...)

I set this up on a Debian box quite a while ago, before the packaged
stuff, but it's trivial to implement this in the hotplug scripts and
works fine - simply do a "pppd call adsl" after you've had the
firmware loader squirt down the firmware. The issue here is "what if I
have a weird setup where at init time the device is found but the
firmware loader or pppd are not available then" - well in that case
I'd argue that the system is broken because you can't expect something
to be available at init if you don't help it to be so.

Sticking pppd on an NFS volume in the original example is overly
contrived and unlikely - it'd be like me sticking fsck on an unmounted
NFS volume and expecting to be able to write some reasonbly generic
and portable initscripts. Let's have cool stuff like udev - but let's
also have some limits with potential startup headaches by having some
utilities fixed.

Cheers,

Jon.


> Use the network scripts to start up the connection when it is seen by
> the system.  Gentoo currently does this already today.
> 
> > And how udev, hotlpug and the rest of the system should hadle SATA disk
> > unpluggged in the middle of writing? And what if it will be plugged back?
> 
> udev will delete the device node.  As for your data the user is screwed
> as they did something very stupid :)
> 
> Plug the device back in, and it gets discovered, device node gets
> created, and then mounted.  That is if your SATA kernel driver supports
> hotpluggable disks.
> 
> thanks,
> 
> greg k-h
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
