Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933606AbWKQOQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbWKQOQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933612AbWKQOQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:16:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:23310 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933606AbWKQOQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:16:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dDRcP6rVU8iT7VFG7/veu4Om89OGeU9Ax4TicgKFaDYP5cr19+3bsQwljT4Fef8fScJKz+Tsy/vQdze9qq+zWBM0b4uIYqwU+E6u9p3Cp+QXMqBLOoxLetx/tEWU3ZjSE2aqFSU6aQ+QSOIlp2a3EL4qaOsuMI/7RjwwnUuMy2g=
Message-ID: <d120d5000611170616m73268428me0840444bca73dff@mail.gmail.com>
Date: Fri, 17 Nov 2006 09:16:05 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Holger Schurig" <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] usb: generic calibration support
Cc: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>, daniel.ritz@gmx.ch,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200611170912.29317.hs4233@mail.mn-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611161125.38901.hs4233@mail.mn-solutions.de>
	 <200611170024.33248.daniel.ritz-ml@swissonline.ch>
	 <200611170912.29317.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/17/06, Holger Schurig <hs4233@mail.mn-solutions.de> wrote:
> > sorry, but i have to give you a big NACK on that one:
>
> Hehe, I actually anticipated this NACK :-)
>
> > - no more modparam: it should be per-device sysfs attributes
> > (swap_xy is basically only for touchkitusb compatibility and
> >    shoud be converted to per-device sysfs attribute as well. i
> > just never got to do it)
>
> That would be okay for me.
>

Actually I think having module parameter is OK as long as we have
comlementing device attribute. Then user has an option to either
specify default value for the parameter at load/boot time or fiddle
with an individual device.

> > - calibration can be handled in userspace just fine
>
> Yes it can, and that is the most convinging argument against my
> patch.
>
> However, user-space calibration often sucks. For example, in X11
> the calibration values are stored in /etc/X11/xorg.conf, so a
> calibration program has to parse & write that file. And I've
> seen binary-only-calibration programs from vendors
> use /etc/X11/XF86Config, which doesn't exist here. Anyway, once
> you've calibrated you have to restart X-Windows, so you need to
> terminate all running X applications just because of a silly
> re-calibration. Not nice.
>

I believe tslib handles this.

> A calibration at kernel level (may it be input level or driver
> level) doesn't have this problem. I can make the level
> persistent via udev, modules.conf or other means. Even when I
> have a frame-buffer based calibration utility, the calibration
> would be OK for X11 or GTK/DirectFB as well.
>
> For me, this speaks against "Calibration is purely a user-space
> problem".
>
> > - even for in-kernel it's in the wrong place. there are other
> >   devices that report raw absolute data...so it would belong to
> >   the input layer
>
> Suppose I have a graphics tabled and a touchscreen connected at
> the same time. Can I distinguish this easily at the input layer
> level?
>
> I can very easily distinguish this at the device driver level.
> After all, the individual calibration parameters are a property
> of this individual device.
>

Yes, but evdev is the interface between input layer and userspace. If
we ever implement in-kernel calibration I think we'll add
recalibrate() method to input device structure and have EVIOCSABS
ioctl handler call it. But I'd look at tslib first. I believe Qt,
Xserver, etc support it.

-- 
Dmitry
