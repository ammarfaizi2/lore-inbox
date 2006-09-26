Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWIZOBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWIZOBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWIZOBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:01:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:481 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751513AbWIZOBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:01:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FreFQgLWvpVDpOeiWxwItRY1wPNbxUG95S5XvjsZLpjcmXTK7SrPCQG5Gh6g/5vzkpk0ZWzg3Ln/KonBMaQzScplNZtdqJcEM5MJ+UC291jIjK3QikmbhC2zoh/NLyo/K1v4Q/9iV/E4fprdLxFvDx+nfn6COoUJ8IGZ3WolTFM=
Message-ID: <d120d5000609260701q65039221rac64d043a5b55df9@mail.gmail.com>
Date: Tue, 26 Sep 2006 10:01:06 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
Cc: "Kay Sievers" <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060926134654.GB11435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11592491371254-git-send-email-greg@kroah.com>
	 <11592491451786-git-send-email-greg@kroah.com>
	 <11592491482560-git-send-email-greg@kroah.com>
	 <11592491551919-git-send-email-greg@kroah.com>
	 <11592491581007-git-send-email-greg@kroah.com>
	 <11592491611339-git-send-email-greg@kroah.com>
	 <11592491643725-git-send-email-greg@kroah.com>
	 <11592491672052-git-send-email-greg@kroah.com>
	 <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com>
	 <20060926134654.GB11435@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> On Tue, Sep 26, 2006 at 09:20:17AM -0400, Dmitry Torokhov wrote:
> > On 9/26/06, Greg KH <greg@kroah.com> wrote:
> > >From: Greg Kroah-Hartman <gregkh@suse.de>
> > >
> > >This is needed for the network class devices in order to be able to
> > >convert over to use struct device.
> > >
> >
> > Greg,
> >
> > You keep pushing out patches that merge class devices and standard
> > devices but you still have not shown the usefullness of this process.
>
> I have not?  This has been discussed before.
>

Care to send me a pointer?

> > Why do you feel the need to change internal kernel structures
> > (ever-expanding struct device to accomodate everything that is in
> > struct class_device) when it should be possible to simply adjust sysfs
> > representation of the kernel tree (moving class devices into
> > /sys/device/.. part of the tree)  to udev's liking and leave the rest
> > of the kernel alone. You have seen the patch, only minor changes in
> > driver/base/class.c are needed to accomplish the move.
>
> Think about suspend.  We want a single device tree so that the class
> gets called when a device is about to be suspended so that it could shut
> down the network queue in a common way, before the physical device is
> called.

Why can't the device itself manage it? If you want to stub out the
common parts just create a function like netdev_suspend and call it at
appropriate time.

>
> It's also needed if we want to have a single device tree in general.
> class_device was the wrong thing and is really just a duplicate of
> struct device in the first place (the driver core code implementing it
> is pretty much just a cut and paste job.)

They complement each other. They are different and need different
methods to operate.

>  The fact that we were
> arbritrary marking it different has caused problems (look at the mess
> that input causes to the class_device code, that's just not nice).
>

The only mess is that you refused to deepen the classification (i.e.
have sub-classes). If input could be a parent class and
mice/event/js/ts would grow from it it won't be such a mess.
Alternatively we could go with input vs input_intf classes if flat
classification is a must. Anyway, I don't think we want to break udev
again.

> Kay also has a long list of the reasons why, I think he's posted it here
> before.  Kay, care to send that list again?
>

Kay did send it and I agree with all his reasons as to why we need the
move. However I do not agree with your implementation.

> > I really disappointed that there was no discussion/review of the
> > implementation at all.
>
> There has not been any real implementation yet, only a few patches added
> to the core that add a few extra functionality to struct device to allow
> class_device to move that way.

If there was no real discussion why you requesting these changes to be
pulled in the mainline?

>  The patches that move the subsystems
> over will be discussed (and some already have, like networking), when
> they are ready.  Right now most of that work is being done by Kay and
> myself as a proof of concept to make sure that we can do this properly
> and that userspace can handle it well.
>
> thanks,
>
> greg k-h
>


-- 
Dmitry
