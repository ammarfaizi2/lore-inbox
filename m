Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWGFCF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWGFCF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWGFCF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:05:59 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:30820 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965126AbWGFCF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tBa2j7SrHbFxRk26QXWkmfG4j8wu4dDq6fKeu2ScBX+l2hr5miAuJm6vTwgEgsMbY+p3MIGXex/geg52nuAJ68u5nFdj7SEGz/0S/zmY4UomIYOaAv2QhSWAtwl5D2XSQv79hFs4L/PMUFrnLSKRcv+SXBYgdfJEARj7FbwPTzc=
Message-ID: <e1e1d5f40607051905w4a755a35oa1c81666fd194c83@mail.gmail.com>
Date: Wed, 5 Jul 2006 22:05:57 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Cc: "Greg KH" <greg@kroah.com>, "Alon Bar-Lev" <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <44AC49EE.1070104@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
	 <20060703222645.GA22855@kroah.com>
	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>
	 <20060703232927.GA19111@kroah.com>
	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>
	 <44ABFDD3.6040500@gentoo.org>
	 <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>
	 <44AC0B2A.9080500@gentoo.org>
	 <e1e1d5f40607051246r4d583d9arab570b5a9e8cab0c@mail.gmail.com>
	 <44AC49EE.1070104@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > If we are to have all the fingerprint readers interfaces in usermode,
> > how will this be done ?
>
> Good question. I haven't thought a great deal about it, as I mentioned
> before my TODO list is:
> 1. Get dpfp/libdpfp stable
> 2. Find or write some code which can reliably compare fingerprint
> images, hook dpfp up to that as a prototype
> 3. Solve the larger problem of finding a way to abstract fingerprint
> reading devices (and fingerprint comparison) into a common API for mass
> adoption.
>
> I'm still on (1), but I'm really glad that people are showing interest
> in (2) and (3).

Do you currently have any page/doc/wiki about the current efforts in
writing an API to handle fingerprint stuff ? (as in (3))

> Anyway, here's a really rough plan for (3): compare a number of
> fingerprint readers, looking at the functionality they offer. Find a way
> to abstract the common functionality into an API which would be used by
> a higher level. Add some API and code to compare fingerprint images, and
> maybe to glue the two together (scanning and matching). Design a modular
> system so that (to a certain extent) support for fingerprint scanning
> devices can be 'plugged in' to provide some of the functionality behind
> the scanning API that has been previously defined.
>

Yeah, that's the idea that I had in mind at first. I/we could start by
taking a look on the current API implementations from the most common
devices to get a whole idea of what's involved (for example some fancy
readers may provide ways to control a LED that indicates the state of
the device, etc, and it may be programmable, others not). We could put
everything in a Wiki separated by devices, and fix a date where we can
start discussing the first API.

> > Let's take in consideration the number of currently available usermode
> > drivers for fingerprint readers: if we are to have a centralized
> > interface to manage all the different types of fingerprint readers, we
> > need to keep this somewhere (a daemon or library providing an API to
> > access the devices in an uniform way).
>
> Yep.
>
> > In both cases, an effort is
> > involved in porting the currently available SDKs to this API in order
> > to get it working.
>
> Yep, except there aren't really any current SDKs/APIs. As I said before,
> the only driver I know about is idmouse and that doesn't offer any
> recognition capabilities, infact it doesn't even offer finger detection
> (you ask it for an image, and it will take a photo of thin air if there
> is no finger there). I don't know much about the driver or hardware, but
> I think idmouse will need to be reworked before it becomes useful.
>
> So basically we're starting from scratch.
>

Sweet =)

Well.. I was thinking about keeping that stuff on kernel more for
conservative reasons (driver == kernel). I really would like the idea
of having something very nice (and under a standard) to have
information about the devices on the system, as sysfs is progressing
to do so. I already explained in earlier e-mails about what I had in
mind, but it can only, of course, run in kernel mode. Mixing userspace
and kernel mode drivers will mess it up anyways. Imagine my wonderful
world: every device and information that you may want to know about
any device on your system is on /sys, and not only "obscure" things
like BUS ID, vendor ID, etc, but userspace-useful info like
resolution, capabilities, etc. A tool like "si" could easily parse
/sys to show everything about your system. And since all drivers (in
kernelspace) are specifically implemented to handle their devices,
they can know _exactly_ their properties, and export them.

In the real world, however, if we want to have information about our
devices, we need to sweat it from a range of ioctl()'s, /dev's and
userspace devices (sometimes direct access to memory, as I think that
the (old?) superprobe used to do). Since sysfs is an effort (between
others) to centralize such informations, why blow it by sparsing
information onto userspace ?

Even though I believe that the place for drivers is in the kernel, I
don't have _practical_ reasons to insist on that (at least for
fingerprint devices), and as I can see that this concept of userspace
vs. kernelspace drivers was already heavily discussed, I won't sweat
to find a reason to get it into the kernel... Just feel that would be
good to have everything under one single place, sounding more like a
standard.

Anyways, how idmouse got into the mainstream kernel, then ?

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
