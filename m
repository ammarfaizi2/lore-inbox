Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756284AbWKWLkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbWKWLkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbWKWLkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:40:09 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:50077 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756284AbWKWLkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:40:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=D9a/dI6PVV4CI/50pn3wfh7VMNnhCY7x+e4q/tSjY7YktxXNlhPcWtunYRCsU5Lpzo2FQm6GX5RyoDNqjr0JD5dDD8DGGuIXqj2URVj/qIc9qGftfTbI98JW6pQCQQCWfDcfnVzJkJD6ZJ5tnJPVAZivR2n6daeM64B9Q0aaIgQ=
Message-ID: <3ae72650611230340y750b7996s723a3f5a37a5755@mail.gmail.com>
Date: Thu, 23 Nov 2006 12:40:04 +0100
From: "Kay Sievers" <kay.sievers@vrfy.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
Cc: "Ben Collins" <ben.collins@ubuntu.com>,
       "Nicholas Miell" <nmiell@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20061123102928.GA22118@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1163374762.5178.285.camel@gullible>
	 <1163378981.2801.3.camel@entropy> <1163381067.5178.301.camel@gullible>
	 <1163382425.2801.6.camel@entropy> <1163395364.5178.327.camel@gullible>
	 <20061123102928.GA22118@kroah.com>
X-Google-Sender-Auth: 60f79a77628eafc3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Greg KH <greg@kroah.com> wrote:
> On Sun, Nov 12, 2006 at 09:22:44PM -0800, Ben Collins wrote:
> > On Sun, 2006-11-12 at 17:47 -0800, Nicholas Miell wrote:
> > > On Sun, 2006-11-12 at 17:24 -0800, Ben Collins wrote:
> > > > On Sun, 2006-11-12 at 16:49 -0800, Nicholas Miell wrote:
> > > > > On Sun, 2006-11-12 at 15:39 -0800, Ben Collins wrote:
> > > > >
> > > > > What's wrong with making udev or whatever unbind driver A and then bind
> > > > > driver B if the driver bound by the kernel ends up being the wrong
> > > > > choice? (Besides the inelegance of the kernel choosing one and then
> > > > > userspace immediately choosing the other, of course.)
> > > > >
> > > > > I'd argue that having multiple drivers for the same hardware is a bit
> > > > > strange to begin with, but that's another issue entirely.
> > > >
> > > > If two drivers are loaded for the same device, there's no way for udev
> > > > to tell the kernel which driver to use for a device, that I know of.
> > >
> > > /sys/bus/*/drivers/*/{bind,unbind}
> >
> > "bind" does not tell the driver core to "bind this device with this
> > driver", it tells it to "bind this driver to whatever devices we match
> > that aren't already bound".
>
> No it does not, it tells the driver core to "bind this device with this
> driver, _if_ the driver will accept it".
>
> > That doesn't solve my use case.
>
> Yes it does:
>         echo -n BUS_ID > /sys/bus/foo_bus/drivers/foo_driver/unbind
>         echo -n BUS_ID > /sys/bus/foo_bus/drivers/baz_driver/bind
>
> and you are set.  That's the way other distros use this functionality :)

Right, I currently port that part of SUSE's sysconfig's per-device
configuration to udev, and udev-rules will be able to specify what
driver to use for a device, including driver-unbinding/binding.

Also modprobe will be built into udev to solve the
performance-problems we see with parsing the modprobe-files for every
device with a modalias.

Kay
